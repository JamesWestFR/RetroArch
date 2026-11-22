# Fonctions communes aux scripts de la clé USB RetroArch PS3.
# Chargé par Preparer-Cle-USB.ps1, Generer-Playlists.ps1 et Telecharger-Images.ps1 ;
# Windows PowerShell 5.1 suffit.

Set-StrictMode -Version 2
$ErrorActionPreference = 'Stop'

$DepotBases = 'https://raw.githubusercontent.com/libretro/libretro-database/master'
$Cache      = Join-Path $env:LOCALAPPDATA 'RetroArch-PS3'
$Web        = $null

# Les systèmes reconnus : dossier sous roms\, nom, base de données libretro
# (= nom de la playlist et du dossier d'images), core, extensions, dépôt
# d'images s'il diffère de la base, liste arcade (nom du zip -> titre)
function Get-Systemes {
    Import-Csv -LiteralPath (Join-Path $PSScriptRoot 'systemes.csv') -Delimiter ';' -Encoding UTF8
}

function Format-Go([double]$octets) {
    '{0:N1} Go' -f ($octets / 1GB)
}

# Écrit un texte en UTF-8 avec BOM (lisible tel quel par le Bloc-notes)
function Write-Texte([string]$chemin, [string]$texte) {
    [IO.File]::WriteAllText($chemin, $texte.Replace("`r`n", "`n").Replace("`n", "`r`n"),
        (New-Object Text.UTF8Encoding $true))
}

# La racine à préparer ou à compléter : celle donnée (lettre de lecteur ou
# dossier), sinon une clé USB choisie dans la liste. -Preparee ne garde que
# les clés qui ont déjà un dossier retroarch\roms.
function Resolve-Cible([string]$Cible, [switch]$Preparee) {
    if ($Cible) {
        if ($Cible -match '^[A-Za-z]:?\\?$') {
            $racine = $Cible.Substring(0, 1).ToUpper() + ':\'
        } else {
            $racine = $Cible
        }
        if (-not (Test-Path -LiteralPath $racine -PathType Container)) {
            throw "Introuvable : $racine"
        }
        return (Resolve-Path -LiteralPath $racine).ProviderPath
    }

    $cles = @(Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=2' |
        Where-Object { $_.Size -gt 0 })
    if ($Preparee) {
        $cles = @($cles | Where-Object {
            Test-Path -LiteralPath (Join-Path ($_.DeviceID + '\') 'retroarch\roms')
        })
    }
    if ($cles.Count -eq 0) {
        if ($Preparee) {
            throw ("Aucune clé USB préparée (avec un dossier retroarch\roms) n'est branchée.`n" +
                   "Si ta clé n'apparaît pas, donne sa lettre en paramètre, par exemple : E:")
        }
        throw ("Aucune clé USB détectée.`n" +
               "Si ta clé (ou ton disque USB) n'apparaît pas, donne sa lettre en paramètre, par exemple : E:")
    }

    Write-Host 'Clés USB branchées :'
    for ($i = 0; $i -lt $cles.Count; $i++) {
        $c = $cles[$i]
        Write-Host ('  [{0}] {1}  {2,-12} {3,-6} {4} ({5} libres)' -f ($i + 1), $c.DeviceID,
            $c.VolumeName, $c.FileSystem, (Format-Go $c.Size), (Format-Go $c.FreeSpace))
    }
    if ($cles.Count -eq 1) {
        $rep = Read-Host "Utiliser $($cles[0].DeviceID) ? (O/n)"
        if ($rep -match '^[nN]') { throw 'Annulé.' }
        return $cles[0].DeviceID + '\'
    }
    $rep = Read-Host "Numéro de la clé à utiliser (1 à $($cles.Count))"
    $n = 0
    if (-not [int]::TryParse($rep, [ref]$n) -or $n -lt 1 -or $n -gt $cles.Count) {
        throw 'Choix invalide.'
    }
    return $cles[$n - 1].DeviceID + '\'
}

# Le contenu d'une adresse, $null si elle n'existe pas (404)
function Get-Octets([string]$url) {
    if (-not $script:Web) {
        [Net.ServicePointManager]::SecurityProtocol =
            [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
        $script:Web = New-Object Net.WebClient
    }
    for ($essai = 1; ; $essai++) {
        try {
            $script:Web.Headers['User-Agent'] = 'retroarch-ps3-thumbnails'
            return , $script:Web.DownloadData($url)
        } catch {
            $ex = $_.Exception
            while ($ex -and -not ($ex -is [Net.WebException])) { $ex = $ex.InnerException }
            if ($ex -and $ex.Response -and [int]$ex.Response.StatusCode -eq 404) { return $null }
            if ($essai -ge 3) {
                throw "Téléchargement impossible ($url) : $($_.Exception.Message)"
            }
            Start-Sleep -Seconds (2 * $essai)
        }
    }
}

function Get-Url([string]$base, [string[]]$segments) {
    $base + '/' + (($segments | ForEach-Object { [Uri]::EscapeDataString($_) }) -join '/')
}

# Nom de fichier sans dossier ni extension (les chemins de la PS3 utilisent /)
function Get-Radical([string]$chemin) {
    $nom = ($chemin -split '[\\/]')[-1]
    $point = $nom.LastIndexOf('.')
    if ($point -gt 0) { $nom.Substring(0, $point) } else { $nom }
}

# Arcade : nom du zip -> titre du jeu, d'après la liste libretro-database
# (gardée 30 jours dans %LOCALAPPDATA%\RetroArch-PS3)
function Get-TitresArcade($systeme) {
    $fichier = Join-Path $Cache ('dat\' + ($systeme.dat -split '/')[-1])
    if (-not (Test-Path -LiteralPath $fichier) -or
        ((Get-Date) - (Get-Item -LiteralPath $fichier).LastWriteTime).TotalDays -gt 30) {
        Write-Host "  Liste des jeux $($systeme.nom) (libretro-database)..."
        $octets = Get-Octets (Get-Url $DepotBases ($systeme.dat -split '/'))
        if (-not $octets) { throw "Liste introuvable : $($systeme.dat)" }
        [IO.Directory]::CreateDirectory((Split-Path -Parent $fichier)) | Out-Null
        [IO.File]::WriteAllBytes($fichier, $octets)
    }
    $titres = @{}
    $re = [regex]'(?s)game \(\s*name "([^"]*)"(?:(?!\ngame \().)*?rom \( name "?([^"\s]+)'
    foreach ($m in $re.Matches([IO.File]::ReadAllText($fichier))) {
        $zip = Get-Radical $m.Groups[2].Value
        if (-not $titres.ContainsKey($zip)) { $titres[$zip] = $m.Groups[1].Value }
    }
    return $titres
}

# Les BIOS restent à côté des jeux (les cores les y cherchent), hors des listes
$MotifBios  = '(^|[^a-z0-9])bios([^a-z0-9]|$)'
$BiosArcade = @('neogeo', 'neocdz', 'pgm', 'skns', 'nmk004', 'isgsm', 'decocass',
                'cchip', 'bubsys', 'ym2608', 'midssio', 'namcoc69', 'namcoc70', 'namcoc75')

# Les fichiers cités par un .cue (pistes) ou un .m3u (disques) : seul le .cue
# ou le .m3u compte comme jeu
function Get-FichiersCites($fichiers) {
    $cites = @{}
    foreach ($f in $fichiers) {
        $ext = $f.Extension.ToLower()
        if ($ext -ne '.cue' -and $ext -ne '.m3u') { continue }
        foreach ($ligne in [IO.File]::ReadAllLines($f.FullName)) {
            $ref = $null
            if ($ext -eq '.m3u') {
                $ligne = $ligne.Trim()
                if ($ligne -and -not $ligne.StartsWith('#')) { $ref = ($ligne -split '\|')[0] }
            } elseif ($ligne -match '^\s*FILE\s+"([^"]+)"' -or $ligne -match '^\s*FILE\s+(\S+)') {
                $ref = $Matches[1]
            }
            if (-not $ref) { continue }
            try {
                $cites[[IO.Path]::GetFullPath([IO.Path]::Combine($f.DirectoryName, $ref)).ToLower()] = $true
            } catch { }
        }
    }
    return $cites
}

# Les jeux d'un dossier roms\<système>, sous-dossiers compris :
#   .Jeux     les jeux { Fichier ; Libelle }, le titre venant de la liste
#             libretro pour l'arcade, du nom de fichier sinon
#   .Ignores  les fichiers écartés, avec la raison
#   .Fichiers le nombre de fichiers du dossier
function Get-JeuxDossier($systeme, [string]$dossier) {
    $exts = @($systeme.extensions.ToLower() -split '\|' | ForEach-Object { '.' + $_ })
    $tous = @(Get-ChildItem -LiteralPath $dossier -File -Recurse |
        Where-Object { -not $_.Name.StartsWith('.') -and $_.Name -ne 'LISEZMOI.txt' })
    $jeux = New-Object Collections.Generic.List[object]
    $ignores = New-Object Collections.Generic.List[string]
    $fichiers = @($tous | Where-Object { $exts -contains $_.Extension.ToLower() })
    if ($fichiers) {
        $cites = Get-FichiersCites $fichiers
        $fichiers = @($fichiers | Where-Object { -not $cites.ContainsKey($_.FullName.ToLower()) })
        # Un même jeu sous plusieurs formats (jeu.sfc et jeu.zip) : un seul,
        # dans l'ordre des extensions de systemes.csv
        $fichiers = @($fichiers | Group-Object { ($_.DirectoryName + '\' + $_.BaseName).ToLower() } |
            ForEach-Object { $_.Group | Sort-Object { [array]::IndexOf($exts, $_.Extension.ToLower()) } |
                Select-Object -First 1 })
        $titres = $null
        if ($systeme.dat) { $titres = Get-TitresArcade $systeme }
        foreach ($f in $fichiers) {
            $libelle = $f.BaseName
            if ($f.Name -match $MotifBios -or ($titres -and $BiosArcade -contains $libelle)) {
                $ignores.Add($f.Name + ' (BIOS)')
                continue
            }
            if ($titres) {
                if (-not $titres.ContainsKey($libelle)) {
                    $ignores.Add($f.Name + ' (inconnu des listes arcade)')
                    continue
                }
                $libelle = $titres[$libelle]
            }
            $jeux.Add([pscustomobject]@{ Fichier = $f; Libelle = $libelle })
        }
    }
    [pscustomobject]@{ Jeux = $jeux; Ignores = $ignores; Fichiers = $tous.Count }
}

# Pour les fenêtres ouvertes par double-clic : le message reste lisible
function Invoke-Script([scriptblock]$corps) {
    try {
        & $corps
    } catch {
        Write-Host ''
        Write-Host $_.Exception.Message -ForegroundColor Red
        exit 1
    }
}

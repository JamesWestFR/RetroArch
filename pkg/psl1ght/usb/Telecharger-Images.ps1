<#
.SYNOPSIS
    Télécharge les images et jaquettes des jeux d'une clé USB RetroArch PS3.

.DESCRIPTION
    Cherche les images dans les dépôts libretro-thumbnails sur GitHub, pour :
      - les jeux des listes de retroarch\playlists, écrites par
        Generer-Playlists.cmd ou par le scan de RetroArch sur la PS3 ;
      - les fichiers de retroarch\roms\<système> qu'aucune liste ne cite encore,
        d'après leur nom (le titre, pour l'arcade, vient des listes libretro-database).
    Chaque image est réduite (côté le plus long <= -Taille pixels, pour la mémoire
    et le temps de chargement sur PS3), puis enregistrée là où RetroArch la cherche :
        retroarch\thumbnails\<liste de jeux>\Named_Boxarts\<nom du jeu>.png
    Les images déjà présentes sont gardées, sauf avec -Remplacer.
    Le meilleur résultat s'obtient après le scan sur la PS3 : relance alors ce script.

.PARAMETER Cible
    Lettre de la clé (E: ou E), ou un dossier qui contient retroarch\roms
    (C:\RPCS3\dev_usb000 pour RPCS3). Sans ce paramètre, le script cherche
    les clés USB déjà préparées.

.PARAMETER Types
    Les sortes d'images, séparées par des virgules : boxarts (jaquettes),
    titles (écrans titre), snaps (captures en jeu), logos. Par défaut
    boxarts,titles : celles qu'affiche l'interface (jaquette à droite,
    écran titre à gauche).

.PARAMETER Taille
    Côté le plus long des images, en pixels (512 par défaut).

.PARAMETER Remplacer
    Télécharge à nouveau les images déjà présentes.
#>
param(
    [string]$Cible,
    [string]$Types = 'boxarts,titles',
    [int]$Taille = 512,
    [switch]$Remplacer
)

. (Join-Path $PSScriptRoot 'commun.ps1')
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Web.Extensions

$DepotsImages = 'https://raw.githubusercontent.com/libretro-thumbnails'
$TypesImages  = @{ boxarts = 'Named_Boxarts'; titles = 'Named_Titles'
                   snaps   = 'Named_Snaps';   logos  = 'Named_Logos' }

# Les caractères que RetroArch remplace par _ dans les noms d'images (gfx_thumbnail.c)
function Format-Nom([string]$nom) {
    $nom -replace '[&*/:`"<>?\\|]', '_'
}

function Get-Champ($dico, [string]$cle) {
    if ($dico -and $dico.ContainsKey($cle)) { [string]$dico[$cle] } else { '' }
}

# Réduit l'image et l'enregistre en PNG (24 bits, ou 32 si elle a de la transparence)
function Save-Image([byte[]]$octets, [string]$dest, [int]$max) {
    $flux = New-Object IO.MemoryStream(, $octets)
    $img = $null; $bmp = $null; $g = $null; $attr = $null
    try {
        $img = [Drawing.Image]::FromStream($flux)
        $echelle = [Math]::Min(1.0, $max / [double][Math]::Max($img.Width, $img.Height))
        $l = [Math]::Max(1, [int][Math]::Round($img.Width * $echelle))
        $h = [Math]::Max(1, [int][Math]::Round($img.Height * $echelle))
        $alpha = [Drawing.Image]::IsAlphaPixelFormat($img.PixelFormat)
        if (-not $alpha -and
            [int]($img.PixelFormat -band [Drawing.Imaging.PixelFormat]::Indexed) -ne 0) {
            foreach ($c in $img.Palette.Entries) { if ($c.A -lt 255) { $alpha = $true; break } }
        }
        if ($alpha) { $format = [Drawing.Imaging.PixelFormat]::Format32bppArgb }
        else        { $format = [Drawing.Imaging.PixelFormat]::Format24bppRgb }
        $bmp = New-Object Drawing.Bitmap($l, $h, $format)
        $g = [Drawing.Graphics]::FromImage($bmp)
        $g.InterpolationMode  = [Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $g.PixelOffsetMode    = [Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $g.CompositingQuality = [Drawing.Drawing2D.CompositingQuality]::HighQuality
        $attr = New-Object Drawing.Imaging.ImageAttributes
        $attr.SetWrapMode([Drawing.Drawing2D.WrapMode]::TileFlipXY)
        $g.DrawImage($img, (New-Object Drawing.Rectangle(0, 0, $l, $h)),
            0, 0, $img.Width, $img.Height, [Drawing.GraphicsUnit]::Pixel, $attr)
        [IO.Directory]::CreateDirectory([IO.Path]::GetDirectoryName($dest)) | Out-Null
        $tmp = $dest + '.tmp'
        $bmp.Save($tmp, [Drawing.Imaging.ImageFormat]::Png)
        Move-Item -LiteralPath $tmp -Destination $dest -Force
    } finally {
        foreach ($o in @($attr, $g, $bmp, $img, $flux)) { if ($o) { $o.Dispose() } }
    }
}

Invoke-Script {
    $sortes = @($Types -split ',' | Where-Object { $_.Trim() } | ForEach-Object {
        $t = $_.Trim().ToLower()
        if (-not $TypesImages.ContainsKey($t)) {
            throw "Type d'image inconnu : $t (possibles : boxarts, titles, snaps, logos)"
        }
        $TypesImages[$t]
    })
    $racine = Resolve-Cible $Cible -Preparee
    $ra = Join-Path $racine 'retroarch'
    if (-not (Test-Path -LiteralPath (Join-Path $ra 'roms'))) {
        throw "Pas de dossier retroarch\roms dans $racine : lance d'abord Preparer-Cle-USB.cmd."
    }
    $thumbs = Join-Path $ra 'thumbnails'
    $systemes = @(Get-Systemes)
    $depots = @{}
    foreach ($s in $systemes) { if ($s.depot) { $depots[$s.base] = $s.depot } }

    $jeux = New-Object Collections.Generic.List[object]
    $vus = @{}
    function Add-Jeu([string]$base, [string]$libelle, [string]$radical) {
        if (-not $libelle) { $libelle = $radical }
        if (-not $libelle) { return }
        if ($depots.ContainsKey($base)) { $d = @($depots[$base]) } else { $d = @($base -replace ' ', '_') }
        $noms = New-Object Collections.Generic.List[string]
        foreach ($n in @($libelle, $radical, ($libelle -split ' \(')[0])) {
            if ($n -and -not $noms.Contains((Format-Nom $n))) { $noms.Add((Format-Nom $n)) }
        }
        $jeux.Add([pscustomobject]@{ Base = $base; Libelle = $libelle; Noms = $noms; Depots = $d })
    }

    # 1. Les listes écrites par le scan de RetroArch
    $json = New-Object Web.Script.Serialization.JavaScriptSerializer
    $json.MaxJsonLength = [int]::MaxValue
    $dossierListes = Join-Path $ra 'playlists'
    $listes = @()
    if (Test-Path -LiteralPath $dossierListes) {
        $listes = @(Get-ChildItem -LiteralPath $dossierListes -Filter *.lpl -File)
    }
    foreach ($lpl in $listes) {
        try {
            $data = $json.DeserializeObject([IO.File]::ReadAllText($lpl.FullName, [Text.Encoding]::UTF8))
        } catch {
            Write-Warning "Liste illisible, ignorée : $($lpl.Name)"
            continue
        }
        if (-not $data -or -not $data.ContainsKey('items')) { continue }
        foreach ($e in $data['items']) {
            $base = Get-Champ $e 'db_name'
            if ($base) { $base = Get-Radical $base } else { $base = $lpl.BaseName }
            $chemin = Get-Champ $e 'path'
            $vus[$base + '|' + (Get-Radical ($chemin -split '#')[0])] = $true
            Add-Jeu $base (Get-Champ $e 'label') (Get-Radical ($chemin -split '#')[-1])
        }
    }
    $depuisListes = $jeux.Count

    # 2. Les fichiers des dossiers roms\<système> qu'aucune liste ne cite
    $ignores = 0
    foreach ($s in $systemes) {
        $dossier = Join-Path $ra ('roms\' + $s.dossier)
        if (-not (Test-Path -LiteralPath $dossier)) { continue }
        $contenu = Get-JeuxDossier $s $dossier
        $ignores += $contenu.Ignores.Count
        foreach ($j in $contenu.Jeux) {
            $radical = $j.Fichier.BaseName
            if ($vus.ContainsKey($s.base + '|' + $radical)) { continue }
            Add-Jeu $s.base $j.Libelle $radical
        }
    }

    if ($jeux.Count -eq 0) {
        throw "Aucun jeu trouvé dans $ra : copie des jeux dans roms\<système> (voir roms\LISEZMOI.txt)."
    }
    Write-Host ("{0} jeux : {1} des listes de RetroArch, {2} d'après les noms de fichiers" -f
        $jeux.Count, $depuisListes, ($jeux.Count - $depuisListes))
    if ($ignores) { Write-Host "  ($ignores fichiers ignorés : BIOS, ou zip arcade inconnus des listes libretro)" }

    # 3. Téléchargement
    $nouvelles = 0; $presentes = 0
    $absentes = New-Object Collections.Generic.List[string]
    $i = 0
    foreach ($j in $jeux) {
        $i++
        $faites = @()
        foreach ($sorte in $sortes) {
            $dest = [IO.Path]::Combine($thumbs, $j.Base, $sorte, $j.Noms[0] + '.png')
            if (-not $Remplacer -and (Test-Path -LiteralPath $dest)) { $presentes++; continue }
            $octets = $null
            :depots foreach ($depot in $j.Depots) {
                foreach ($nom in $j.Noms) {
                    $octets = Get-Octets (Get-Url $DepotsImages @($depot, 'master', $sorte, ($nom + '.png')))
                    if ($octets) { break depots }
                }
            }
            $ok = $false
            if ($octets) {
                try { Save-Image $octets $dest $Taille; $ok = $true }
                catch { Write-Warning "Image illisible pour $($j.Libelle) : $($_.Exception.Message)" }
            }
            if ($ok) {
                $nouvelles++
                $faites += ($sorte -replace '^Named_', '').ToLower()
            } else {
                $absentes.Add("$($j.Base) / $sorte / $($j.Libelle)")
            }
        }
        if ($faites) {
            Write-Host ("  [{0}/{1}] {2} : {3}" -f $i, $jeux.Count, $j.Libelle, ($faites -join ', '))
        }
    }

    Write-Host ''
    Write-Host ("Images : {0} téléchargées, {1} déjà présentes, {2} introuvables" -f
        $nouvelles, $presentes, $absentes.Count) -ForegroundColor Green
    $rapport = Join-Path $thumbs 'images-introuvables.txt'
    if ($absentes.Count) {
        Write-Texte $rapport (($absentes -join "`n") + "`n")
        Write-Host "Liste des images introuvables : $rapport"
        if ($depuisListes -lt $jeux.Count) {
            Write-Host 'Astuce : après le scan sur la PS3, relance ce script ; les noms exacts'
            Write-Host 'des jeux trouvent souvent les images manquantes.'
        }
    } elseif (Test-Path -LiteralPath $rapport) {
        Remove-Item -LiteralPath $rapport
    }
}

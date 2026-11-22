<#
.SYNOPSIS
    Crée les listes de jeux (playlists) RetroArch d'une clé USB RetroArch PS3.

.DESCRIPTION
    Parcourt chaque dossier retroarch\roms\<système>, sous-dossiers compris, et
    écrit une liste par système dans retroarch\playlists, avec le core du
    système comme core par défaut : chaque jeu se lance directement, sans
    choisir de core. Exemple : les jeux de roms\fbneo vont dans
    « FBNeo - Arcade Games.lpl » et se lancent avec FinalBurn Neo.

    Le nom affiché est celui du fichier (les noms No-Intro donnent les
    meilleurs résultats) ; pour l'arcade, c'est le titre du jeu d'après les
    listes libretro-database (mslug.zip : Metal Slug - Super Vehicle-001).
    Restent hors des listes : les BIOS (gba_bios.bin, neogeo.zip...), les
    fichiers cités par un .cue ou un .m3u, et pour l'arcade les zip que les
    listes libretro ne connaissent pas.

    Les listes portent le nom des bases libretro, comme celles du scan de
    RetroArch : les images de Telecharger-Images.cmd s'affichent avec. Les
    listes des systèmes trouvés sont remplacées, les autres ne sont pas
    touchées. Sur la PS3, Réglages > Listes de lecture > Gérer les listes
    de lecture permet ensuite de changer le core d'une liste (Cœur par
    défaut) ou de la compléter après ajout de jeux (Rafraîchir la liste de
    lecture).

.PARAMETER Cible
    Lettre de la clé (E: ou E), ou un dossier qui contient retroarch\roms
    (C:\RPCS3\dev_usb000 pour RPCS3). Sans ce paramètre, le script cherche
    les clés USB déjà préparées.

.PARAMETER Cores
    Un autre core que celui par défaut, pour certains dossiers. Exemple :
    -Cores gba=vba_next,megadrive=picodrive
#>
param(
    [string]$Cible,
    [string]$Cores
)

. (Join-Path $PSScriptRoot 'commun.ps1')

# Les cores du paquet RetroArch PS3, avec le nom que leur donnent leurs .info
# (display_name) : RetroArch retrouve le core d'une liste par ce nom quand il
# la rafraîchit
$DossierCores = '/dev_hdd0/game/SSNE10001/USRDIR/cores'
$NomsCores = @{
    bluemsx           = 'MSX/SVI/ColecoVision/SG-1000 (blueMSX)'
    cap32             = 'Amstrad - CPC/GX4000 (Caprice32)'
    fbneo             = 'Arcade (FinalBurn Neo)'
    fceumm            = 'Nintendo - NES / Famicom (FCEUmm)'
    fuse              = 'Sinclair - ZX Spectrum (Fuse)'
    gambatte          = 'Nintendo - Game Boy / Color (Gambatte)'
    genesis_plus_gx   = 'Sega - MS/GG/MD/CD (Genesis Plus GX)'
    gpsp              = 'Nintendo - Game Boy Advance (gpSP)'
    handy             = 'Atari - Lynx (Handy)'
    mame2003_plus     = 'Arcade (MAME 2003-Plus)'
    mednafen_ngp      = 'SNK - Neo Geo Pocket / Color (Beetle NeoPop)'
    mednafen_pce_fast = 'NEC - PC Engine / CD (Beetle PCE FAST)'
    mednafen_wswan    = 'Bandai - WonderSwan/Color (Beetle Wonderswan)'
    neocd             = 'SNK - Neo Geo CD (NeoCD)'
    picodrive         = 'Sega - MS/GG/MD/CD/32X (PicoDrive)'
    prosystem         = 'Atari - 7800 (ProSystem)'
    snes9x2010        = 'Nintendo - SNES / SFC (Snes9x 2010)'
    stella2014        = 'Atari - 2600 (Stella 2014)'
    vba_next          = 'Nintendo - Game Boy Advance (VBA Next)'
}

# Une chaîne JSON, échappée comme le fait RetroArch
function Format-Json([string]$texte) {
    $e = $texte.Replace('\', '\\').Replace('"', '\"')
    $e = [regex]::Replace($e, '[\x00-\x1f]',
        [Text.RegularExpressions.MatchEvaluator] { param($m) '\u{0:x4}' -f [int][char]$m.Value })
    '"' + $e + '"'
}

Invoke-Script {
    $racine = Resolve-Cible $Cible -Preparee
    $ra = Join-Path $racine 'retroarch'
    $roms = Join-Path $ra 'roms'
    if (-not (Test-Path -LiteralPath $roms)) {
        throw "Pas de dossier retroarch\roms dans $racine : lance d'abord Preparer-Cle-USB.cmd."
    }
    $systemes = @(Get-Systemes)

    # Le core de chaque dossier : le premier cité dans systemes.csv, sauf -Cores
    $coreDe = @{}
    foreach ($s in $systemes) { $coreDe[$s.dossier] = ($s.core -split '\s+')[0] }
    foreach ($paire in @($Cores -split ',' | Where-Object { $_.Trim() })) {
        $morceaux = $paire.Split('=')
        if ($morceaux.Count -ne 2 -or -not $coreDe.ContainsKey($morceaux[0].Trim())) {
            throw "Paramètre -Cores incompris : $paire (exemple : -Cores gba=vba_next)"
        }
        $c = $morceaux[1].Trim().ToLower()
        if (-not $NomsCores.ContainsKey($c)) {
            throw "Core inconnu : $c (possibles : $(($NomsCores.Keys | Sort-Object) -join ', '))"
        }
        $coreDe[$morceaux[0].Trim()] = $c
    }

    # Les chemins tels que la PS3 les voit. Si la clé est branchée sur un
    # autre port, RetroArch les corrige tout seul (listes « portables »)
    $usb = '/dev_usb000'
    $cfg = Join-Path $ra 'retroarch.cfg'
    if (Test-Path -LiteralPath $cfg) {
        $m = Select-String -LiteralPath $cfg -Pattern '^rgui_browser_directory\s*=\s*"(/dev_usb\d{3})/retroarch/roms"' |
            Select-Object -First 1
        if ($m) { $usb = $m.Matches[0].Groups[1].Value }
    }
    $baseContenu = $usb + '/retroarch/roms'

    $sousDossiers = @{}
    foreach ($d in Get-ChildItem -LiteralPath $roms -Directory) { $sousDossiers[$d.Name] = $d }
    $dossierListes = Join-Path $ra 'playlists'
    [IO.Directory]::CreateDirectory($dossierListes) | Out-Null
    $utf8 = New-Object Text.UTF8Encoding $false
    $total = 0; $ecrites = 0

    foreach ($s in $systemes) {
        if (-not $sousDossiers.ContainsKey($s.dossier)) { continue }
        $dossier = $sousDossiers[$s.dossier]
        $sousDossiers.Remove($s.dossier)
        $contenu = Get-JeuxDossier $s $dossier.FullName
        foreach ($i in $contenu.Ignores) { Write-Host "  roms\$($dossier.Name) : $i, laissé hors de la liste" }
        if ($contenu.Jeux.Count -eq 0) {
            if ($contenu.Fichiers -gt $contenu.Ignores.Count) {
                Write-Warning ("roms\{0} : aucun jeu reconnu parmi {1} fichiers (extensions attendues : {2})" -f
                    $dossier.Name, $contenu.Fichiers, ($s.extensions -replace '\|', ' '))
            }
            continue
        }
        $jeux = @($contenu.Jeux | Sort-Object Libelle | ForEach-Object {
            $relatif = $_.Fichier.FullName.Substring($roms.Length).TrimStart('\').Replace('\', '/')
            [pscustomobject]@{ Chemin = $baseContenu + '/' + $relatif; Libelle = $_.Libelle }
        })

        # Comme une liste du scan manuel de RetroArch : jeux en DETECT, core
        # par défaut au niveau de la liste, et de quoi la rafraîchir sur la PS3
        $core = $coreDe[$s.dossier]
        $nomListe = $s.base + '.lpl'
        $l = New-Object Collections.Generic.List[string]
        $l.Add('{')
        $l.Add('  "version": "1.5",')
        $l.Add('  "default_core_path": ' + (Format-Json "$DossierCores/${core}_libretro_psl1ght.SELF") + ',')
        $l.Add('  "default_core_name": ' + (Format-Json $NomsCores[$core]) + ',')
        $l.Add('  "base_content_directory": ' + (Format-Json $baseContenu) + ',')
        $l.Add('  "label_display_mode": 0,')
        $l.Add('  "right_thumbnail_mode": 0,')
        $l.Add('  "left_thumbnail_mode": 0,')
        $l.Add('  "thumbnail_match_mode": 0,')
        $l.Add('  "sort_mode": 0,')
        $l.Add('  "scan_content_dir": ' + (Format-Json ($baseContenu + '/' + $dossier.Name)) + ',')
        $l.Add('  "scan_file_exts": ' + (Format-Json $s.extensions.ToLower()) + ',')
        $l.Add('  "scan_dat_file_path": "",')
        $l.Add('  "scan_database_name": ' + (Format-Json $nomListe) + ',')
        $l.Add('  "scan_search_recursively": true,')
        $l.Add('  "scan_search_archives": false,')
        $l.Add('  "scan_filter_dat_content": false,')
        $l.Add('  "scan_omit_db_ref": false,')
        $l.Add('  "scan_overwrite_playlist": false,')
        $l.Add('  "scan_db_usage": 1,')
        $l.Add('  "items": [')
        for ($i = 0; $i -lt $jeux.Count; $i++) {
            $l.Add('    {')
            $l.Add('      "path": ' + (Format-Json $jeux[$i].Chemin) + ',')
            $l.Add('      "label": ' + (Format-Json $jeux[$i].Libelle) + ',')
            $l.Add('      "core_path": "DETECT",')
            $l.Add('      "core_name": "DETECT",')
            $l.Add('      "crc32": "00000000|crc",')
            $l.Add('      "db_name": ' + (Format-Json $nomListe))
            if ($i -lt $jeux.Count - 1) { $l.Add('    },') } else { $l.Add('    }') }
        }
        $l.Add('  ]')
        $l.Add('}')

        $dest = Join-Path $dossierListes $nomListe
        $etat = 'créée'
        if (Test-Path -LiteralPath $dest) { $etat = 'remplacée' }
        $tmp = $dest + '.tmp'
        [IO.File]::WriteAllText($tmp, ($l -join "`n") + "`n", $utf8)
        Move-Item -LiteralPath $tmp -Destination $dest -Force
        Write-Host ('{0,-16} {1,4} jeux  {2} ({3}), {4}' -f
            $dossier.Name, $jeux.Count, $nomListe, $NomsCores[$core], $etat)
        $total += $jeux.Count
        $ecrites++
    }

    foreach ($nom in $sousDossiers.Keys) {
        Write-Warning "roms\$nom : dossier inconnu, ignoré (les noms possibles sont dans roms\LISEZMOI.txt)"
    }
    if ($ecrites -eq 0) {
        throw "Aucun jeu trouvé dans $roms : copie des jeux dans roms\<système> (voir roms\LISEZMOI.txt)."
    }
    Write-Host ''
    Write-Host "$ecrites listes, $total jeux, dans $dossierListes" -ForegroundColor Green
    Write-Host 'Ensuite : Telecharger-Images.cmd pour les jaquettes, puis la clé sur la PS3.'
}

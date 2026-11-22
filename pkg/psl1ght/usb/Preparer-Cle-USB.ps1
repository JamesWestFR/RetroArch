<#
.SYNOPSIS
    Prépare une clé USB pour RetroArch PS3.

.DESCRIPTION
    Crée à la racine de la clé :
        retroarch\roms\<système>   les jeux, un dossier par système
        retroarch\bios             les BIOS (et les samples arcade, voir bios\LISEZMOI.txt)
        retroarch\thumbnails       les images et jaquettes (Telecharger-Images.cmd)
        retroarch\playlists        les listes de jeux (Generer-Playlists.cmd)
    avec un LISEZMOI.txt dans retroarch, roms et bios.

    Quand RetroArch démarre sur la PS3 avec cette clé branchée, il utilise la
    configuration de la clé (retroarch\retroarch.cfg, créée au premier
    lancement à partir de celle de la console). Sans la clé, il garde celle
    de la console, inchangée.

    Le script ne supprime ni ne remplace aucun fichier existant, sauf les
    LISEZMOI.txt qu'il a lui-même écrits. Il peut être relancé sans risque.

.PARAMETER Cible
    Lettre de la clé (E: ou E), ou un dossier : C:\RPCS3\dev_usb000 pour
    tester avec RPCS3. Sans ce paramètre, le script liste les clés USB.

.PARAMETER Force
    Continue même si la clé n'est pas en FAT32 (seul format lu par la PS3).
#>
param(
    [string]$Cible,
    [switch]$Force
)

. (Join-Path $PSScriptRoot 'commun.ps1')

$LisezmoiRacine = @'
RetroArch PS3 : clé USB de jeux
================================

Tant que cette clé est branchée au lancement de RetroArch sur la PS3,
RetroArch utilise sa configuration à elle (retroarch.cfg dans ce dossier,
créé au premier lancement à partir de celle de la console) :
  - le navigateur de fichiers s'ouvre sur roms ;
  - les BIOS sont lus dans bios ;
  - les images et jaquettes sont lues dans thumbnails ;
  - les listes de jeux sont écrites dans playlists.
Sans la clé, RetroArch reprend la configuration de la console, inchangée.
Les sauvegardes de jeu restent sur la console, avec chaque utilisateur.
Pour repartir de la configuration de la console, supprime retroarch.cfg ici.

Mode d'emploi
  1. Copie tes jeux dans roms\<système> (voir roms\LISEZMOI.txt),
     tes BIOS dans bios (voir bios\LISEZMOI.txt).
  2. Sur le PC, lance Generer-Playlists.cmd : une liste de jeux par
     système, chaque jeu lancé directement avec le bon core.
  3. Lance Telecharger-Images.cmd : il récupère les jaquettes des jeux.
  4. Branche la clé sur la PS3 et lance RetroArch.
Après un ajout de jeux, relance les étapes 2 et 3, ou sur la PS3 :
Réglages > Listes de lecture > Gérer les listes de lecture > (la liste)
> Rafraîchir la liste de lecture.

La PS3 ne lit que les clés formatées en FAT32 (fichiers de 4 Go au plus).
'@

$LisezmoiBios = @'
BIOS de RetroArch (le « dossier système » des cores)
=====================================================

Les noms doivent être exactement ceux-ci, majuscules comprises.
Aucun BIOS n'est fourni : utilise ceux de tes propres consoles.

Indispensables
  Machines\  et  Databases\  MSX, MSX2, ColecoVision (core blueMSX) :
                              les deux dossiers fournis avec le core
                              blueMSX de libretro, copiés tels quels ici
  neocd\ : un BIOS et un Y-ZOOM Neo Geo CD (core neocd), par exemple
                              neocd\neocd_f.rom (ou neocd_t.rom, neocd_z.rom,
                              front-sp1.bin, top-sp1.bin, neocd.bin)
                              et neocd\000-lo.lo (ou neocd\ng-lo.rom)
  bios_CD_E.bin, bios_CD_U.bin, bios_CD_J.bin
                              Mega-CD Europe, USA, Japon (selon tes jeux)
  syscard3.pce                PC Engine CD (syscard1.pce, syscard2.pce ou
                              gexpress.pce selon les jeux)
  disksys.rom                 Famicom Disk System

Facultatifs
  gba_bios.bin                Game Boy Advance : conseillé avec gpsp, qui a
                              un BIOS de remplacement mais fait mieux
                              tourner certains jeux avec l'original
  lynxboot.img                Atari Lynx
  7800 BIOS (U).rom           Atari 7800
  gb_bios.bin, gbc_bios.bin   Game Boy, Game Boy Color (logo au démarrage)
  bios_MD.bin, bios_E.sms, bios_U.sms, bios_J.sms, bios.gg
                              Mega Drive, Master System, Game Gear
  fuse\                       ZX Spectrum Pentagon et Scorpion uniquement

Arcade
  FinalBurn Neo   neogeo.zip (et les autres BIOS arcade : pgm.zip, ...)
                  avec les jeux dans roms\fbneo, ou dans bios\fbneo
                  hiscore.dat dans bios\fbneo pour les meilleurs scores
                  samples : bios\fbneo\samples\<jeu>.zip
  MAME 2003-Plus  neogeo.zip avec les jeux dans roms\mame
                  samples : bios\mame2003-plus\samples\<jeu>.zip
  Les samples doivent être rangés là : ces deux cores ne les cherchent
  nulle part ailleurs.
'@

Invoke-Script {
    $racine = Resolve-Cible $Cible
    $ra = Join-Path $racine 'retroarch'

    # FAT32 : vérifiable seulement à la racine d'un lecteur
    if ($racine -match '^[A-Za-z]:\\$') {
        $id = $racine.Substring(0, 2)
        $disque = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='$id'"
        if ($disque -and $disque.FileSystem -ne 'FAT32') {
            $msg = "$id est en $($disque.FileSystem) : la PS3 ne lit que les clés en FAT32.`n" +
                   "Formate-la en FAT32 (cela efface son contenu), puis relance ce script.`n" +
                   "Au-delà de 32 Go, Windows ne propose pas FAT32 : il faut un outil comme FAT32 Format (guiformat)."
            if (-not $Force) { throw $msg }
            Write-Warning $msg
        }
    }

    $systemes = @(Get-Systemes)
    $dossiers = @('bios', 'bios\fbneo\samples', 'bios\mame2003-plus\samples',
                  'thumbnails', 'playlists', 'roms') +
                @($systemes | ForEach-Object { 'roms\' + $_.dossier })
    $crees = 0
    foreach ($d in $dossiers) {
        $chemin = Join-Path $ra $d
        if (-not (Test-Path -LiteralPath $chemin)) {
            New-Item -ItemType Directory -Path $chemin | Out-Null
            $crees++
        }
    }

    # roms\LISEZMOI.txt : la table des dossiers, tirée de systemes.csv
    $lignes = @('Un dossier par système', '======================', '',
                'Les jeux se rangent dans le dossier de leur système. Les sous-dossiers',
                'sont permis. Generer-Playlists.cmd fait une liste par dossier, avec',
                'le core indiqué ci-dessous (le premier, quand il y en a deux ; pour',
                'l''autre : Generer-Playlists.cmd -Cores gba=vba_next).', '',
                ('{0,-16} {1,-30} {2,-18} {3}' -f 'Dossier', 'Système', 'Core', 'Extensions'),
                ('{0,-16} {1,-30} {2,-18} {3}' -f '-------', '-------', '----', '----------'))
    foreach ($s in $systemes) {
        $lignes += ('{0,-16} {1,-30} {2,-18} {3}' -f $s.dossier, $s.nom, $s.core,
                    ($s.extensions -replace '\|', ' '))
    }
    $lignes += @('', 'Arcade : garde les zip tels quels (un zip par jeu, nom d''origine :',
                 'mslug.zip, viewpoin.zip...), avec neogeo.zip à côté des jeux Neo Geo.')

    Write-Texte (Join-Path $ra 'LISEZMOI.txt') $LisezmoiRacine
    Write-Texte (Join-Path $ra 'bios\LISEZMOI.txt') $LisezmoiBios
    Write-Texte (Join-Path $ra 'roms\LISEZMOI.txt') (($lignes -join "`n") + "`n")

    Write-Host ''
    Write-Host "Clé prête : $ra ($crees dossiers créés, $($systemes.Count) systèmes)" -ForegroundColor Green
    Write-Host ''
    Write-Host 'Ensuite :'
    Write-Host '  1. Copie tes jeux dans roms\<système> et tes BIOS dans bios'
    Write-Host '     (voir les LISEZMOI.txt de chaque dossier).'
    Write-Host '  2. Lance Generer-Playlists.cmd : les listes de jeux, avec le bon core.'
    Write-Host '  3. Lance Telecharger-Images.cmd pour les jaquettes.'
    Write-Host '  4. Branche la clé sur la PS3 et lance RetroArch.'
}

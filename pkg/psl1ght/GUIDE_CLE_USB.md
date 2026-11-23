# RetroArch PS3 v2026 — Guide pas à pas

**Installer RetroArch sur la PS3 et préparer une clé USB de jeux prête à l'emploi**

> [!IMPORTANT]
> **Version non officielle.** RetroArch PS3 v2026 est un portage **non officiel** de RetroArch pour PlayStation 3. Il n'est **ni affilié à libretro ou à Sony, ni approuvé par eux**. C'est un projet de loisir, **gratuit et sans but lucratif**. Aucun jeu, BIOS ou clé n'est fourni : utilisez uniquement des copies de jeux et de BIOS que vous avez le droit de posséder.

> [!WARNING]
> **État actuel : testé uniquement dans l'émulateur RPCS3**, clé USB comprise. L'installation et le fonctionnement sur une vraie PS3, en CFW comme en HEN, n'ont pas encore été vérifiés. Sur les 19 émulateurs fournis, les 10 derniers ajoutés (de Beetle PCE Fast à NeoCD dans le [guide d'installation](INSTALL.md)) n'ont pas encore été essayés.

Ce guide s'adresse à quelqu'un qui n'a jamais utilisé RetroArch. Il suppose seulement que votre PS3 a déjà un **CFW** ou **HEN** (voir la section 1). Les détails techniques sont dans le [guide d'installation](INSTALL.md).

**À la fin, vous aurez :**
- RetroArch installé sur la PS3, avec 19 émulateurs (on dit des « cores ») ;
- une clé USB qui contient vos jeux, rangés par console, avec leurs jaquettes ;
- sur la PS3, une liste de jeux par console, où chaque jeu se lance directement avec le bon émulateur, sans rien régler ;
- vos sauvegardes et vos réglages en sécurité sur la console.

**Durée** : une demi-heure, plus le temps de copier les jeux et de télécharger les images.

---

## Sommaire

- [Les étapes en bref](#les-étapes-en-bref)
- [1. Ce qu'il vous faut](#1-ce-quil-vous-faut)
- [2. Comment ça marche](#2-comment-ça-marche)
- [3. Formater la clé en FAT32 (PC)](#3-formater-la-clé-en-fat32-pc)
- [4. Installer RetroArch sur la PS3](#4-installer-retroarch-sur-la-ps3)
- [5. Préparer la clé : Preparer-Cle-USB (PC)](#5-préparer-la-clé--preparer-cle-usb-pc)
- [6. Copier vos jeux (PC)](#6-copier-vos-jeux-pc)
- [7. Copier les BIOS (PC)](#7-copier-les-bios-pc)
- [8. Créer les listes de jeux : Generer-Playlists (PC)](#8-créer-les-listes-de-jeux--generer-playlists-pc)
- [9. Télécharger les images : Telecharger-Images (PC)](#9-télécharger-les-images--telecharger-images-pc)
- [10. Jouer sur la PS3](#10-jouer-sur-la-ps3)
- [11. Avec ou sans la clé : ce qui change](#11-avec-ou-sans-la-clé--ce-qui-change)
- [12. Régler l'affichage des jeux](#12-régler-laffichage-des-jeux)
- [13. Ajouter des jeux plus tard](#13-ajouter-des-jeux-plus-tard)
- [14. Mettre à jour RetroArch](#14-mettre-à-jour-retroarch)
- [15. Essayer sans PS3, avec l'émulateur RPCS3](#15-essayer-sans-ps3-avec-lémulateur-rpcs3)
- [16. En cas de problème](#16-en-cas-de-problème)
- [Annexe A. Donner des options aux scripts](#annexe-a-donner-des-options-aux-scripts)
- [Annexe B. Ajouter vos propres images](#annexe-b-ajouter-vos-propres-images)

---

## Les étapes en bref

| | Où | Quoi | Section |
|---|---|---|---|
| 1 | PC | Formater la clé USB en FAT32 | [3](#3-formater-la-clé-en-fat32-pc) |
| 2 | PS3 | Installer le PKG, lancer RetroArch une fois, puis le quitter | [4](#4-installer-retroarch-sur-la-ps3) |
| 3 | PC | Double-cliquer sur **`Preparer-Cle-USB.cmd`** | [5](#5-préparer-la-clé--preparer-cle-usb-pc) |
| 4 | PC | Copier les jeux dans `retroarch\roms\<console>` | [6](#6-copier-vos-jeux-pc) |
| 5 | PC | Copier les BIOS dans `retroarch\bios` | [7](#7-copier-les-bios-pc) |
| 6 | PC | Double-cliquer sur **`Generer-Playlists.cmd`** | [8](#8-créer-les-listes-de-jeux--generer-playlists-pc) |
| 7 | PC | Double-cliquer sur **`Telecharger-Images.cmd`** | [9](#9-télécharger-les-images--telecharger-images-pc) |
| 8 | PS3 | Brancher la clé **avant** de lancer RetroArch, puis jouer | [10](#10-jouer-sur-la-ps3) |

---

## 1. Ce qu'il vous faut

### La console
- Une **PS3 avec un CFW ou HEN**.
  - Un **CFW** (*Custom Firmware*) est un système modifié, installé une fois pour toutes.
  - **HEN** (*Homebrew Enabler*) s'active à chaque démarrage de la console, avant de lancer RetroArch.
  - Ce guide n'explique pas comment les installer : suivez un guide dédié à votre modèle de PS3. Sans l'un des deux, la PS3 refuse le fichier d'installation de RetroArch.
- Une **manette DualShock 3**, configurée automatiquement.

### Une clé USB
- N'importe quelle clé USB, ou un disque dur USB.
- **Elle sera formatée** : tout son contenu sera effacé. Copiez ailleurs ce que vous voulez garder.
- **Taille** : 8 Go suffisent pour des centaines de jeux à cartouche. Un jeu sur CD (Mega-CD, PC Engine CD, Neo Geo CD) prend de 100 à 700 Mo. Comptez en plus environ 0,5 Mo d'images par jeu.
- La PS3 ne lit que les clés au format **FAT32**, qui n'accepte pas de fichier de plus de 4 Go. Aucun jeu des consoles prises en charge n'atteint cette taille.

### Un PC sous Windows 10 ou 11
- **Rien à installer** : les scripts utilisent PowerShell, déjà présent dans Windows.
- **Une connexion Internet**, pour les images et les titres des jeux d'arcade.
  - Les scripts téléchargent uniquement depuis GitHub, sur les dépôts publics de libretro (`libretro-database` et `libretro-thumbnails`).
  - Ils n'envoient rien.

### Les fichiers de RetroArch PS3 v2026
Prenez-les tous sur la page de la même version.

**Le fichier d'installation (PKG)**, l'un des deux :

| Fichier | Pour |
|---|---|
| `RetroArch_PS3_v2026.gnpdrm.pkg` | **HEN et CFW**. C'est celui à prendre en cas de doute. |
| `RetroArch_PS3_v2026.pkg` | CFW uniquement. |

**Les scripts de la clé USB**, dans le fichier **`RetroArch_PS3_v2026_scripts_cle_USB.zip`**. Il contient 8 fichiers à garder **ensemble dans le même dossier** :

| Fichier | Rôle |
|---|---|
| `Preparer-Cle-USB.cmd` | Crée les dossiers sur la clé |
| `Generer-Playlists.cmd` | Crée les listes de jeux |
| `Telecharger-Images.cmd` | Télécharge les jaquettes |
| `Preparer-Cle-USB.ps1`, `Generer-Playlists.ps1`, `Telecharger-Images.ps1`, `commun.ps1`, `systemes.csv` | Utilisés par les trois précédents. Ne les déplacez pas et ne les lancez pas directement. |

### Vos jeux et vos BIOS
Aucun n'est fourni. Les jeux sont des fichiers « ROM » ou des images de CD. Les BIOS sont des fichiers système que certaines consoles demandent (voir la section 7).

---

## 2. Comment ça marche

Tout se répartit entre deux endroits.

| La PS3 | La clé USB |
|---|---|
| RetroArch lui-même : le programme, les 19 émulateurs, les menus, les shaders. Installé par le PKG. | Vos **jeux**, vos **BIOS**, vos **listes de jeux** et leurs **images**, dans un dossier `retroarch`. |
| Tout ce qui vous est personnel : **sauvegardes** de jeux, réglages des émulateurs, historique, favoris. Chaque utilisateur de la PS3 a les siens. | Les **réglages de RetroArch** à utiliser avec cette clé. |

**À chaque lancement, RetroArch cherche une clé « préparée »**, c'est-à-dire une clé dont le dossier `retroarch` contient les dossiers `roms`, `bios` et `thumbnails`.
- **S'il en trouve une**, il l'utilise : ses listes de jeux, ses images, ses BIOS et ses réglages.
- **Sinon**, il fonctionne comme d'habitude, avec les réglages de la console. La clé ne les modifie jamais.

Les trois scripts font sur le PC le travail fastidieux :
1. `Preparer-Cle-USB` crée les dossiers et des fichiers d'aide (`LISEZMOI.txt`).
2. `Generer-Playlists` fabrique une liste de jeux par console, avec le bon émulateur.
3. `Telecharger-Images` récupère les jaquettes et les écrans titre.

**La clé terminée ressemble à ceci** (`E:` est la lettre de la clé sur le PC) :

```
E:\
├── RetroArch_PS3_v2026.gnpdrm.pkg        le fichier d'installation (peut être supprimé ensuite)
└── retroarch\
    ├── LISEZMOI.txt                      le mode d'emploi
    ├── retroarch.cfg                     les réglages, créés par la PS3 au premier lancement
    ├── roms\                             les jeux, un dossier par console
    │   ├── LISEZMOI.txt                  la liste des dossiers
    │   ├── nes\                          Super Mario Bros. (World).nes
    │   ├── megadrive\                    Sonic The Hedgehog (USA, Europe).md
    │   ├── fbneo\                        mslug.zip, neogeo.zip
    │   └── ...                           (29 dossiers en tout)
    ├── bios\                             les BIOS
    │   ├── LISEZMOI.txt                  la liste des BIOS
    │   ├── fbneo\samples\
    │   └── mame2003-plus\samples\
    ├── playlists\                        les listes de jeux (Generer-Playlists)
    │   ├── Nintendo - Nintendo Entertainment System.lpl
    │   └── ...
    └── thumbnails\                       les images (Telecharger-Images)
        ├── Nintendo - Nintendo Entertainment System\
        │   ├── Named_Boxarts\Super Mario Bros. (World).png
        │   └── Named_Titles\Super Mario Bros. (World).png
        └── ...
```

---

## 3. Formater la clé en FAT32 (PC)

> [!CAUTION]
> Formater **efface tout** le contenu de la clé.

**Votre clé est peut-être déjà en FAT32.** Dans l'Explorateur de fichiers, faites un clic droit sur la clé, puis *Propriétés*. Si *Système de fichiers* indique **FAT32**, passez à la section 4.

**Clé de 32 Go ou moins :**
1. Branchez la clé sur le PC.
2. Ouvrez l'Explorateur de fichiers (touches **Windows + E**), puis *Ce PC*.
3. Faites un clic droit sur la clé, puis *Formater…*
4. *Système de fichiers* : **FAT32**. Laissez la taille d'unité d'allocation par défaut. Le *nom de volume* est libre, par exemple `RETROARCH`.
5. Cochez *Formatage rapide*, cliquez sur *Démarrer*, puis sur *OK*.

**Clé de plus de 32 Go :** Windows ne propose pas FAT32 au-delà de 32 Go. Utilisez un petit outil gratuit comme **FAT32 Format** (`guiformat.exe`) : choisissez la lettre de la clé, cochez *Quick Format*, puis cliquez sur *Start*.

---

## 4. Installer RetroArch sur la PS3

### 4.1 Copier le PKG sur la clé
1. Copiez le fichier PKG **à la racine** de la clé, c'est-à-dire directement dans `E:\`, pas dans un dossier.
2. Éjectez la clé proprement : clic droit sur la clé dans l'Explorateur, puis *Éjecter*.
3. Branchez-la sur la PS3.

### 4.2 Installer

**En CFW :**
1. Dans le menu de la PS3, colonne *Jeu*, ouvrez *Package Manager*. Sur certains CFW, il s'appelle « ★ Install Package Files ».
2. Choisissez *Install Package Files*, puis *Standard*, puis le fichier PKG.

**En HEN :**
1. Activez HEN, comme à chaque démarrage de la console.
2. Dans la colonne *Jeu*, ouvrez *Package Manager*, puis *Install Package Files*, puis *Standard*.
3. Choisissez **`RetroArch_PS3_v2026.gnpdrm.pkg`**.

Les noms des menus peuvent varier selon le CFW et la version de HEN.

RetroArch apparaît dans la colonne *Jeu* sous le nom **« RetroArch v2026 (non officiel) »** sur une console en français, ou **« RetroArch v2026 (unofficial) »** dans les autres langues.

### 4.3 Premier lancement
1. Avec HEN, vérifiez qu'il est activé.
2. Lancez *RetroArch v2026*.
3. Le menu s'affiche dans la langue de la console, avec une musique de fond, et la manette fonctionne tout de suite.
4. RetroArch s'ouvre sur la page *Listes de lecture*, encore sans jeux. Appuyez sur la touche de retour (**Rond** en Europe) pour atteindre le *Menu principal*.
5. Pour cette première fois, il n'y a rien à faire. Quittez par ***Menu principal > Quitter***.

> [!TIP]
> **Prenez l'habitude de quitter RetroArch par *Menu principal > Quitter*.** C'est à ce moment qu'il enregistre ses réglages. Si vous éteignez la console ou revenez au menu de la PS3 autrement, les réglages changés depuis le lancement sont perdus.

Le fichier PKG peut maintenant être supprimé de la clé.

---

## 5. Préparer la clé : Preparer-Cle-USB (PC)

### 5.1 Débloquer et extraire les scripts
Les scripts sont dans le fichier `RetroArch_PS3_v2026_scripts_cle_USB.zip`. Windows se méfie des fichiers venus d'Internet : débloquez-le avant de l'extraire.
1. Faites un clic droit sur le `.zip`, puis *Propriétés*.
2. En bas de l'onglet *Général*, cochez **Débloquer** (s'il est présent), puis cliquez sur *OK*.
3. Faites un clic droit sur le `.zip`, puis *Extraire tout…*, et choisissez un dossier du PC, par exemple `Documents\RetroArch-PS3`.

Gardez les scripts sur le PC : ils n'ont pas besoin d'être sur la clé.

Si, au premier lancement d'un script, Windows affiche :
- « **Windows a protégé votre ordinateur** » : cliquez sur *Informations complémentaires*, puis *Exécuter quand même* ;
- « **Avertissement de sécurité** » : cliquez sur *Exécuter*.

### 5.2 Lancer le script
1. Branchez la clé sur le PC.
2. Double-cliquez sur **`Preparer-Cle-USB.cmd`**. Une fenêtre noire s'ouvre.
3. Le script affiche les clés USB branchées et vous demande laquelle utiliser :
   ```
   Clés USB branchées :
     [1] E:  RETROARCH    FAT32  14,9 Go (14,8 Go libres)
   Utiliser E: ? (O/n)
   ```
   - Avec une seule clé, tapez **O** puis **Entrée** (ou seulement **Entrée**).
   - Avec plusieurs clés, tapez le **numéro** de la bonne, puis **Entrée**.
4. Le script crée les dossiers et termine par :
   ```
   Clé prête : E:\retroarch (35 dossiers créés, 29 systèmes)

   Ensuite :
     1. Copie tes jeux dans roms\<système> et tes BIOS dans bios
        (voir les LISEZMOI.txt de chaque dossier).
     2. Lance Generer-Playlists.cmd : les listes de jeux, avec le bon core.
     3. Lance Telecharger-Images.cmd pour les jaquettes.
     4. Branche la clé sur la PS3 et lance RetroArch.
   ```
5. Appuyez sur une touche pour fermer la fenêtre.

**Ce script ne supprime et ne remplace aucun fichier**, sauf les `LISEZMOI.txt` qu'il a lui-même écrits. Vous pouvez le relancer sans risque, par exemple après une mise à jour qui ajoute des consoles.

**Si le script affiche une erreur :**
- « *E: est en NTFS : la PS3 ne lit que les clés en FAT32* » (ou exFAT) : formatez la clé (section 3), puis relancez le script.
- « *Aucune clé USB détectée* » : la clé n'est pas branchée, ou c'est un **disque dur USB**, que Windows ne présente pas comme une clé. Donnez alors sa lettre au script (voir l'[annexe A](#annexe-a-donner-des-options-aux-scripts)) : `Preparer-Cle-USB.cmd E:`

---

## 6. Copier vos jeux (PC)

Ouvrez `E:\retroarch\roms` : il contient un dossier par console. Copiez chaque jeu dans le dossier de sa console, avec l'Explorateur (copier, puis coller).

### 6.1 Les dossiers

| Dossier | Console | Émulateur | Fichiers reconnus |
|---|---|---|---|
| `nes` | Nintendo NES / Famicom | FCEUmm | `.nes` `.unif` `.unf` `.zip` `.7z` |
| `fds` | Famicom Disk System | FCEUmm | `.fds` `.zip` `.7z` |
| `snes` | Super Nintendo / Super Famicom | Snes9x 2010 | `.smc` `.sfc` `.fig` `.swc` `.bsx` `.gd3` `.gd7` `.dx2` `.zip` `.7z` |
| `gb` | Game Boy | Gambatte | `.gb` `.dmg` `.zip` `.7z` |
| `gbc` | Game Boy Color | Gambatte | `.gbc` `.zip` `.7z` |
| `gba` | Game Boy Advance | gpSP (ou VBA Next) | `.gba` `.zip` `.7z` |
| `mastersystem` | Master System | Genesis Plus GX | `.sms` `.zip` `.7z` |
| `megadrive` | Mega Drive / Genesis | Genesis Plus GX | `.md` `.gen` `.smd` `.bin` `.zip` `.7z` |
| `megacd` | Mega-CD / Sega CD | Genesis Plus GX | `.cue` `.chd` `.iso` `.m3u` |
| `sega32x` | Sega 32X | PicoDrive | `.32x` `.zip` `.7z` |
| `gamegear` | Game Gear | Genesis Plus GX | `.gg` `.zip` `.7z` |
| `sg1000` | SG-1000 | Genesis Plus GX | `.sg` `.zip` `.7z` |
| `fbneo` | Arcade | FinalBurn Neo | `.zip` `.7z` |
| `mame` | Arcade | MAME 2003-Plus | `.zip` |
| `neogeocd` | Neo Geo CD | NeoCD | `.cue` `.chd` |
| `pcengine` | PC Engine / TurboGrafx-16 | Beetle PCE Fast | `.pce` `.zip` `.7z` |
| `pcenginecd` | PC Engine CD | Beetle PCE Fast | `.cue` `.ccd` `.chd` `.toc` `.m3u` |
| `atari2600` | Atari 2600 | Stella 2014 | `.a26` `.bin` `.zip` `.7z` |
| `atari7800` | Atari 7800 | ProSystem | `.a78` `.bin` `.zip` `.7z` |
| `atarilynx` | Atari Lynx | Handy | `.lnx` `.lyx` `.zip` `.7z` |
| `ngp` | Neo Geo Pocket | Beetle NeoPop | `.ngp` `.zip` `.7z` |
| `ngpc` | Neo Geo Pocket Color | Beetle NeoPop | `.ngc` `.ngpc` `.npc` `.zip` `.7z` |
| `wonderswan` | WonderSwan | Beetle WonderSwan | `.ws` `.zip` `.7z` |
| `wonderswancolor` | WonderSwan Color | Beetle WonderSwan | `.wsc` `.pc2` `.zip` `.7z` |
| `msx` | MSX | blueMSX | `.rom` `.ri` `.mx1` `.dsk` `.cas` `.zip` `.7z` |
| `msx2` | MSX2 | blueMSX | `.rom` `.mx2` `.dsk` `.cas` `.zip` `.7z` |
| `colecovision` | ColecoVision | blueMSX | `.col` `.rom` `.zip` `.7z` |
| `amstradcpc` | Amstrad CPC | Caprice32 | `.dsk` `.sna` `.cdt` `.tap` `.voc` `.cpr` `.m3u` `.zip` |
| `zxspectrum` | ZX Spectrum | Fuse | `.tzx` `.tap` `.z80` `.rzx` `.scl` `.trd` `.dsk` `.sna` `.szx` `.zip` |

Le même tableau se trouve sur la clé, dans `retroarch\roms\LISEZMOI.txt`.

### 6.2 Les règles à suivre
- **Ne renommez pas les dossiers** et ne les supprimez pas, même vides. En particulier, sans `roms`, `bios` et `thumbnails`, la PS3 ne reconnaît plus la clé.
- **Les sous-dossiers sont permis**, par exemple `roms\snes\RPG\`. Leurs jeux vont dans la même liste que ceux du dossier de la console.
- **Le nom du fichier compte.** Sans son extension, il devient le nom affiché dans la liste, et il sert à trouver l'image du jeu.
  - Les noms des collections de référence (« No-Intro » pour les cartouches, « Redump » pour les CD) donnent les meilleurs résultats, par exemple `Sonic The Hedgehog (USA, Europe).md`.
  - Un nom raccourci comme `sonic.md` fonctionne, mais l'image a moins de chances d'être trouvée.
- **Jeux compressés** : pour les cartouches, `.zip` et `.7z` sont acceptés, à raison d'un jeu par archive.
- **Un même jeu en deux formats** (`jeu.sfc` et `jeu.zip`) n'apparaît qu'une fois dans la liste.
- **Jeux sur CD** (Mega-CD, PC Engine CD, Neo Geo CD) :
  - Gardez le `.cue` et ses `.bin` **ensemble, dans le même dossier**. Seul le `.cue` apparaît dans la liste.
  - Le format `.chd` tient en un seul fichier par disque et prend moins de place.
  - Pour un jeu sur plusieurs disques, un fichier `.m3u` qui liste les disques en fait une seule entrée.
- **Ordinateurs** (MSX, Amstrad CPC, ZX Spectrum) : certains jeux demandent de taper des commandes. L'utilisation d'un clavier USB n'a pas encore été testée.

### 6.3 Arcade : des règles particulières
- **Un `.zip` par jeu, avec son nom d'origine** (`mslug.zip`, `sf2.zip`…). Ne le décompressez pas et ne le renommez pas : c'est son nom qui identifie le jeu. Le titre affiché dans la liste vient des listes de libretro (`mslug.zip` devient « Metal Slug - Super Vehicle-001 »).
- **La version des jeux doit correspondre à celle de l'émulateur** :
  - dossier `fbneo` : des jeux pour **FinalBurn Neo** récent ;
  - dossier `mame` : des jeux pour **MAME 2003-Plus** (basé sur MAME 0.78).

  Un jeu prévu pour une autre version de MAME risque de ne pas démarrer. Un `.zip` que les listes de libretro ne connaissent pas est laissé hors de la liste, et le script le signale.
- **Les BIOS d'arcade** (`neogeo.zip`, `pgm.zip`…) vont **avec les jeux**, dans `roms\fbneo` ou `roms\mame`. Ils sont automatiquement laissés hors des listes.
- Pour vérifier ou reconstruire vos jeux d'arcade avec un outil comme ClrMamePro ou RomVault, les fichiers DAT de la bonne version sont indiqués dans le [guide d'installation](INSTALL.md), section 5.

> [!TIP]
> Quand la copie est finie, **éjectez la clé** avant de la débrancher (clic droit sur la clé, puis *Éjecter*). Débrancher pendant une écriture peut abîmer des fichiers.

---

## 7. Copier les BIOS (PC)

Certaines consoles ont besoin de leur BIOS. Copiez-les dans `E:\retroarch\bios`, avec **exactement** les noms du tableau, majuscules comprises.

> [!NOTE]
> Quand la clé est branchée, RetroArch lit les BIOS **uniquement** dans le dossier `bios` de la clé. Sans la clé, il les lit sur la console, dans `/dev_hdd0/game/SSNE10001/USRDIR/system/`.

| Fichier ou dossier, dans `bios\` | Console | |
|---|---|---|
| `bios_CD_E.bin`, `bios_CD_U.bin`, `bios_CD_J.bin` | Mega-CD : Europe, USA, Japon, selon la région de vos jeux | **Obligatoire** |
| `syscard3.pce` (certains jeux : `syscard1.pce`, `syscard2.pce` ou `gexpress.pce`) | PC Engine CD | **Obligatoire** pour les CD. Les cartes HuCard n'en ont pas besoin. |
| `disksys.rom` | Famicom Disk System | **Obligatoire** |
| Dossier `neocd\` avec un BIOS Neo Geo CD (`neocd_f.rom`, `neocd_t.rom`, `neocd_z.rom`, `front-sp1.bin`, `top-sp1.bin` ou `neocd.bin`) **et** `000-lo.lo` (ou `ng-lo.rom`) | Neo Geo CD | **Obligatoire** |
| Dossiers `Machines\` et `Databases\` | MSX, MSX2, ColecoVision | **Obligatoires**. Ils viennent du paquet de l'émulateur blueMSX : copiez-les tels quels. |
| `gba_bios.bin` | Game Boy Advance | **Conseillé**. gpSP fonctionne sans, mais certains jeux tournent mieux avec le BIOS d'origine. |
| `gb_bios.bin`, `gbc_bios.bin` | Game Boy, Game Boy Color | Facultatif : logo au démarrage |
| `bios_MD.bin`, `bios_E.sms`, `bios_U.sms`, `bios_J.sms`, `bios.gg` | Mega Drive, Master System, Game Gear | Facultatif : écran de démarrage d'origine |
| `lynxboot.img` | Atari Lynx | Facultatif |
| `7800 BIOS (U).rom` | Atari 7800 | Facultatif |
| Dossier `fuse\` | ZX Spectrum Pentagon et Scorpion | Facultatif |

**Arcade :**

| Fichier | Où le mettre |
|---|---|
| `neogeo.zip` et les autres BIOS d'arcade | Avec les jeux, dans `roms\fbneo` ou `roms\mame`. Pour FinalBurn Neo, `bios\fbneo\` convient aussi. |
| `hiscore.dat` (meilleurs scores de FinalBurn Neo) | `bios\fbneo\` |
| Samples (sons enregistrés de certains jeux), FinalBurn Neo | `bios\fbneo\samples\<jeu>.zip` |
| Samples, MAME 2003-Plus | `bios\mame2003-plus\samples\<jeu>.zip` |

Les samples doivent être rangés exactement là : ces deux émulateurs ne les cherchent nulle part ailleurs.

**Pas de BIOS nécessaire** pour : NES, Super Nintendo, 32X, Atari 2600, Neo Geo Pocket, WonderSwan, Amstrad CPC et ZX Spectrum (48K et 128K).

La même liste se trouve sur la clé, dans `retroarch\bios\LISEZMOI.txt`.

---

## 8. Créer les listes de jeux : Generer-Playlists (PC)

Le script parcourt chaque dossier de `roms`, sous-dossiers compris, et écrit **une liste par console** dans `retroarch\playlists`. Chaque liste porte l'émulateur de sa console : sur la PS3, les jeux se lancent directement, sans choisir d'émulateur.

### 8.1 Lancer le script
1. La clé est branchée sur le PC, avec les jeux copiés.
2. Double-cliquez sur **`Generer-Playlists.cmd`**.
3. Confirmez la clé (**O** puis **Entrée**).
4. Le script affiche une ligne par console trouvée :
   ```
   nes                 3 jeux  Nintendo - Nintendo Entertainment System.lpl (Nintendo - NES / Famicom (FCEUmm)), créée
   megadrive           2 jeux  Sega - Mega Drive - Genesis.lpl (Sega - MS/GG/MD/CD (Genesis Plus GX)), créée
     Liste des jeux Arcade (FinalBurn Neo) (libretro-database)...
     roms\fbneo : neogeo.zip (BIOS), laissé hors de la liste
   fbneo               4 jeux  FBNeo - Arcade Games.lpl (Arcade (FinalBurn Neo)), créée

   3 listes, 9 jeux, dans E:\retroarch\playlists
   Ensuite : Telecharger-Images.cmd pour les jaquettes, puis la clé sur la PS3.
   ```
5. Appuyez sur une touche pour fermer la fenêtre.

### 8.2 Ce qui entre dans les listes, et ce qui n'y entre pas
- **Entrent** : tous les fichiers dont l'extension est reconnue pour leur dossier (tableau de la section 6.1). Ils sont triés par ordre alphabétique.
- **Restent dehors, avec un message** « *laissé hors de la liste* » :
  - les BIOS : fichiers dont le nom contient « bios », et les BIOS d'arcade comme `neogeo.zip` ;
  - pour l'arcade, les `.zip` inconnus des listes de libretro (jeu renommé, ou prévu pour une autre version).
- **Restent dehors, sans message** :
  - les pistes citées par un `.cue` et les disques cités par un `.m3u` ;
  - le second format d'un même jeu ;
  - les fichiers cachés dont le nom commence par un point (copiés depuis un Mac, par exemple).
- **Avertissements possibles** :
  - « *aucun jeu reconnu parmi N fichiers* » : les fichiers du dossier n'ont pas l'extension attendue. Vérifiez le dossier choisi.
  - « *dossier inconnu, ignoré* » : un dossier de `roms` porte un nom que le script ne connaît pas. Utilisez les noms du tableau de la section 6.1.

La première fois, le script télécharge la liste des jeux d'arcade de libretro. Il la garde 30 jours sur le PC, dans `%LOCALAPPDATA%\RetroArch-PS3`.

### 8.3 Relancer le script
Relancez-le chaque fois que vous ajoutez ou retirez des jeux.
- Les listes des consoles dont le dossier contient des jeux sont **remplacées**. Ce que vous aviez changé sur la PS3 dans ces listes (nom d'un jeu, mode d'affichage, émulateur par défaut) est alors perdu.
- Les autres listes ne sont pas touchées. Si vous videz complètement le dossier d'une console, supprimez vous-même sa liste dans `retroarch\playlists`.

### 8.4 Choisir un autre émulateur pour une console
Chaque console a un émulateur par défaut, celui du tableau de la section 6.1. Pour en choisir un autre :

- **Sur le PC**, avec l'option `-Cores` (voir l'[annexe A](#annexe-a-donner-des-options-aux-scripts)) :
  ```
  Generer-Playlists.cmd E: -Cores gba=vba_next
  ```
  Pour plusieurs consoles, séparez-les par des virgules : `-Cores gba=vba_next,megadrive=picodrive`.

  Les autres choix qui ont un sens :

  | Dossier | Émulateur par défaut | Autre choix possible |
  |---|---|---|
  | `gba` | `gpsp` | `vba_next` |
  | `megadrive`, `mastersystem`, `gamegear`, `megacd` | `genesis_plus_gx` | `picodrive` |
  | `sg1000` | `genesis_plus_gx` | `bluemsx` |

  Pensez à remettre l'option à chaque fois que vous relancez le script, sinon l'émulateur par défaut revient.
- **Sur la PS3** : *Réglages > Listes de lecture > Gérer les listes de lecture >* (la liste) *> Cœur par défaut*. Ce choix est perdu si vous régénérez la liste sur le PC.

---

## 9. Télécharger les images : Telecharger-Images (PC)

Pour chaque jeu, le script cherche dans les dépôts d'images de libretro (`libretro-thumbnails`, sur GitHub) :
- la **jaquette** ;
- l'**écran titre**.

Il réduit chaque image à 512 pixels au plus, pour la mémoire et la vitesse de la PS3. Il l'enregistre là où RetroArch la cherche, dans `retroarch\thumbnails`.

### 9.1 Lancer le script
1. Lancez-le **après** `Generer-Playlists`, pour que les images portent les noms des listes.
2. Double-cliquez sur **`Telecharger-Images.cmd`**, puis confirmez la clé.
3. Le script affiche chaque jeu traité :
   ```
   9 jeux : 9 des listes de RetroArch, 0 d'après les noms de fichiers
     [1/9] Super Mario Bros. (World) : boxarts, titles
     [2/9] Metal Slug - Super Vehicle-001 : boxarts, titles
     ...

   Images : 18 téléchargées, 0 déjà présentes, 0 introuvables
   ```
4. Appuyez sur une touche pour fermer la fenêtre.

**Durée** : quelques secondes par jeu. Pour une grosse collection, comptez plusieurs dizaines de minutes. Vous pouvez fermer la fenêtre en cours de route et relancer plus tard : les images déjà téléchargées sont gardées.

**Place** : environ 0,5 Mo par jeu, soit 500 Mo pour 1 000 jeux.

### 9.2 Les images introuvables
Le script écrit la liste des images qu'il n'a pas trouvées dans `retroarch\thumbnails\images-introuvables.txt`. Les causes habituelles :
- le fichier du jeu n'a pas son nom de référence. Renommez-le avec son nom No-Intro ou Redump, puis relancez `Generer-Playlists` et `Telecharger-Images` ;
- libretro n'a pas d'image pour ce jeu : jeux amateurs, jeux modifiés, traductions. Vous pouvez ajouter la vôtre (voir l'[annexe B](#annexe-b-ajouter-vos-propres-images)).

### 9.3 Les options
Voir l'[annexe A](#annexe-a-donner-des-options-aux-scripts) pour les utiliser.

| Option | Effet | Exemple |
|---|---|---|
| `-Types` | Les sortes d'images, séparées par des virgules : `boxarts` (jaquettes), `titles` (écrans titre), `snaps` (captures en jeu), `logos`. Par défaut : `boxarts,titles`. | `-Types boxarts,titles,snaps` |
| `-Taille` | Le côté le plus long des images, en pixels (512 par défaut). Plus grand, c'est plus net, mais plus lourd et plus lent sur la PS3. | `-Taille 400` |
| `-Remplacer` | Télécharge à nouveau les images déjà présentes. | `-Remplacer` |

RetroArch affiche deux images par jeu au plus. Choisir lesquelles se fait sur la PS3 (section 12).

---

## 10. Jouer sur la PS3

### 10.1 Lancer RetroArch avec la clé
1. Sur le PC, éjectez la clé proprement.
2. **Branchez la clé sur la PS3 avant de lancer RetroArch.** N'importe quel port USB convient.
3. Avec HEN, activez-le. Lancez *RetroArch v2026*.
4. **La première fois avec cette clé**, RetroArch crée `retroarch\retroarch.cfg` sur la clé. C'est une copie des réglages de la console, qu'il oriente vers les dossiers de la clé. Il n'y a rien à faire.

### 10.2 Trouver et lancer un jeu
RetroArch s'ouvre sur la page *Listes de lecture* : une liste par console, sous le nom des collections libretro, par exemple « Nintendo - Super Nintendo Entertainment System ».
- **Menu XMB**, le menu d'origine (icônes en ligne, comme le menu de la PS3) : chaque console est aussi une icône de la rangée horizontale. Les jeux défilent verticalement.
- **Menu Ozone** (colonne à gauche) : les consoles sont dans la colonne de gauche, et les jeux s'affichent à droite.

Pour lancer un jeu :
1. Choisissez la console, puis le jeu.
2. Appuyez sur la touche de validation de la PS3 : **Croix** en Europe, **Rond** au Japon.
3. Choisissez **Lancer**.

Un court écran noir est normal : RetroArch se relance avec l'émulateur du jeu.

### 10.3 Pendant la partie
Appuyez **en même temps sur L3 et R3** (les deux sticks enfoncés) pour ouvrir le **Menu rapide** :

| Entrée | Effet |
|---|---|
| *Reprendre* | Revient au jeu |
| *Réinitialiser* | Redémarre le jeu |
| *Sauvegarde instantanée* / *Charger une sauvegarde instantanée* | Enregistre ou reprend la partie à cet instant précis |
| *Options de cœur* | Réglages propres à l'émulateur |
| *Shaders* | Effets d'image : écran CRT, lignes de balayage, lissage… |
| *Fermer le contenu* | Quitte le jeu et revient aux listes |

### 10.4 Finir proprement
1. *Menu rapide > Fermer le contenu*. La sauvegarde du jeu est alors écrite.
2. ***Menu principal > Quitter***. Les réglages sont alors enregistrés.

N'éteignez pas la console et ne débranchez pas la clé pendant que RetroArch tourne.

Pour garder la page des listes simple, *Historique* (les derniers jeux lancés) et *Favoris* sont masqués. Pour les réafficher, activez *Afficher 'Historique'* et *Afficher 'Favoris'* dans *Réglages > Interface utilisateur > Visibilité des éléments du menu*. Le *Menu rapide* propose alors aussi *Ajouter aux favoris*.

---

## 11. Avec ou sans la clé : ce qui change

### 11.1 Quand la clé est-elle utilisée ?
À chaque lancement, RetroArch examine les ports USB dans l'ordre, de `/dev_usb000` à `/dev_usb007`. La première clé dont le dossier `retroarch` contient `roms`, `bios` et `thumbnails` est utilisée. Sinon, RetroArch fonctionne normalement.

### 11.2 Où sont les choses

| | Clé branchée | Sans la clé |
|---|---|---|
| **Réglages de RetroArch** | `retroarch\retroarch.cfg` sur la clé | Ceux de la console : `/dev_hdd0/home/<numéro>/retroarch/retroarch.cfg` |
| **Listes de jeux** | `retroarch\playlists` sur la clé | Celles de la console : `/dev_hdd0/home/<numéro>/retroarch/playlists` |
| **Images** | `retroarch\thumbnails` sur la clé | `/dev_hdd0/game/SSNE10001/USRDIR/thumbnails` |
| **BIOS** | `retroarch\bios` sur la clé | `/dev_hdd0/game/SSNE10001/USRDIR/system` |
| ***Charger du contenu*** s'ouvre sur | `retroarch\roms` sur la clé | Le dossier réglé sur la console |
| **Sauvegardes de jeux, sauvegardes instantanées, options et remappages des émulateurs, historique, favoris, captures d'écran** | **Toujours sur la console**, dans le dossier de l'utilisateur PS3 connecté (`/dev_hdd0/home/<numéro>/retroarch/`) : ce sont les mêmes, avec ou sans clé. | ← idem |

Le `<numéro>` de l'utilisateur PS3 a 8 chiffres : `00000001` pour le premier utilisateur.

### 11.3 Bon à savoir
- **Deux jeux de réglages séparés.** Un réglage changé avec la clé branchée (le menu, un shader…) est enregistré sur la clé. Ceux de la console ne bougent pas, et l'inverse est vrai aussi.
- **Au premier lancement avec la clé**, ses réglages sont une copie de ceux de la console à ce moment-là. Ce que vous changerez ensuite sur la console ne sera pas recopié.
- **Pour repartir des réglages de la console**, supprimez `retroarch\retroarch.cfg` de la clé sur le PC. Il sera recréé au prochain lancement.
- **La clé fonctionne sur n'importe quel port**, sur une autre PS3 ou avec un autre utilisateur.
  - À chaque lancement, RetroArch oriente les réglages de la clé vers les dossiers de la clé, quel que soit le port, et vers les dossiers personnels de l'utilisateur connecté.
  - Les listes de jeux suivent la clé : leurs chemins sont corrigés tout seuls si elle change de port.
  - Chaque utilisateur et chaque console gardent leurs propres sauvegardes.
- **Plusieurs clés préparées** : seule la première trouvée est utilisée (`/dev_usb000`, puis `/dev_usb001`…).
- **Branchez la clé avant de lancer RetroArch, et ne la retirez pas pendant qu'il tourne.** RetroArch se relance à chaque lancement de jeu, et la clé serait alors cherchée à nouveau.
- **Pour se passer de la clé un moment** sans la débrancher, renommez son dossier `retroarch` sur le PC (par exemple en `retroarch-pause`).
- RetroArch écrit aussi sur la clé quelques fichiers techniques à laisser en place : `retroarch-salamander.cfg`, `retroarch-keychain.cfg` et `playlists\logs` (temps de jeu).

---

## 12. Régler l'affichage des jeux

**RetroArch est livré avec les valeurs de ce tableau : après une nouvelle installation, il n'y a rien à régler.** Le tableau sert à changer l'allure du menu, ou à retrouver ces valeurs si vos réglages viennent d'une version précédente de RetroArch PS3 v2026.

Ces réglages se font sur la PS3, dans l'onglet *Réglages*. Faites-les **avec la clé branchée** pour qu'ils ne concernent que la clé. Quittez ensuite par *Menu principal > Quitter* pour les enregistrer.

| Réglage | Où | Valeur d'origine |
|---|---|---|
| Le style du menu | *Réglages > Interface utilisateur > Menu* | **xmb** : icônes en ligne, comme la PS3. **ozone** : colonne à gauche. Il faut quitter puis relancer RetroArch. |
| Les icônes du menu XMB | *Réglages > Interface utilisateur > Apparence > Thème d'icônes* | **Systématique** : une icône en couleur par console |
| L'image de droite | *Réglages > Interface utilisateur > Apparence > Miniature principale* | **Jaquette** |
| La seconde image | *Réglages > Interface utilisateur > Apparence > Miniature secondaire* | **Écran titre** |
| L'écran d'arrivée | *Réglages > Interface utilisateur > Page de démarrage* | **Listes de lecture** : RetroArch s'ouvre directement sur les jeux |
| Les lignes sous chaque jeu | *Réglages > Listes de lecture > Afficher les sous-descriptions dans les listes de lecture* | **Désactivé** : listes plus compactes |
| Les entrées inutiles | *Réglages > Interface utilisateur > Visibilité des éléments du menu* | *Afficher 'Historique'*, *Afficher 'Favoris'*, *Afficher 'Parcourir'*, *Afficher 'Images'*, *Afficher 'Musique'*, *Afficher 'Jeu en réseau'*, *Afficher 'Charger un cœur'* et *Afficher 'Cœurs sans contenu'* sur **Désactivé** |
| La musique et les sons du menu | *Réglages > Audio > Sons du menu* | *Mixeur* et *Musique de fond* sur **Activé** |

`Telecharger-Images` récupère par défaut la jaquette et l'écran titre, qui correspondent à ces réglages. Pour afficher des captures en jeu, téléchargez-les avec `-Types boxarts,snaps` (section 9.3), puis choisissez *Capture d'écran* comme miniature.

**Pour chaque liste**, dans *Réglages > Listes de lecture > Gérer les listes de lecture >* (la liste) :
- *Mode d'affichage des descriptions* : *Supprimer le contenu entre () et []* masque les mentions comme « (Europe) » ou « [!] ».
- *Cœur par défaut* : l'émulateur de la liste (section 8.4).
- *Supprimer la liste de lecture* : retire la liste.

Ces trois réglages sont enregistrés dans la liste elle-même : `Generer-Playlists` les remet à zéro quand il la régénère.

---

## 13. Ajouter des jeux plus tard

**Méthode conseillée, sur le PC** :
1. Copiez les nouveaux jeux dans `retroarch\roms\<console>`.
2. Relancez `Generer-Playlists.cmd`, puis `Telecharger-Images.cmd`. Seules les images manquantes sont téléchargées.
3. Rebranchez la clé sur la PS3.

**Méthode rapide, sur la PS3**, pour une console qui a déjà une liste :
1. Copiez les nouveaux jeux sur la clé, dans le dossier de la console.
2. Sur la PS3 : *Réglages > Listes de lecture > Gérer les listes de lecture >* (la liste) *> Rafraîchir la liste de lecture*.

   Les nouveaux jeux s'ajoutent, avec le bon émulateur, mais sans image. Les images viendront à votre prochain passage de `Telecharger-Images` sur le PC.

   Cette méthode n'écarte pas les fichiers que `Generer-Playlists` laisse dehors : un BIOS d'arcade comme `neogeo.zip` peut ainsi apparaître dans la liste.

Pour une console qui n'a pas encore de liste, passez par le PC.

Si vous avez supprimé des jeux de la clé : *Gérer les listes de lecture >* (la liste) *> Nettoyer la liste de lecture* retire les jeux qui n'existent plus. Relancer `Generer-Playlists` sur le PC fait de même.

---

## 14. Mettre à jour RetroArch

1. Installez le nouveau PKG par-dessus l'ancien (section 4.2). Vos réglages, vos sauvegardes et votre clé sont conservés.
2. Remplacez vos anciens scripts par ceux de la nouvelle version.
3. Relancez `Preparer-Cle-USB.cmd` : il ajoute les dossiers des consoles nouvellement prises en charge, sans toucher au reste.
4. Si de nouvelles consoles vous concernent, copiez leurs jeux, puis relancez `Generer-Playlists` et `Telecharger-Images`.

---

## 15. Essayer sans PS3, avec l'émulateur RPCS3

L'émulateur PS3 **RPCS3** permet d'essayer le tout sur le PC. Son dossier `dev_usb000` joue le rôle de la clé branchée sur le premier port USB. Dans les commandes ci-dessous, remplacez `C:\RPCS3` par le dossier où vous avez installé RPCS3.

1. Dans RPCS3, *File > Install Packages*, puis choisissez l'un des deux PKG.
2. Ouvrez une fenêtre de commande dans le dossier des scripts ([annexe A](#annexe-a-donner-des-options-aux-scripts)), puis tapez :
   ```
   Preparer-Cle-USB.cmd "C:\RPCS3\dev_usb000"
   ```
   Le script crée `C:\RPCS3\dev_usb000\retroarch`.
3. Copiez les jeux dans `C:\RPCS3\dev_usb000\retroarch\roms\<console>`, et les BIOS dans `C:\RPCS3\dev_usb000\retroarch\bios`.
4. Créez les listes, puis les images :
   ```
   Generer-Playlists.cmd "C:\RPCS3\dev_usb000"
   Telecharger-Images.cmd "C:\RPCS3\dev_usb000"
   ```
5. Lancez RetroArch dans RPCS3.

Quelques remarques :
- Lancez les scripts quand RetroArch ne tourne pas dans RPCS3, ou relancez-le ensuite.
- Quittez par *Menu principal > Quitter* : le bouton *Stop* de RPCS3 coupe tout sans enregistrer les réglages.
- La vitesse dépend de votre PC et ne reflète pas celle d'une vraie PS3.

---

## 16. En cas de problème

### Sur le PC

| Ce que vous voyez | Ce qu'il faut faire |
|---|---|
| « *Aucune clé USB détectée* » | Branchez la clé. Pour un disque dur USB, donnez sa lettre au script ([annexe A](#annexe-a-donner-des-options-aux-scripts)) : `Preparer-Cle-USB.cmd E:` |
| « *Aucune clé USB préparée (avec un dossier retroarch\roms) n'est branchée* » | Lancez d'abord `Preparer-Cle-USB.cmd`, ou donnez la lettre de la clé. |
| « *E: est en NTFS : la PS3 ne lit que les clés en FAT32* » | Formatez la clé en FAT32 (section 3). |
| La fenêtre se ferme aussitôt, ou Windows refuse d'exécuter le script | Lancez toujours les fichiers `.cmd`, jamais les `.ps1`. Gardez les 8 fichiers dans le même dossier. Débloquez le `.zip` avant de l'extraire (section 5.1). |
| « *Téléchargement impossible* » | Vérifiez la connexion Internet, puis relancez plus tard : GitHub limite parfois le nombre de téléchargements. Le script reprend où il s'était arrêté. |
| Un jeu manque dans une liste | Vérifiez qu'il est dans le bon dossier, avec une extension reconnue (section 6.1). Lisez les messages « *laissé hors de la liste* » du script. En arcade, le `.zip` est peut-être renommé ou d'une autre version. |
| « *dossier inconnu, ignoré* » | Un dossier de `roms` porte un nom inconnu. Reprenez les noms de la section 6.1. |
| Beaucoup d'images introuvables | Lisez `thumbnails\images-introuvables.txt` et la section 9.2. |

### Sur la PS3

| Ce que vous voyez | Ce qu'il faut faire |
|---|---|
| Les listes n'apparaissent pas : RetroArch ignore la clé | Quittez RetroArch, vérifiez que la clé est branchée, puis relancez-le. Vérifiez sur le PC que la clé est en FAT32, et que `retroarch` est à la racine avec `roms`, `bios` et `thumbnails` dedans. Vérifiez aussi que `retroarch\playlists` contient des fichiers `.lpl`. |
| RetroArch demande quel émulateur utiliser | La liste n'a pas d'émulateur par défaut. C'est le cas d'une liste créée sur la PS3 par *Importer du contenu*. Régénérez-la avec `Generer-Playlists`, ou choisissez son *Cœur par défaut* (section 8.4). |
| Le jeu ne démarre pas, ou revient au menu | Il manque peut-être un BIOS (section 7), ou le jeu d'arcade n'est pas de la bonne version (section 6.3). Le fichier est peut-être abîmé. Pour un diagnostic, voir *En cas de problème* dans le [guide d'installation](INSTALL.md). |
| Pas d'image | Lancez `Telecharger-Images` après `Generer-Playlists`. Vérifiez *Miniature principale* (section 12). Le dossier des images doit porter exactement le nom de la liste. |
| Mes sauvegardes ont disparu | Elles appartiennent à chaque utilisateur de la PS3 : vérifiez que vous êtes connecté avec le même. Elles ne dépendent pas de la clé (section 11.2). |
| Mes réglages ne sont pas gardés | Quittez par *Menu principal > Quitter*. Rappelez-vous que la clé et la console ont chacune leurs réglages (section 11.3). |
| Une console a deux listes | Une ancienne liste, créée avec un autre nom, est restée. Supprimez-la : *Gérer les listes de lecture >* (la liste) *> Supprimer la liste de lecture*, ou sur le PC dans `retroarch\playlists`. |

---

## Annexe A. Donner des options aux scripts

Un double-clic lance un script sans option. Pour en donner :
1. Ouvrez le dossier des scripts dans l'Explorateur.
2. Cliquez dans la **barre d'adresse** (en haut, là où s'affiche le chemin du dossier), tapez `cmd`, puis appuyez sur **Entrée**. Une fenêtre noire s'ouvre dans ce dossier.
3. Tapez la commande, puis **Entrée**. Par exemple :
   ```
   Generer-Playlists.cmd E: -Cores gba=vba_next
   ```

La première valeur est toujours **la cible** : la lettre de la clé (`E:`), ou un dossier qui contient `retroarch`. Mettez entre guillemets un chemin qui contient des espaces.

| Script | Option | Effet |
|---|---|---|
| Les trois | `E:` ou `"C:\un\dossier"` | La clé ou le dossier à utiliser, sans question |
| `Preparer-Cle-USB` | `-Force` | Continue même si la clé n'est pas en FAT32. La PS3 ne pourra pas la lire : à réserver aux essais. |
| `Generer-Playlists` | `-Cores dossier=émulateur,…` | Un autre émulateur pour certaines consoles (section 8.4) |
| `Telecharger-Images` | `-Types …` | Les sortes d'images (section 9.3) |
| `Telecharger-Images` | `-Taille N` | La taille des images, en pixels |
| `Telecharger-Images` | `-Remplacer` | Télécharge à nouveau les images déjà présentes |

Les noms d'émulateurs acceptés par `-Cores` sont : `bluemsx`, `cap32`, `fbneo`, `fceumm`, `fuse`, `gambatte`, `genesis_plus_gx`, `gpsp`, `handy`, `mame2003_plus`, `mednafen_ngp`, `mednafen_pce_fast`, `mednafen_wswan`, `neocd`, `picodrive`, `prosystem`, `snes9x2010`, `stella2014` et `vba_next`. L'émulateur doit bien sûr savoir faire tourner les jeux de la console.

---

## Annexe B. Ajouter vos propres images

Une image se range ici :

```
retroarch\thumbnails\<nom de la liste>\<sorte>\<nom du jeu>.png
```

- **`<nom de la liste>`** : le nom du fichier de la liste, sans `.lpl`. Par exemple `Nintendo - Super Nintendo Entertainment System`.
- **`<sorte>`** :

  | Dossier | Image |
  |---|---|
  | `Named_Boxarts` | Jaquette |
  | `Named_Titles` | Écran titre |
  | `Named_Snaps` | Capture en jeu |
  | `Named_Logos` | Logo |

- **`<nom du jeu>`** : exactement le nom affiché dans la liste. Les caractères `&` `*` `/` `:` `` ` `` `"` `<` `>` `?` `\` `|` y sont remplacés par `_`.
- **Format** : PNG, de 512 pixels au plus de préférence.

Exemple, pour `mslug.zip` dans le dossier `fbneo` :

```
retroarch\thumbnails\FBNeo - Arcade Games\Named_Boxarts\Metal Slug - Super Vehicle-001.png
```

`Telecharger-Images` ne remplace jamais une image existante, sauf avec l'option `-Remplacer`.

# RetroArch PS3 v2026 — Installation

[Français](#français) · [English](#english)

---

## Français

> [!IMPORTANT]
> **Version non officielle.** RetroArch PS3 v2026 est un portage **non officiel** de RetroArch pour PlayStation 3. Il n'est **ni affilié à libretro ou à Sony, ni approuvé par eux**. C'est un projet de loisir, **gratuit et sans but lucratif** : il n'est pas vendu et n'a aucun but commercial. Aucun jeu, BIOS ou clé n'est fourni. Merci de ne pas signaler à libretro les problèmes de cette version.

> [!WARNING]
> **État actuel : testé uniquement dans l'émulateur RPCS3.** Les 9 premiers cores fonctionnent dans RPCS3 ; les 10 ajoutés ensuite (de Beetle PCE Fast à NeoCD) n'y ont pas encore été testés. L'installation et le fonctionnement sur une vraie PS3, en CFW comme en HEN, **n'ont pas encore été vérifiés**.

### 1. Contenu

| Core | Systèmes | Formats de jeux |
|---|---|---|
| FCEUmm | NES, Famicom, Famicom Disk System | `.nes` `.fds` `.unf` `.unif` |
| Snes9x 2010 | Super Nintendo | `.sfc` `.smc` `.fig` `.swc` `.bsx` … |
| Genesis Plus GX | Mega Drive, Master System, Game Gear, SG-1000, Mega-CD | `.md` `.gen` `.smd` `.bin` `.sms` `.gg` `.sg` `.cue` `.iso` `.chd` `.m3u` |
| PicoDrive | 32X, Mega Drive, Master System, Mega-CD | `.32x` `.md` `.bin` `.gen` `.smd` `.sms` `.gg` `.cue` `.iso` `.chd` … |
| Gambatte | Game Boy, Game Boy Color | `.gb` `.gbc` `.dmg` |
| gpSP | Game Boy Advance | `.gba` |
| VBA Next | Game Boy Advance | `.gba` |
| FinalBurn Neo | Arcade (Neo-Geo, CPS1/2/3, etc.) | `.zip` `.7z` |
| MAME 2003-Plus | Arcade | `.zip` |
| Beetle PCE Fast | PC Engine, TurboGrafx-16, PC Engine CD | `.pce` `.cue` `.ccd` `.chd` `.toc` `.m3u` |
| Stella 2014 | Atari 2600 | `.a26` `.bin` |
| ProSystem | Atari 7800 | `.a78` `.bin` `.cdf` |
| Handy | Atari Lynx | `.lnx` `.lyx` `.o` |
| Beetle NeoPop | Neo Geo Pocket, Neo Geo Pocket Color | `.ngp` `.ngc` `.ngpc` `.npc` |
| Beetle WonderSwan | WonderSwan, WonderSwan Color | `.ws` `.wsc` `.pc2` `.pcv2` |
| blueMSX | MSX, MSX2, Spectravideo, ColecoVision, SG-1000 | `.rom` `.mx1` `.mx2` `.dsk` `.cas` `.col` `.sg` `.m3u` … |
| Caprice32 | Amstrad CPC, GX4000 | `.dsk` `.sna` `.tap` `.cdt` `.cpr` `.zip` `.m3u` … |
| Fuse | ZX Spectrum | `.tzx` `.tap` `.z80` `.sna` `.szx` `.dsk` `.trd` `.zip` … |
| NeoCD | Neo Geo CD | `.cue` `.chd` |

L'interface est fournie avec les menus XMB (par défaut), Ozone et RGUI. XMB utilise le thème d'icônes *Systématique* : une icône en couleur par console.

#### Versions des cores

Chaque core est compilé depuis le dépôt libretro indiqué, au commit indiqué. La version est celle que le core annonce, et « — » signifie qu'il n'en annonce pas.

| Core | Version | Commit compilé |
|---|---|---|
| FCEUmm | — | [`77468e5`](https://github.com/libretro/libretro-fceumm/commit/77468e568d9fe9c48d684ca911f1a3fe7259fdf7) (2026-11-16) |
| Snes9x 2010 | v1.52.4 | [`82904a9`](https://github.com/libretro/snes9x2010/commit/82904a95e9bab2c3e63395e4b9ece8fdca8b785d) (2026-11-17) |
| Genesis Plus GX | v1.7.4 | [`b9c2316`](https://github.com/libretro/Genesis-Plus-GX/commit/b9c2316441978d4015ba30e9a95d9b0e6f8ee981) (2026-11-09) |
| PicoDrive | 1.99 | [`1890c29`](https://github.com/libretro/picodrive/commit/1890c2932234c9d30f4cd3851d02228baae8f09e) (2026-09-26) |
| Gambatte | v0.5.0 | [`77f2567`](https://github.com/libretro/gambatte-libretro/commit/77f2567d718b8973d02caa2daa8dce4953faf811) (2026-10-30) |
| gpSP | — | [`5819380`](https://github.com/libretro/gpsp/commit/5819380c2ffb0900219d700a382ee68c464ebb99) (2026-09-19) |
| VBA Next | — | [`788192f`](https://github.com/libretro/vba-next/commit/788192f215ad0a1413f1625b40ebba3423fa0ade) (2026-08-31) |
| FinalBurn Neo | v1.0.0.03 | [`9c6d05d00`](https://github.com/libretro/FBNeo/commit/9c6d05d00476de561ffb50928b9a2fed73142dea) (2026-11-19) |
| MAME 2003-Plus | base MAME 0.78 | [`2a60eda`](https://github.com/libretro/mame2003-plus-libretro/commit/2a60eda71ae0fea543a76a43b5d58086a5485256) (2026-11-19) |
| Beetle PCE Fast | v0.9.38.7 | [`2de1ce1`](https://github.com/libretro/beetle-pce-fast-libretro/commit/2de1ce1c3f237b161c126c54ba407990bb86d1e9) (2026-10-30) |
| Stella 2014 | 3.9.3 | [`7d1361e`](https://github.com/libretro/stella2014-libretro/commit/7d1361e407e63f29e52892655069e5fb4096e691) (2026-09-04) |
| ProSystem | 1.3e | [`8a88014`](https://github.com/libretro/prosystem-libretro/commit/8a88014287c7a01cd568067e5a557d0a2b2a051f) (2026-08-22) |
| Handy | 0.95 | [`bc55d46`](https://github.com/libretro/libretro-handy/commit/bc55d462f0b2d6b073ea93dc552ebd73cec60fd1) (2026-04-20) |
| Beetle NeoPop | v0.9.36.1 | [`a50d5ac`](https://github.com/libretro/beetle-ngp-libretro/commit/a50d5ac288a81f2104ddf43195a4efdd15c72227) (2026-06-14) |
| Beetle WonderSwan | v0.9.35.1 | [`4b01295`](https://github.com/libretro/beetle-wswan-libretro/commit/4b01295838ea89e3f1355bbe4cb5cf98aa6108cd) (2026-07-31) |
| blueMSX | — | [`e3086eb`](https://github.com/libretro/blueMSX-libretro/commit/e3086eb5d36d77fa11704cf53dc176686e70127d) (2026-08-23) |
| Caprice32 | v4.2.0 | [`06ad0da`](https://github.com/libretro/libretro-cap32/commit/06ad0da5d003ab8f2359300ebce4cf31d4c55b6e) (2026-10-30) |
| Fuse | 1.6.0 | [`e997e2b`](https://github.com/libretro/fuse-libretro/commit/e997e2bc32c888348f862f69f2c53babfedf7791) (2026-09-26) |
| NeoCD | 2019 | [`b1e04c7`](https://github.com/libretro/neocd_libretro/commit/b1e04c738cb48a1dae0574b8877f6a116d270ca1) (2026-10-03) |

RetroArch lui-même est la version 1.22.2 : la branche principale de libretro au commit `bb4b0d079d` (2026-11-18), plus les modifications PS3 du fork, branche `ps3/v2026`.

### 2. Quel fichier PKG choisir

| Fichier | Pour |
|---|---|
| `RetroArch_PS3_v2026.gnpdrm.pkg` | **HEN et CFW** (format « retail »). C'est celui à prendre en cas de doute. |
| `RetroArch_PS3_v2026.pkg` | CFW uniquement (format « debug »). |

À côté des PKG, `RetroArch_PS3_v2026_scripts_cle_USB.zip` contient des scripts pour Windows. Ils préparent une clé USB avec vos jeux, leurs listes et leurs jaquettes. Le mode d'emploi est dans le [guide de la clé USB](GUIDE_CLE_USB.md).

Le jeu s'installe sous l'identifiant `SSNE10001`. Dans le XMB, il apparaît sous le nom **« RetroArch v2026 (non officiel) »** sur une console en français, et **« RetroArch v2026 (unofficial) »** dans les autres langues.

### 3. Installation

**Préparation** : copiez le fichier PKG à la racine d'une clé USB formatée en **FAT32**, puis branchez la clé sur la PS3.

**En CFW** :
1. Dans le XMB, colonne *Jeu*, ouvrez *Package Manager* (« ★ Install Package Files » selon le CFW).
2. Choisissez *Install Package Files*, puis *Standard*, puis le fichier PKG.

**En HEN** :
1. Activez HEN, comme à chaque démarrage de la console.
2. Dans la colonne *Jeu*, ouvrez *Package Manager*, puis *Install Package Files*, puis *Standard*.
3. Choisissez **`RetroArch_PS3_v2026.gnpdrm.pkg`**.
4. Pour lancer RetroArch plus tard, HEN devra être activé.

Les noms des menus peuvent varier selon le CFW et la version de HEN.

**Mise à jour** : installez simplement la nouvelle version par-dessus l'ancienne. Vos réglages et vos sauvegardes sont conservés, car ils sont rangés à part (voir la section 6).

### 4. Premier lancement

- Lancez *RetroArch v2026* depuis la colonne *Jeu*.
- Le menu s'affiche dans la **langue de la console**.
- RetroArch s'ouvre sur la page *Listes de lecture*. Elle contient *Importer du contenu*, puis vos listes de jeux. La touche de retour (**Rond** en Europe, **Croix** au Japon) mène au *Menu principal*.
- La musique et les sons du menu sont activés. Pour les couper : *Réglages > Audio > Sons du menu*.
- Pour alléger le menu, quelques entrées sont masquées : *Historique*, *Favoris*, *Parcourir*, *Charger un cœur*, *Images*, *Jeu en réseau* et les cœurs sans contenu. *Réglages > Interface utilisateur > Visibilité des éléments du menu* les réaffiche.
- La manette DualShock 3 est configurée automatiquement.
- Pour revenir au menu pendant une partie, appuyez **en même temps sur L3 et R3** (les deux sticks enfoncés).
- Par défaut, les jeux s'affichent au format d'image d'origine du système émulé (4:3 pour la plupart des consoles).
- **Quittez par *Menu principal > Quitter*.** C'est ce qui enregistre vos réglages.

### 5. Où mettre les jeux et les BIOS

#### Les jeux

Vous pouvez les mettre à deux endroits :
- **sur une clé USB ou un disque USB en FAT32**. Le premier port USB s'appelle `/dev_usb000/`, le suivant `/dev_usb001/`, etc. Par exemple : `/dev_usb000/ROMS/NES/`, `/dev_usb000/ROMS/SNES/` ;
- **sur le disque dur de la PS3**, par FTP (webMAN MOD, multiMAN…) ou avec un gestionnaire de fichiers. Par exemple : `/dev_hdd0/ROMS/`.

Pour lancer un jeu, ouvrez *Menu principal > Charger du contenu* et naviguez jusqu'au fichier. Si plusieurs cores peuvent le lire, RetroArch vous demande lequel utiliser. Les jeux lancés sont notés dans l'*Historique*, masqué par défaut (voir la section 4).

Pour avoir une liste de jeux par console, passez par *Importer du contenu* :
- **Analyser un dossier** reconnaît les jeux grâce aux bases de données fournies dans le PKG (une par console des cores inclus). Il crée une liste par console.
  - Seuls les jeux connus des bases sont ajoutés : dumps No-Intro ou Redump, romsets FinalBurn Neo ou MAME 2003-Plus.
  - Le scan calcule l'empreinte de chaque fichier, ce qui peut prendre quelques minutes sur une grosse collection.
- **Analyse de contenu** ajoute tous les fichiers d'un dossier, sans consulter les bases. Elle sert pour les jeux modifiés (hacks, traductions), ou quand *Analyser un dossier* ne trouve rien. Vous choisissez le dossier (*Emplacement du contenu*), le nom de la liste (*Liste de lecture cible*), le core (*Cœur par défaut*) et les extensions (*Extensions de fichiers*), puis *Lancer l'analyse*.

- **Arcade** : laissez les jeux en `.zip`, sans les décompresser ni les renommer.
  - **FinalBurn Neo** demande des romsets FinalBurn Neo récents.
  - **MAME 2003-Plus** demande des romsets « MAME 2003-Plus », basés sur MAME 0.78.
  - Les jeux d'une version de MAME différente ne fonctionneront pas forcément.
  - **Fichiers DAT** : pour vérifier ou reconstruire vos romsets (ClrMamePro, RomVault…), prenez le DAT qui correspond exactement à la version du core :
    - FinalBurn Neo : le [dossier `dats`](https://github.com/libretro/FBNeo/tree/9c6d05d00476de561ffb50928b9a2fed73142dea/dats) du commit compilé. Le fichier « Arcade only » couvre l'arcade, « Neogeo only » la Neo-Geo seule.
    - MAME 2003-Plus : [`mame2003-plus.xml`](https://github.com/libretro/mame2003-plus-libretro/blob/2a60eda71ae0fea543a76a43b5d58086a5485256/metadata/mame2003-plus.xml).
- **Consoles** : c'est avec des ROM décompressées que les tests ont été faits.

#### Les BIOS

Ils vont dans **`/dev_hdd0/game/SSNE10001/USRDIR/system/`**, un dossier commun à tous les utilisateurs de la console. Les noms de fichiers doivent être **exactement** ceux du tableau.

| Core | Fichier | Nécessaire pour |
|---|---|---|
| gpSP | `gba_bios.bin` | Recommandé pour la Game Boy Advance. gpSP a un BIOS de remplacement, mais certains jeux tournent mieux avec l'original. |
| VBA Next | `gba_bios.bin` | Facultatif. |
| Genesis Plus GX, PicoDrive | `bios_CD_E.bin`, `bios_CD_U.bin`, `bios_CD_J.bin` | **Obligatoire pour le Mega-CD** : le BIOS européen, américain ou japonais, selon la région du jeu. La 32X n'a pas besoin de BIOS. |
| Genesis Plus GX | `bios_MD.bin`, `bios_E.sms`, `bios_U.sms`, `bios_J.sms`, `bios.gg` | Facultatif : écran de démarrage d'origine. |
| FCEUmm | `disksys.rom` | Obligatoire pour le Famicom Disk System (`.fds`). |
| Gambatte | `gb_bios.bin`, `gbc_bios.bin` | Facultatif. |
| FinalBurn Neo | `neogeo.zip` (et les autres BIOS d'arcade) | Neo-Geo. À mettre **dans le même dossier que les jeux**, ou dans `system/fbneo/`. |
| MAME 2003-Plus | `neogeo.zip`, etc. | À mettre **dans le même dossier que les jeux**. |
| Beetle PCE Fast | `syscard3.pce` | **Obligatoire pour les jeux PC Engine CD.** Les cartes HuCard n'en ont pas besoin. |
| NeoCD | dans `system/neocd/` : un BIOS Neo Geo CD (`neocd_f.rom`, `front-sp1.bin`, `top-sp1.bin`, `uni-bioscd.rom`…) **et** `000-lo.lo` (ou `ng-lo.rom`) | **Obligatoire.** |
| blueMSX | les dossiers `Machines/` et `Databases/` | **Obligatoires.** Ils viennent du paquet complet de blueMSX (la version pour PC) : copiez-les tels quels dans `system/`. |
| ProSystem | `7800 BIOS (U).rom` | Facultatif. |
| Handy | `lynxboot.img` | Facultatif. |
| Snes9x 2010, Stella 2014, Beetle NeoPop, Beetle WonderSwan, Caprice32, Fuse | — | Aucun. Caprice32 et Fuse ont les ROM de l'Amstrad et du Spectrum intégrées. |

### 6. Où sont vos réglages et sauvegardes

Chaque utilisateur de la PS3 a ses propres réglages et sauvegardes, dans `/dev_hdd0/home/<numéro>/retroarch/`. Le numéro a 8 chiffres : `00000001` pour le premier utilisateur.

| Dossier ou fichier | Contenu |
|---|---|
| `retroarch.cfg` | Réglages de RetroArch |
| `savefiles/<nom du core>/` | Sauvegardes des jeux (`.srm`) |
| `savestates/<nom du core>/` | Sauvegardes instantanées (`.state`) |
| `config/` | Options des cores et réglages par core ou par jeu |
| `remaps/` | Remappages de la manette |
| `playlists/` | Historique et favoris |
| `screenshots/`, `logs/` | Captures d'écran et journaux |

### 7. Si vous avez l'ancien RetroArch PSX-Place CE

Les deux versions **peuvent rester installées ensemble**. L'ancienne utilise l'identifiant `RETROARCH`, celle-ci `SSNE10001`.

Pour reprendre vos fichiers de l'ancienne version, copiez-les par FTP :
- **BIOS** : copiez le contenu de `/dev_hdd0/game/RETROARCH/USRDIR/system/` dans `/dev_hdd0/game/SSNE10001/USRDIR/system/`.
- **Sauvegardes de jeux** :
  1. Lancez une fois le jeu avec le nouveau RetroArch, pour que le dossier du core soit créé.
  2. Copiez le fichier `.srm` de `/dev_hdd0/game/RETROARCH/USRDIR/savefiles/` vers `/dev_hdd0/home/<numéro>/retroarch/savefiles/<nom du core>/`.
  3. Gardez exactement le même nom de fichier que le jeu.
- **Sauvegardes instantanées** (`.state`) : elles ne fonctionnent en général pas d'une version de core à l'autre. Reprenez plutôt les sauvegardes de jeux.

### 8. Utilisation dans l'émulateur RPCS3

- **Installation** : *File > Install Packages*, puis l'un des deux PKG.
- **Jeux** : RetroArch ne voit pas les disques de Windows. Mettez vos jeux dans le dossier `dev_usb000` de RPCS3, par exemple `<dossier de RPCS3>\dev_usb000\ROMS\NES\`. RetroArch les trouve dans `/dev_usb000/ROMS/NES/`.
- **BIOS** : `<dossier de RPCS3>\dev_hdd0\game\SSNE10001\USRDIR\system\`.
- **Pour quitter** : utilisez *Menu principal > Quitter* dans RetroArch. Le bouton *Stop* de RPCS3 coupe tout sans enregistrer les réglages.
- **Vitesse** : elle dépend de votre PC et ne reflète pas celle d'une vraie PS3.

### 9. Limites connues

- **Shaders limités.**
  - 81 shaders Cg à une seule passe sont fournis (CRT, scanlines, xBR, lissage, couleurs des consoles portables…), dans *Menu rapide > Shaders*.
  - Le lissage « bilinear » s'applique par défaut à tous les cores. Pour en changer, chargez un autre preset et enregistrez-le (global, pour le core ou pour le jeu), ou désactivez les shaders.
  - Les presets à plusieurs passes ou à textures ne sont pas encore gérés.
  - Les shaders les plus lourds (CRT élaborés) peuvent ralentir les jeux, surtout en 1080p.
- **Ordinateurs (MSX, Amstrad CPC, ZX Spectrum)** : certains jeux demandent de taper des commandes au clavier. L'usage d'un clavier USB n'a pas encore été testé.
- **Pas de mise à jour en ligne** des cores, des assets ou des miniatures pour l'instant.
- **Pas de jaquettes** : les listes de jeux s'affichent sans images, faute de mise à jour en ligne.
- **32X (PicoDrive)** : elle passe par un interpréteur. Sa vitesse sur console reste à vérifier.
- **Netplay et RetroAchievements** : pas encore testés.

### 10. En cas de problème

Pour obtenir un journal détaillé :
1. Dans *Réglages > Journalisation*, activez *Verbosité de la journalisation* et *Journaliser vers un fichier*.
2. Reproduisez le problème.
3. Récupérez `/dev_hdd0/home/<numéro>/retroarch/retroarch-log.txt` par FTP.

Le journal est réécrit à chaque relance de RetroArch, et RetroArch se relance à chaque lancement de jeu. Récupérez-le donc juste après le problème.

### 11. Désinstallation

Dans le XMB, sélectionnez *RetroArch v2026*, appuyez sur **Triangle**, puis choisissez *Supprimer*. Vos réglages et sauvegardes, dans `/dev_hdd0/home/<numéro>/retroarch/`, ne sont pas effacés. Supprimez ce dossier par FTP si vous voulez tout retirer.

### 12. Licence et sources

- RetroArch et ce portage sont sous licence **GPLv3**.
- Les sources sont publiques : <https://github.com/JamesWestFR/RetroArch>, branche `ps3/v2026`.
- Aucun jeu, BIOS ni clé n'est fourni. Utilisez uniquement des copies de jeux et de BIOS que vous avez le droit de posséder.

---

## English

> [!IMPORTANT]
> **Unofficial build.** RetroArch PS3 v2026 is an **unofficial** port of RetroArch to PlayStation 3. It is **not affiliated with or endorsed by** libretro or Sony. It is a hobby project, **free and non-commercial**: it is not sold and has no commercial purpose. No games, BIOS or keys are provided. Please do not report issues with this build to libretro.

> [!WARNING]
> **Current status: tested in the RPCS3 emulator only.** The first 9 cores work in RPCS3; the 10 added afterwards (Beetle PCE Fast to NeoCD) have not been tested there yet. Installing and running it on a real PS3, CFW or HEN, **has not been verified yet**.

### 1. What is included

| Core | Systems | Game formats |
|---|---|---|
| FCEUmm | NES, Famicom, Famicom Disk System | `.nes` `.fds` `.unf` `.unif` |
| Snes9x 2010 | Super Nintendo | `.sfc` `.smc` `.fig` `.swc` `.bsx` … |
| Genesis Plus GX | Mega Drive/Genesis, Master System, Game Gear, SG-1000, Mega-CD/Sega CD | `.md` `.gen` `.smd` `.bin` `.sms` `.gg` `.sg` `.cue` `.iso` `.chd` `.m3u` |
| PicoDrive | 32X, Mega Drive/Genesis, Master System, Mega-CD/Sega CD | `.32x` `.md` `.bin` `.gen` `.smd` `.sms` `.gg` `.cue` `.iso` `.chd` … |
| Gambatte | Game Boy, Game Boy Color | `.gb` `.gbc` `.dmg` |
| gpSP | Game Boy Advance | `.gba` |
| VBA Next | Game Boy Advance | `.gba` |
| FinalBurn Neo | Arcade (Neo-Geo, CPS1/2/3, etc.) | `.zip` `.7z` |
| MAME 2003-Plus | Arcade | `.zip` |
| Beetle PCE Fast | PC Engine, TurboGrafx-16, PC Engine CD | `.pce` `.cue` `.ccd` `.chd` `.toc` `.m3u` |
| Stella 2014 | Atari 2600 | `.a26` `.bin` |
| ProSystem | Atari 7800 | `.a78` `.bin` `.cdf` |
| Handy | Atari Lynx | `.lnx` `.lyx` `.o` |
| Beetle NeoPop | Neo Geo Pocket, Neo Geo Pocket Color | `.ngp` `.ngc` `.ngpc` `.npc` |
| Beetle WonderSwan | WonderSwan, WonderSwan Color | `.ws` `.wsc` `.pc2` `.pcv2` |
| blueMSX | MSX, MSX2, Spectravideo, ColecoVision, SG-1000 | `.rom` `.mx1` `.mx2` `.dsk` `.cas` `.col` `.sg` `.m3u` … |
| Caprice32 | Amstrad CPC, GX4000 | `.dsk` `.sna` `.tap` `.cdt` `.cpr` `.zip` `.m3u` … |
| Fuse | ZX Spectrum | `.tzx` `.tap` `.z80` `.sna` `.szx` `.dsk` `.trd` `.zip` … |
| NeoCD | Neo Geo CD | `.cue` `.chd` |

The menus included are XMB (the default), Ozone and RGUI. XMB uses the *Systematic* icon theme: one colour icon per console.

#### Core versions

Each core is built from the libretro repository shown, at the commit shown. The version is the one the core reports; "—" means it reports none.

| Core | Version | Built commit |
|---|---|---|
| FCEUmm | — | [`77468e5`](https://github.com/libretro/libretro-fceumm/commit/77468e568d9fe9c48d684ca911f1a3fe7259fdf7) (2026-11-16) |
| Snes9x 2010 | v1.52.4 | [`82904a9`](https://github.com/libretro/snes9x2010/commit/82904a95e9bab2c3e63395e4b9ece8fdca8b785d) (2026-11-17) |
| Genesis Plus GX | v1.7.4 | [`b9c2316`](https://github.com/libretro/Genesis-Plus-GX/commit/b9c2316441978d4015ba30e9a95d9b0e6f8ee981) (2026-11-09) |
| PicoDrive | 1.99 | [`1890c29`](https://github.com/libretro/picodrive/commit/1890c2932234c9d30f4cd3851d02228baae8f09e) (2026-09-26) |
| Gambatte | v0.5.0 | [`77f2567`](https://github.com/libretro/gambatte-libretro/commit/77f2567d718b8973d02caa2daa8dce4953faf811) (2026-10-30) |
| gpSP | — | [`5819380`](https://github.com/libretro/gpsp/commit/5819380c2ffb0900219d700a382ee68c464ebb99) (2026-09-19) |
| VBA Next | — | [`788192f`](https://github.com/libretro/vba-next/commit/788192f215ad0a1413f1625b40ebba3423fa0ade) (2026-08-31) |
| FinalBurn Neo | v1.0.0.03 | [`9c6d05d00`](https://github.com/libretro/FBNeo/commit/9c6d05d00476de561ffb50928b9a2fed73142dea) (2026-11-19) |
| MAME 2003-Plus | MAME 0.78 based | [`2a60eda`](https://github.com/libretro/mame2003-plus-libretro/commit/2a60eda71ae0fea543a76a43b5d58086a5485256) (2026-11-19) |
| Beetle PCE Fast | v0.9.38.7 | [`2de1ce1`](https://github.com/libretro/beetle-pce-fast-libretro/commit/2de1ce1c3f237b161c126c54ba407990bb86d1e9) (2026-10-30) |
| Stella 2014 | 3.9.3 | [`7d1361e`](https://github.com/libretro/stella2014-libretro/commit/7d1361e407e63f29e52892655069e5fb4096e691) (2026-09-04) |
| ProSystem | 1.3e | [`8a88014`](https://github.com/libretro/prosystem-libretro/commit/8a88014287c7a01cd568067e5a557d0a2b2a051f) (2026-08-22) |
| Handy | 0.95 | [`bc55d46`](https://github.com/libretro/libretro-handy/commit/bc55d462f0b2d6b073ea93dc552ebd73cec60fd1) (2026-04-20) |
| Beetle NeoPop | v0.9.36.1 | [`a50d5ac`](https://github.com/libretro/beetle-ngp-libretro/commit/a50d5ac288a81f2104ddf43195a4efdd15c72227) (2026-06-14) |
| Beetle WonderSwan | v0.9.35.1 | [`4b01295`](https://github.com/libretro/beetle-wswan-libretro/commit/4b01295838ea89e3f1355bbe4cb5cf98aa6108cd) (2026-07-31) |
| blueMSX | — | [`e3086eb`](https://github.com/libretro/blueMSX-libretro/commit/e3086eb5d36d77fa11704cf53dc176686e70127d) (2026-08-23) |
| Caprice32 | v4.2.0 | [`06ad0da`](https://github.com/libretro/libretro-cap32/commit/06ad0da5d003ab8f2359300ebce4cf31d4c55b6e) (2026-10-30) |
| Fuse | 1.6.0 | [`e997e2b`](https://github.com/libretro/fuse-libretro/commit/e997e2bc32c888348f862f69f2c53babfedf7791) (2026-09-26) |
| NeoCD | 2019 | [`b1e04c7`](https://github.com/libretro/neocd_libretro/commit/b1e04c738cb48a1dae0574b8877f6a116d270ca1) (2026-10-03) |

RetroArch itself is version 1.22.2: the libretro main branch at commit `bb4b0d079d` (2026-11-18), plus the fork's PS3 changes, branch `ps3/v2026`.

### 2. Which PKG file to use

| File | For |
|---|---|
| `RetroArch_PS3_v2026.gnpdrm.pkg` | **HEN and CFW** ("retail" format). Use this one if in doubt. |
| `RetroArch_PS3_v2026.pkg` | CFW only ("debug" format). |

Next to the PKGs, `RetroArch_PS3_v2026_scripts_cle_USB.zip` holds scripts for Windows. They prepare a USB drive with your games, their lists and their box art. The instructions are in the [USB drive guide](GUIDE_CLE_USB.md), in French only for now.

It installs under the title ID `SSNE10001`. In the XMB it shows as **"RetroArch v2026 (unofficial)"**, or **"RetroArch v2026 (non officiel)"** on a French console.

### 3. Installing

**Preparation**: copy the PKG file to the root of a **FAT32** USB drive, then plug it into the PS3.

**On CFW**:
1. In the XMB *Game* column, open *Package Manager* ("★ Install Package Files" on some CFWs).
2. Choose *Install Package Files*, then *Standard*, then the PKG file.

**On HEN**:
1. Enable HEN, as on every console boot.
2. In the *Game* column, open *Package Manager*, then *Install Package Files*, then *Standard*.
3. Choose **`RetroArch_PS3_v2026.gnpdrm.pkg`**.
4. HEN must be enabled whenever you launch RetroArch later.

Menu names may differ between CFWs and HEN versions.

**Updating**: install the new version over the old one. Your settings and saves are kept, because they are stored separately (see section 6).

### 4. First launch

- Start *RetroArch v2026* from the *Game* column.
- The menu shows up in the **console's language**.
- RetroArch opens on the *Playlists* page. It holds *Import Content*, followed by your game lists. The back button (**Circle** in Europe, **Cross** in Japan) leads to the *Main Menu*.
- Menu music and sounds are on. To turn them off: *Settings > Audio > Menu Sounds*.
- To keep the menu light, a few entries are hidden: *History*, *Favorites*, *Explore*, *Load Core*, *Images*, *Netplay* and cores without content. *Settings > User Interface > Menu Item Visibility* shows them again.
- The DualShock 3 controller is set up automatically.
- To get back to the menu during a game, press **L3 and R3 together** (both sticks pushed in).
- By default, games are shown in the original aspect ratio of the emulated system (4:3 for most consoles).
- **Quit with *Main Menu > Quit*.** That is what saves your settings.

### 5. Where to put games and BIOS files

#### Games

You can put them in two places:
- **on a FAT32 USB drive**. The first USB port is `/dev_usb000/`, the next one `/dev_usb001/`, and so on. For example: `/dev_usb000/ROMS/NES/`, `/dev_usb000/ROMS/SNES/`;
- **on the PS3 hard drive**, over FTP (webMAN MOD, multiMAN…) or with a file manager. For example: `/dev_hdd0/ROMS/`.

To start a game, open *Main Menu > Load Content* and browse to the file. If several cores can run it, RetroArch asks which one to use. Games you start are recorded in *History*, which is hidden by default (see section 4).

To get a game list for each console, use *Import Content*:
- **Scan Directory** recognizes games using the databases included in the PKG (one per console covered by the included cores). It creates one list per console.
  - Only games the databases know are added: No-Intro or Redump dumps, FinalBurn Neo or MAME 2003-Plus romsets.
  - The scan computes a checksum for each file, which can take a few minutes on a large collection.
- **Content Scan** adds every file in a folder without looking at the databases. Use it for modified games (hacks, translations), or when *Scan Directory* finds nothing. Choose the folder (*Content Location*), the list name (*Target Playlist*), the core (*Default Core*) and the extensions (*File Extensions*), then *Start Scan*.

- **Arcade**: keep games as `.zip` files, without unzipping or renaming them.
  - **FinalBurn Neo** needs current FinalBurn Neo romsets.
  - **MAME 2003-Plus** needs "MAME 2003-Plus" romsets, which are based on MAME 0.78.
  - Games from another MAME version may not work.
  - **DAT files**: to check or rebuild your romsets (ClrMamePro, RomVault…), use the DAT that matches the core version exactly:
    - FinalBurn Neo: the [`dats` folder](https://github.com/libretro/FBNeo/tree/9c6d05d00476de561ffb50928b9a2fed73142dea/dats) of the built commit. "Arcade only" covers the arcade games, "Neogeo only" the Neo-Geo alone.
    - MAME 2003-Plus: [`mame2003-plus.xml`](https://github.com/libretro/mame2003-plus-libretro/blob/2a60eda71ae0fea543a76a43b5d58086a5485256/metadata/mame2003-plus.xml).
- **Consoles**: the tests were done with uncompressed ROMs.

#### BIOS files

They go in **`/dev_hdd0/game/SSNE10001/USRDIR/system/`**, a folder shared by all users of the console. File names must be **exactly** the ones in the table.

| Core | File | Needed for |
|---|---|---|
| gpSP | `gba_bios.bin` | Recommended for the Game Boy Advance. gpSP has a replacement BIOS, but some games run better with the original. |
| VBA Next | `gba_bios.bin` | Optional. |
| Genesis Plus GX, PicoDrive | `bios_CD_E.bin`, `bios_CD_U.bin`, `bios_CD_J.bin` | **Required for the Mega-CD/Sega CD**: the European, US or Japanese BIOS, depending on the game's region. The 32X needs no BIOS. |
| Genesis Plus GX | `bios_MD.bin`, `bios_E.sms`, `bios_U.sms`, `bios_J.sms`, `bios.gg` | Optional: original boot screen. |
| FCEUmm | `disksys.rom` | Required for the Famicom Disk System (`.fds`). |
| Gambatte | `gb_bios.bin`, `gbc_bios.bin` | Optional. |
| FinalBurn Neo | `neogeo.zip` (and other arcade BIOS files) | Neo-Geo. Put it **in the same folder as the games**, or in `system/fbneo/`. |
| MAME 2003-Plus | `neogeo.zip`, etc. | Put them **in the same folder as the games**. |
| Beetle PCE Fast | `syscard3.pce` | **Required for PC Engine CD games.** HuCards do not need it. |
| NeoCD | in `system/neocd/`: a Neo Geo CD BIOS (`neocd_f.rom`, `front-sp1.bin`, `top-sp1.bin`, `uni-bioscd.rom`…) **and** `000-lo.lo` (or `ng-lo.rom`) | **Required.** |
| blueMSX | the `Machines/` and `Databases/` folders | **Required.** They come from the full blueMSX package (the PC version): copy them as they are into `system/`. |
| ProSystem | `7800 BIOS (U).rom` | Optional. |
| Handy | `lynxboot.img` | Optional. |
| Snes9x 2010, Stella 2014, Beetle NeoPop, Beetle WonderSwan, Caprice32, Fuse | — | None. Caprice32 and Fuse have the Amstrad and Spectrum ROMs built in. |

### 6. Where your settings and saves are

Each PS3 user has their own settings and saves, in `/dev_hdd0/home/<number>/retroarch/`. The number has 8 digits: `00000001` for the first user.

| Folder or file | Contents |
|---|---|
| `retroarch.cfg` | RetroArch settings |
| `savefiles/<core name>/` | In-game saves (`.srm`) |
| `savestates/<core name>/` | Save states (`.state`) |
| `config/` | Core options and per-core or per-game settings |
| `remaps/` | Controller remaps |
| `playlists/` | History and favorites |
| `screenshots/`, `logs/` | Screenshots and logs |

### 7. If you have the old RetroArch PSX-Place CE

Both versions **can stay installed side by side**. The old one uses the title ID `RETROARCH`, this one `SSNE10001`.

To bring over files from the old version, copy them over FTP:
- **BIOS files**: copy the contents of `/dev_hdd0/game/RETROARCH/USRDIR/system/` into `/dev_hdd0/game/SSNE10001/USRDIR/system/`.
- **In-game saves**:
  1. Start the game once with the new RetroArch, so that the core's folder is created.
  2. Copy the `.srm` file from `/dev_hdd0/game/RETROARCH/USRDIR/savefiles/` to `/dev_hdd0/home/<number>/retroarch/savefiles/<core name>/`.
  3. Keep exactly the same file name as the game.
- **Save states** (`.state`): they usually do not work across core versions. Bring over the in-game saves instead.

### 8. Using it in the RPCS3 emulator

- **Installing**: *File > Install Packages*, then either PKG.
- **Games**: RetroArch cannot see Windows drives. Put your games in RPCS3's `dev_usb000` folder, for example `<RPCS3 folder>\dev_usb000\ROMS\NES\`. RetroArch finds them in `/dev_usb000/ROMS/NES/`.
- **BIOS files**: `<RPCS3 folder>\dev_hdd0\game\SSNE10001\USRDIR\system\`.
- **To quit**: use *Main Menu > Quit* in RetroArch. RPCS3's *Stop* button cuts everything without saving the settings.
- **Speed**: it depends on your PC and does not reflect a real PS3.

### 9. Known limitations

- **Limited shaders.**
  - 81 single-pass Cg shaders are included (CRT, scanlines, xBR, smoothing, handheld colors…), under *Quick Menu > Shaders*.
  - Bilinear smoothing applies to every core by default. To change it, load another preset and save it (global, core or game preset), or turn shaders off.
  - Presets with several passes or textures are not supported yet.
  - The heaviest shaders (elaborate CRTs) can slow games down, especially at 1080p.
- **Computers (MSX, Amstrad CPC, ZX Spectrum)**: some games need commands typed on a keyboard. Using a USB keyboard has not been tested yet.
- **No online updates** of cores, assets or thumbnails for now.
- **No box art**: game lists show no images, since there is no online update yet.
- **32X (PicoDrive)**: it runs through an interpreter. Its speed on a real console is still to be checked.
- **Netplay and RetroAchievements**: not tested yet.

### 10. Troubleshooting

To get a detailed log:
1. In *Settings > Logging*, turn on *Logging Verbosity* and *Log to File*.
2. Reproduce the problem.
3. Get `/dev_hdd0/home/<number>/retroarch/retroarch-log.txt` over FTP.

The log is rewritten every time RetroArch restarts, and RetroArch restarts every time a game is started. So get it right after the problem.

### 11. Uninstalling

In the XMB, highlight *RetroArch v2026*, press **Triangle**, then choose *Delete*. Your settings and saves, in `/dev_hdd0/home/<number>/retroarch/`, are not removed. Delete that folder over FTP to remove everything.

### 12. License and sources

- RetroArch and this port are under the **GPLv3** license.
- The sources are public: <https://github.com/JamesWestFR/RetroArch>, branch `ps3/v2026`.
- No games, BIOS or keys are provided. Only use copies of games and BIOS files that you are entitled to own.

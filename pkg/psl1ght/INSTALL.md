# RetroArch PS3 v2026 — Installation

[Français](#français) · [English](#english)

---

## Français

> [!IMPORTANT]
> **Version non officielle.** RetroArch PS3 v2026 est un portage **non officiel** de RetroArch pour PlayStation 3. Il n'est **ni affilié à libretro ou à Sony, ni approuvé par eux**. C'est un projet de loisir, **gratuit et sans but lucratif** : il n'est pas vendu et n'a aucun but commercial. Aucun jeu, BIOS ou clé n'est fourni. Merci de ne pas signaler à libretro les problèmes de cette version.

> [!WARNING]
> **État actuel : testé uniquement dans l'émulateur RPCS3.** Les 9 cores fonctionnent dans RPCS3. L'installation et le fonctionnement sur une vraie PS3, en CFW comme en HEN, **n'ont pas encore été vérifiés**.

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

L'interface est fournie avec les menus Ozone (par défaut), XMB et RGUI.

### 2. Quel fichier PKG choisir

| Fichier | Pour |
|---|---|
| `RetroArch_PS3_v2026.gnpdrm.pkg` | **HEN et CFW** (format « retail »). C'est celui à prendre en cas de doute. |
| `RetroArch_PS3_v2026.pkg` | CFW uniquement (format « debug »). |

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
- La manette DualShock 3 est configurée automatiquement.
- Pour revenir au menu pendant une partie, appuyez **en même temps sur L3 et R3** (les deux sticks enfoncés).
- Par défaut, les jeux s'affichent au format d'image d'origine du système émulé (4:3 pour la plupart des consoles).
- **Quittez par *Menu principal > Quitter RetroArch*.** C'est ce qui enregistre vos réglages.

### 5. Où mettre les jeux et les BIOS

#### Les jeux

Vous pouvez les mettre à deux endroits :
- **sur une clé USB ou un disque USB en FAT32**. Le premier port USB s'appelle `/dev_usb000/`, le suivant `/dev_usb001/`, etc. Par exemple : `/dev_usb000/ROMS/NES/`, `/dev_usb000/ROMS/SNES/` ;
- **sur le disque dur de la PS3**, par FTP (webMAN MOD, multiMAN…) ou avec un gestionnaire de fichiers. Par exemple : `/dev_hdd0/ROMS/`.

Pour lancer un jeu, ouvrez *Menu principal > Charger du contenu* et naviguez jusqu'au fichier. Si plusieurs cores peuvent le lire, RetroArch vous demande lequel utiliser. Les jeux lancés apparaissent ensuite dans l'*Historique*.

- **Arcade** : laissez les jeux en `.zip`, sans les décompresser ni les renommer.
  - **FinalBurn Neo** demande des romsets FinalBurn Neo récents.
  - **MAME 2003-Plus** demande des romsets « MAME 2003-Plus », basés sur MAME 0.78.
  - Les jeux d'une version de MAME différente ne fonctionneront pas forcément.
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
| Snes9x 2010 | — | Aucun. |

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
- **Pour quitter** : utilisez *Quitter RetroArch* dans le menu de RetroArch. Le bouton *Stop* de RPCS3 coupe tout sans enregistrer les réglages.
- **Vitesse** : elle dépend de votre PC et ne reflète pas celle d'une vraie PS3.

### 9. Limites connues

- **Pas de shaders** (CRT, scanlines, lissage…). Le pilote graphique de la PS3 ne les gère pas encore.
- **Pas de mise à jour en ligne** des cores, des assets ou des miniatures pour l'instant.
- **Bases de données de jeux non fournies** : l'import automatique ne reconnaît pas les jeux. Passez par *Charger du contenu*.
- **32X (PicoDrive)** : elle passe par un interpréteur. Sa vitesse sur console reste à vérifier.
- **Netplay et RetroAchievements** : pas encore testés.

### 10. En cas de problème

Pour obtenir un journal détaillé :
1. Dans *Paramètres > Journalisation*, activez la verbosité et l'enregistrement du journal dans un fichier.
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
> **Current status: tested in the RPCS3 emulator only.** All 9 cores work in RPCS3. Installing and running it on a real PS3, CFW or HEN, **has not been verified yet**.

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

The menus included are Ozone (the default), XMB and RGUI.

### 2. Which PKG file to use

| File | For |
|---|---|
| `RetroArch_PS3_v2026.gnpdrm.pkg` | **HEN and CFW** ("retail" format). Use this one if in doubt. |
| `RetroArch_PS3_v2026.pkg` | CFW only ("debug" format). |

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
- The DualShock 3 controller is set up automatically.
- To get back to the menu during a game, press **L3 and R3 together** (both sticks pushed in).
- By default, games are shown in the original aspect ratio of the emulated system (4:3 for most consoles).
- **Quit with *Main Menu > Quit RetroArch*.** That is what saves your settings.

### 5. Where to put games and BIOS files

#### Games

You can put them in two places:
- **on a FAT32 USB drive**. The first USB port is `/dev_usb000/`, the next one `/dev_usb001/`, and so on. For example: `/dev_usb000/ROMS/NES/`, `/dev_usb000/ROMS/SNES/`;
- **on the PS3 hard drive**, over FTP (webMAN MOD, multiMAN…) or with a file manager. For example: `/dev_hdd0/ROMS/`.

To start a game, open *Main Menu > Load Content* and browse to the file. If several cores can run it, RetroArch asks which one to use. Games you start then show up in *History*.

- **Arcade**: keep games as `.zip` files, without unzipping or renaming them.
  - **FinalBurn Neo** needs current FinalBurn Neo romsets.
  - **MAME 2003-Plus** needs "MAME 2003-Plus" romsets, which are based on MAME 0.78.
  - Games from another MAME version may not work.
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
| Snes9x 2010 | — | None. |

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
- **To quit**: use *Quit RetroArch* in RetroArch's menu. RPCS3's *Stop* button cuts everything without saving the settings.
- **Speed**: it depends on your PC and does not reflect a real PS3.

### 9. Known limitations

- **No shaders** (CRT, scanlines, smoothing…). The PS3 graphics driver does not support them yet.
- **No online updates** of cores, assets or thumbnails for now.
- **Game databases not included**: automatic import does not recognize games. Use *Load Content*.
- **32X (PicoDrive)**: it runs through an interpreter. Its speed on a real console is still to be checked.
- **Netplay and RetroAchievements**: not tested yet.

### 10. Troubleshooting

To get a detailed log:
1. In *Settings > Logging*, turn on logging verbosity and logging to a file.
2. Reproduce the problem.
3. Get `/dev_hdd0/home/<number>/retroarch/retroarch-log.txt` over FTP.

The log is rewritten every time RetroArch restarts, and RetroArch restarts every time a game is started. So get it right after the problem.

### 11. Uninstalling

In the XMB, highlight *RetroArch v2026*, press **Triangle**, then choose *Delete*. Your settings and saves, in `/dev_hdd0/home/<number>/retroarch/`, are not removed. Delete that folder over FTP to remove everything.

### 12. License and sources

- RetroArch and this port are under the **GPLv3** license.
- The sources are public: <https://github.com/JamesWestFR/RetroArch>, branch `ps3/v2026`.
- No games, BIOS or keys are provided. Only use copies of games and BIOS files that you are entitled to own.

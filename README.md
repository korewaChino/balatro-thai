# Thai Balatro - Improved

This mod is a fork of the [Thai Balatro mod] by [maimaomaiplae](https://www.facebook.com/maimaomaiplae). It aims to improve and further localize the game for Thai players.

Updated for 1.0.1n-FULL

## Changes from the original mod

- Properly localize item names and descriptions
- Replaced default typeface from `Mali` to `2005_iannnnnAMD` for a more consistent pixel art look

## Installing the mod on Windows

1. Install [Lovely Injector] by downloading the latest release and placing the `version.dll` file in the game folder

2. Go to `%APPDATA%\Balatro` and copy the `resources`, `mods`, and `localization` folders from this repository into the game folder

3. Launch the game. Lovely Injector should notify that patches have been applied to `game.lua`

4. Select Thai in the game settings

## Proton-specific instructions

1. Follow Step 1 and 2 from the Windows instructions. You may replace %APPDATA% with `~/.steam/steam/steamapps/compatdata/2379780/pfx/drive_c/users/steamuser/AppData/Roaming/Balatro/`.

2. Set Steam's launch options to `WINEDLLOVERRIDES="version.dll=n,b" %command%` so Proton loads the Lovely Injector DLL

## Contributing

If you'd like to contribute to the mod, feel free to fork the repository and submit a pull request. If you have any questions, feel free to open an issue! :D

[Lovely Injector]: https://github.com/ethangreen-dev/lovely-injector
[Thai balatro mod]: https://www.nexusmods.com/balatro/mods/37

# localized-text
Do you want to improve the game translations? Or even add a new language?\
Well, this is the place to do it!

Here is a table of the current languages and their status:

| Language            | Code  |      EE      |      AoC     |    Lobby    |
|---------------------|-------|--------------|--------------|-------------|
| German              | de    | OK           | OK           | OK          |
| English             | en    | OK           | OK           | OK          |
| French              | fr    | OK           | OK           | OK          |
| Italian             | it    | OK           | OK           | OK          |
| Korean              | kr    | Need Review  | Missing      | Need Review |
| Polish              | pl    | Need Review  | Need Review  | Need Review |
| Portuguese Brazil   | pt-BR | Need Review  | Need Review  | Need Review |
| Russian             | ru    | Need Review  | Need Review  | Need Review |
| Spanish             | es    | OK           | OK           | OK          |
| Chinese Simplified  | zh-CN | Need Review  | Need Review  | Need Review |
| Chinese Traditional | zh-TW | Need Review  | Need Review  | See zh-CN   |

## How to use

### Editing a language

#### Game text
Open the folder `Game` and open the folder of the language you want to edit (e.g. `fr` for French) and then open the product you want to edit (e.g. `EE` for the Empire Earth and `AoC` for Empire Earth : The Art of Conquest).

You will find a file named `Language.rc` which contains all the text of the game (except the Lobby).
You can edit it with any text editor (e.g. Notepad, Notepad++, Sublime Text, Visual Studio Code, etc.).
Simply change the text between the quotes and save the file, but **be careful not to change the format of the file**!

#### Lobby text
Open the folder `Lobby` and open the folder of the language you want to edit (e.g. `fr` for French) and then edit any .cfg file you want to edit.
Simply change the text between the quotes and save the file, but **be careful not to change the format of the file**!

### Testing your changes

#### Game text
Open powershell in repository folder and run `.\ee_lt.ps1 build` to build all languages.\
You can also run `.\ee_lt.ps1 build language_code` to build only one language.

Then, if the build is successful, you can go in the same folder where you edited `Language.rc` and copy the new created `Language.dll` file in your game folder (the one where `Empire Earth.exe`/`EE-AOC.exe` is located)

#### Lobby text
Copy all files from `Lobby\language_code\WONLobby Resources` to `Data\WONLobby Resources` in your game folder. 
And copy `Lobby\language_code\WONLobby.cfg` to your game folder (the one where `Empire Earth.exe`/`EE-AOC.exe` is located)

### Adding a new language

#### Game text
If you want to add a new game language, you will need to create a new folder in the `Game` folder and name it with the language code (that follow IETF language tags).
Then, you will need to copy the `EE` and `AoC` folders from an existing language folder (`en` (English) most of the time except if your new language is based on another existing one) and paste it in the new folder.

#### Lobby text
If you want to add a new lobby language, you will need to create a new folder in the `Lobby` folder and name it with the language code (that follow IETF language tags).
Then, you will need to copy the language folder from an existing language folder (`en` (English) most of the time except if your new language is based on another existing one) and paste it in the new folder.

### Common mistakes

- **Do not change the format of the file!** If you do, the game will not be able to read it and will crash.
- **Do not use the same file for `EE` and `AoC`!** Even if the game manage to read it, some text will be missing/incorrect.
- The text here is for Empire Earth 1 (v2 update) and Empire Earth : The Art of Conquest
- Don't use a resolution patch when testing changes, the screen must be 1024x768 to be sure that the text can be displayed even on smaller screens.
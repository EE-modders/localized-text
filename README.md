# localized-text
Do you want to improve the game translations? Or even add a new language?\
Well, this is the place to do it!

Here is a table of the current languages and their status:

| Language            | Code  |      EE      |      AoC     |
|---------------------|-------|--------------|--------------|
| German              | de    | OK           | OK           |
| English             | en    | OK           | OK           |
| French              | fr    | OK           | OK           |
| Italian             | it    | OK           | OK           |
| Korean              | kr    | Need Review  | Missing      |
| Polish              | pl    | Need Review  | Need Review  |
| Portuguese Brazil   | pt-BR | Need Review  | Need Review  |
| Russian             | ru    | Need Review  | Need Review  |
| Spanish             | es    | OK           | OK           |
| Chinese Simplified  | zh-CN | Need Review  | Need Review  |
| Chinese Traditional | zh-TW | Need Review  | Need Review  |

## How to use

### Editing a language

Open the folder `Game` and open the folder of the language you want to edit (e.g. `fr` for French) and then open the product you want to edit (e.g. `EE` for the Empire Earth and `AoC` for Empire Earth : The Art of Conquest).

You will find a file named `Language.rc` which contains all the strings of the game (except the Lobby).
You can edit it with any text editor (e.g. Notepad, Notepad++, Sublime Text, Visual Studio Code, etc.).
Simply change the text between the quotes and save the file, but **be careful not to change the format of the file**!

### Adding a new language

If you want to add a new language, you will need to create a new folder in the `Game` folder and name it with the language code.
Then, you will need to copy the `EE` and `AoC` folders from an existing language folder (`en` (English) most of the time except if your new language is based on another existing one) and paste it in the new folder.

### Testing your changes

Open powershell in repository folder and run `.\ee_lt.ps1 build` to build all languages.\
You can also run `.\ee_lt.ps1 build <language_code>` to build only one language.

Then, if the build is successful, you can go in the same folder where you edited `Language.rc` and copy the new created `Language.dll` file in your game folder (the one where `Empire Earth.exe` is located)

### Common mistakes

- **Do not change the format of the file!** If you do, the game will not be able to read it and will crash.
- **Do not use the same file for `EE` and `AoC`!** Even if the game manage to read it, some strings will be missing/incorrect.
- Those strings are for Empire Earth v2 and Empire Earth : The Art of Conquest
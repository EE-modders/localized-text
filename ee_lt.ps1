##############################################
#   Empire Earth - Localized Text Compiler   #
#     By EnergyCube for the EE Community     #
##############################################

##############################################
#                    Help                    #
##############################################
# Usage: ee_lt.ps1 build                     #
# Description: Compiles all language files   #
##############################################
# Usage: ee_lt.ps1 build <language>          #
# Description: Compiles a specific language  #
# Example: ee_lt.ps1 build en                #
##############################################
# Usage: ee_lt.ps1 clean                     #
# Description: Cleans all temporary files    #
##############################################

Write-Host "##############################################"
Write-Host "#   Empire Earth - Localized Text Compiler   #"
Write-Host "#     By EnergyCube for the EE Community     #"
Write-Host "##############################################"
Write-Host ""

$LT_OK = 1
$LT_KO = 0

# Edit the line bellow if your Resource Hacker is not located here:
$RHPath = "C:\Program Files (x86)\Resource Hacker\ResourceHacker.exe"

$RCFile = "Language.rc"
$RESFile = "Language.res"
$DLLFile = "Language.dll"
$EmptyDLLFile = "LanguageEmpty.dll"

# Get the arguments
$Arguments = $args

function HelpLT()
{
    Write-Host "Usage: ee_lt.ps1 build" -ForegroundColor Cyan
    Write-Host "Description: Compiles all language files" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host "Usage: ee_lt.ps1 build <language>" -ForegroundColor Cyan
    Write-Host "Description: Compiles a specific language" -ForegroundColor DarkGray
    Write-Host "Example: ee_lt.ps1 build en"
    Write-Host ""
    Write-Host "Usage: ee_lt.ps1 clean" -ForegroundColor Cyan
    Write-Host "Description: Cleans all temporary files" -ForegroundColor DarkGray
    Write-Host ""
}

function CleanLT()
{
    # clean RESFile & DLLFile
    $CleanNb = 0
    $Directories = Get-ChildItem "Game" -Directory
    foreach ($Directory in $Directories)
    {
        $Products = Get-ChildItem $Directory.FullName -Directory
        foreach ($Product in $Products)
        {
            $ResPath = $Product.FullName + "\" + $RESFile
            $DllPath = $Product.FullName + "\" + $DLLFile
            if (Test-Path $ResPath)
            {
                Remove-Item $ResPath -ErrorAction SilentlyContinue
                $CleanNb++
            }
            if (Test-Path $DllPath)
            {
                Remove-Item $DllPath -ErrorAction SilentlyContinue
                $CleanNb++
            }
        }
    }
    Write-Host "Cleaned" $CleanNb "files" -ForegroundColor Green
}

# Patch the DLL
function BuildResAndDll($Path)
{
    # Remove previous DLL & RES
    Remove-Item $Path\$DLLFile -ErrorAction SilentlyContinue
    Remove-Item $Path\$RESFile -ErrorAction SilentlyContinue

    Start-Process $RHPath -WorkingDirectory $Path -ArgumentList "-open $RCFile -save $RESFile -action compile -log NUL" -Wait
    if (!(Test-Path $Path\$RESFile))
    {
        Remove-Item $Path\$RESFile -ErrorAction SilentlyContinue
        Write-Host "Error compiling RC file" -ForegroundColor Red
        return $LT_KO
    }

    Start-Process $RHPath -WorkingDirectory $Path -ArgumentList "-open $EmptyDLLFile -save $DLLFile -resource $RESFile -action addoverwrite -log NUL" -Wait
    Remove-Item $Path\$RESFile -ErrorAction SilentlyContinue
    if (!(Test-Path $Path\$DLLFile))
    {
        Write-Host "Error adding RES file" -ForegroundColor Red
        return $LT_KO
    }
    return $LT_OK
}

function BuildLang($Path)
{
    $Path = Get-Item $Path
    Write-Host "Patching Language:" $Path.Name -ForegroundColor Blue

    $Products = Get-ChildItem $Path.FullName -Directory
    foreach ($Product in $Products)
    {
        $ProductName = $Product.Name
        Write-Host "Patching Product: $ProductName" -ForegroundColor DarkGray
        if ((BuildResAndDll($Product.FullName)) -eq $LT_KO)
        {
            Write-Host "Failed to patch: $ProductName" -ForegroundColor DarkRed
            return $LT_KO
        }
    }
    return $LT_OK
}

# Patch the DLLs
function BuildAll()
{
    # Get the directories
    $Directories = Get-ChildItem "Game" -Directory

    Write-Host "Detected" $Directories.Count "languages" -ForegroundColor Green
    Write-Host ""

    # Loop through the directories
    foreach ($Directory in $Directories)
    {
        if (BuildLang($Directory.FullName) -eq $LT_OK)
        {
            Write-Host "Successfully patched: $Directory" -ForegroundColor Green
        } else
        {
            Write-Host "Failed to patch: $Directory" -ForegroundColor Red
        }
        Write-Host ""
    }
}

# Check if the arguments are empty
if ($Arguments.Count -eq 0)
{
    # Show the help
    HelpLT
    return
}

if (!(Test-Path $RHPath))
{
    Write-Host "Resource Hacker not found or path is incorrect"
    Write-Host "Please install Resource Hacker if you don't have it"
    Write-Host "http://angusj.com/resourcehacker/"
    Write-Host "Or edit the script and set the correct path"
    return
}

if ($Arguments[0] -eq "build")
{
    if ($Arguments.Count -eq 1)
    {
        BuildAll
    }
    else
    {
        if (BuildLang("Game\" + $Arguments[1])  -eq $LT_OK)
        {
            Write-Host "Successfully patched:" $Arguments[1] -ForegroundColor Green
        } else
        {
            Write-Host "Failed to patch:" $Arguments[1] -ForegroundColor Red
        }
    }
    return
} elseif ($Arguments[0] -eq "clean")
{
    CleanLT
    return
} else
{
    HelpLT
    return
}

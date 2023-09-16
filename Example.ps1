# RUN THIS EXAMPLE FILE TO SEE HOW SHOW-TREEMENU WORKS!

# LOAD THE FUNCTION INTO MEMORY
Function Show-Treemenu {
    <#
    .SYNOPSIS
        Configures and displays a terminal menu based on end-user settings defined in a .XML file.
    
    .DESCRIPTION
        The **Show-Treemenu** function reads user-specific terminal menu settings from an .XML file
        and uses these settings to create an organized menu. Users can select from different menu sections,
        options within those sections, and execute corresponding functions.
    
        This function allows for **easy customization of terminal menus, making it convenient for users to access
        and execute a collection of functions/scriptpaths in a structured and user-friendly manner**.
    
    .PARAMETER MenuTitle
        Simply the title of the menu. 
    
    .PARAMETER QuitExpression
        Use this to call a function to logoff an API, call a quit function / script path, or simply return to exit the menu. 
    
    .PARAMETER SelectionPrompt
        The phrase the user will be prompted with to make a choice/selection.
    
    .PARAMETER Timer
        Gets the processing time of an executed function/scriptfile and returns it cleanly in **00h 00m 00s** time format.
    
    .PARAMETER TitleColor
        The color of the title of the menu.
    
    .PARAMETER PromptColor
        The color of the phrase the user will be prompted with to make a choice/selection.
    
    .PARAMETER BranchColor
        The color of the **grid-like** symbols used to create the treemenu.
    
    .PARAMETER SectionColor
        The color of the main sections or categories.
    
    .PARAMETER OptionColor
        The color of the options, below and indented underneath the sections.
    
    .PARAMETER BranchStyle
        The style **ASCII**, **SingleLine**, or **DoubleLine** that will be used to generate the treemenu.
    
    .PARAMETER XmlPath
        The path of the **MenuConfig.xml** file.
    
    .EXAMPLE
        Show-TreeMenu -XmlPath "C:\YourPath\ShowTreemenu\MenuConfig.xml"
    
    .EXAMPLE
        Show-TreeMenu -XmlPath "C:\YourPath\ShowTreemenu\MenuConfig.xml" -BranchColor Yellow
    
    .EXAMPLE
        Show-TreeMenu -XmlPath "C:\YourPath\ShowTreemenu\MenuConfig.xml" -BranchColor Yellow -BranchStyle "DoubleLine"
    
    .NOTES
        Author: Dan Metzler
        PowerShellVersion: PowerShell 5.1 or Later Recommended. 
    
        If facing an issue with rendering the menu on PSVersion < 5.1, try parameter [-BranchStyle ASCII] which is **NOT** using Box Drawing Symbols.
    
        To use box drawing symbols effectively, it's recommended to use a newer version of PowerShell, such as PowerShell 5.1 or PowerShell 7, which 
        provide better Unicode support and rendering capabilities.
    
    .LINK
        https://github.com/dmetz12
    #>
    
        [CmdletBinding(HelpUri="https://github.com/dmetz12/Show-Treemenu")]
        param(
        [Parameter(ValueFromPipeline=$true, Mandatory)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({Test-Path -Path $_})]
        [string]$XmlPath,
    
        [Parameter()]
        [string]$MenuTitle = "MainMenu",
    
        [Parameter()]
        [string]$SelectionPrompt = "Choose an Option",
    
        [Parameter()]
        [string]$QuitExpression = "Return",
    
        [Parameter()]
        [boolean]$Timer = $true,
    
        [Parameter()]
        [ValidateSet("Black","Darkblue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")]
        [string]$TitleColor = "Cyan",
    
        [Parameter()]
        [ValidateSet("Black","Darkblue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")]
        [string]$BranchColor = "Gray",
    
        [Parameter()]
        [ValidateSet("Black","Darkblue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")]
        [string]$SectionColor = "Yellow",
    
        [Parameter()]
        [ValidateSet("Black","Darkblue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")]
        [string]$OptionColor = "White",
    
        [Parameter()]
        [ValidateSet("Black","Darkblue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")]
        [string]$PromptColor = "Cyan",
    
        [Parameter()]
        [ValidateSet("ASCII", "SingleLine", "DoubleLine")]
        [string]$BranchStyle = "SingleLine"
    
        )
    
        # CHECK THE STYLE OF THE BRANCH, BOTH SHOULD WORK PROPERLY ALL OF THE TIME, ALTHOUGH WHEN IMPORTING-MODULE FILE WITH SHOW-TREEMENU SOMETIMES CAN RENBDER ERROR WITH BOXDRAWING CHARS
        if($BranchStyle -eq "SingleLine"){
            $style = @{
                tl = "┌" # TOP LEFT 
                tr = "┐" # TOP RIGHT
                hr = "─" # HORIZONTAL RULE
                vr = "│" # VERTICLE RULE
                ltj = "├" # LEFT T-JUCTION
                bl = "└" # BOTTOM LEFT
                br = "┘" # BOTTOM RIGHT
            }
        }elseif($BranchStyle -eq "DoubleLine"){
            $style = @{
                tl = "╔" # TOP LEFT 
                tr = "╗" # TOP RIGHT
                hr = "═" # HORIZONTAL RULE
                vr = "║" # VERTICLE RULE
                ltj = "╠" # LEFT T-JUCTION
                bl = "╚" # BOTTOM LEFT
                br = "╝" # BOTTOM RIGHT
            }
        }elseif($BranchStyle -eq "ASCII"){
            $style = @{
                tl = "+" # TOP LEFT 
                tr = "+" # TOP RIGHT
                hr = "-" # HORIZONTAL RULE
                vr = "|" # VERTICLE RULE
                ltj = ">" # LEFT T-JUCTION
                bl = "+" # BOTTOM LEFT
                br = "+" # BOTTOM RIGHT
            }
        }
    
        # IMPORT THE XML FILE FROM THE PROVIDED PATH AND GET TO THE "SECTION" PORTION WITH THE SECTIONS, OPTIONS, AND FUNCTIONS
        [xml]$xmlRaw = Get-Content -Path $XmlPath
        $xmlData = $xmlRaw.MenuConfig.Section 
    
        # $xmlData
        # Start-Sleep -Seconds 5
        
        # CONFIRM THE NUMBER OF OPTIONS AND FUNCTIONS ARE THE SAME TO ENSURE FUNCTIONALITY.
        if($xmlData.Option.Count -ne $xmlData.Function.Count){
            Write-Host "========================================" -ForegroundColor Red
            Write-Host "Sections  ==> $($xmlData.Section.Count)"  -ForegroundColor Green        
            Write-Host "Options   ==> $($xmlData.Option.Count)" -ForegroundColor Yellow
            Write-Host "Functions ==> $($xmlData.Function.Count)"   -ForegroundColor Magenta
            Write-Host "========================================`n" -ForegroundColor Red
            throw "The number of MenuItemOptions & MenuItemFunctions should be the same, please fix your [MenuConfig.xml] file."
        }
        
    $MainScriptBlock = {
        
        # TOP DISPLAY OF THE MENU WITH MenuTitle
        Write-Host " $($style.tl)$($style.hr * 5)$($style.tr)" -ForegroundColor $BranchColor
        Write-Host " $($style.vr)    " -ForegroundColor $BranchColor -NoNewline; 
        Write-Host $MenuTitle -ForegroundColor $TitleColor
        Write-Host " $($style.vr)     $($style.vr)" -ForegroundColor $BranchColor
        
        $menuLoopCounter = 0
        $menuSectionCounter = 0
        
        do{
    
        $currentXMLItem = $null
        $currentXMLItem = $xmlData[$menuLoopCounter]
        $menuSectionCounter++
        
        Write-Host " $($style.vr)     $($style.ltj)$($style.hr * 5)" -ForegroundColor $BranchColor -NoNewline; 
        Write-Host "[$($menuSectionCounter)] $($currentXMLItem.SectionName)" -ForegroundColor $SectionColor
    
    
        #Write-host $currentXMLItem.Option.count -f magenta
    
        foreach($option in $currentXMLItem.Option){
            
            $optionIndex        = ($currentXMLItem.Option).IndexOf($option)
            $lastOptionIndex    = ($currentXMLItem.Option.Count - 1)
    
        
            if($optionIndex -eq $lastOptionIndex){
                Write-Host " $($style.vr)     $($style.vr)     $($style.bl)$($style.hr * 5)" -ForegroundColor $BranchColor -NoNewline
                Write-Host $option -ForegroundColor $OptionColor
                Write-host " $($style.vr)     $($style.vr)" -ForegroundColor $BranchColor
            }else{
                Write-Host " $($style.vr)     $($style.vr)     $($style.ltj)$($style.hr * 5)" -ForegroundColor $BranchColor -NoNewline
                Write-Host $option -ForegroundColor $OptionColor
            }
        
        }
        
        $menuLoopCounter++
    
        }until($menuLoopCounter -eq $xmlData.Count)
        
    
        Write-Host " $($style.vr)    " -NoNewline -ForegroundColor $BranchColor
        Write-Host "[Q] Quit" -ForegroundColor Red
        Write-Host " $($style.vr)     $($style.vr)" -ForegroundColor $BranchColor
        Write-Host " $($style.bl)$($style.hr * 5)$($style.br)" -ForegroundColor $BranchColor
        
        $quitFlag = $false  # Add this line before the outer loop
    
        do{
        
            $selection = $(Write-Host " $selectionPrompt" -NoNewline -ForegroundColor $PromptColor; Write-Host " [1-$($xmlData.Count)] ==> " -NoNewline -ForegroundColor $PromptColor; Read-Host)
        
            switch ($selection){
        
                {$selection -ge 1 -and $selection -le $xmlData.Count}{
                    $index = $selection - 1
        
                    $selectionValue = $xmlData[$index]
                    $selectionNames = $selectionValue | Select-Object -ExpandProperty Option
        
                    Clear-Host
                    Write-Host " $($style.tl)$($style.hr * 5)$($style.tr)" -ForegroundColor $BranchColor
                    Write-Host " $($style.vr)     $($style.vr)" -ForegroundColor $BranchColor
                    Write-Host " $($style.vr)    " -NoNewLine -ForegroundColor $BranchColor; Write-host "[M] $MenuTitle" -ForegroundColor $TitleColor
                    Write-Host " $($style.vr)     $($style.vr)" -ForegroundColor $BranchColor
                    Write-Host " $($style.vr)     $($style.ltj)$($style.hr * 5)" -ForegroundColor $BranchColor -NoNewline
                    Write-Host $selectionValue.SectionName -ForegroundColor $SectionColor
        
                    $subMenuOptionCounter = 0
        
                    foreach($subMenuOption in $selectionNames){
        
                    $optionIndex = $selectionNames.IndexOf($subMenuOption)
                    $lastOptionIndex = $selectionNames.Count - 1
                    $subMenuOptionCounter++
        
                    if($optionIndex -eq $lastOptionIndex){
                        Write-Host " $($style.vr)     $($style.vr)      $($style.bl)$($style.hr * 5)" -NoNewline -ForegroundColor $BranchColor
                        Write-Host "[$subMenuOptionCounter] $subMenuOption" -ForegroundColor $OptionColor
                        Write-Host " $($style.vr)     $($style.vr)" -ForegroundColor $BranchColor
                    }else{
                        Write-Host " $($style.vr)     $($style.vr)      $($style.ltj)$($style.hr * 5)" -NoNewline -ForegroundColor $BranchColor
                        Write-Host "[$subMenuOptionCounter] $subMenuOption" -ForegroundColor $OptionColor
                    }
        
                }
        
                Write-Host " $($style.vr)    " -NoNewline -ForegroundColor $BranchColor
                Write-host "[Q] Quit" -ForegroundColor Red
                Write-Host " $($style.vr)     $($style.vr)" -ForegroundColor $BranchColor
                Write-Host " $($style.bl)$($style.hr * 5)$($style.br)" -ForegroundColor $BranchColor
        
                }
        
                "q" {
                    Write-host '`nThe parameter [' -nonewline; Write-host 'QuitExpression' -f Red -nonewline; Write-host '] by default is set to [' -nonewline; Write-host 'Return' -f Cyan -nonewline; Write-host ']`n';
                    Invoke-Expression -Command $QuitExpression
                    $quitFlag = $true  # Set the quit flag to true
                    Break;             # Break out of the inner loop
                }
        
            }
        
        }until(($selection -ge 1 -and $selection -le $xmlData.Count) -or ($selection -eq "q"))
        
        if($quitflag -eq $false){
        
            do{
            
                $subSelection = $(Write-Host " $selectionPrompt" -NoNewline -ForegroundColor $PromptColor; Write-Host " [1-$($selectionNames.Count)] ==> " -NoNewline -ForegroundColor $PromptColor; Read-Host)
            
                try{$subSelectionINT = [int]$subSelection}catch{}
            
                switch($subSelection){
                    {[int]$subSelectionINT -ge 1 -and [int]$subSelectionINT -le $selectionNames.Count}{
            
                        $subIndex = $subSelection - 1
    
                        $functionToInvoke = $xmlData[$index].Function[$subIndex]
                        
    
                        if($Timer){
                            $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    
                            Write-host "" 
                            Invoke-Expression "& '$functionToInvoke'"
                            Write-host "" 
    
                            $stopwatch.Stop()
                            $elapsedTime = $stopwatch.Elapsed
                            # Format the elapsed time as "00H 00M 00S" with color codes
                            $formattedTime = '{0:D2}' -f $elapsedTime.Hours
                            $formattedTime += [char]27 + '[31m' + 'h ' + [char]27 + '[0m'  # Red color for 'H'
                            $formattedTime += '{0:D2}' -f $elapsedTime.Minutes
                            $formattedTime += [char]27 + '[32m' + 'm ' + [char]27 + '[0m'  # Green color for 'M'
                            $formattedTime += '{0:D2}' -f $elapsedTime.Seconds
                            $formattedTime += [char]27 + '[34m' + 's' + [char]27 + '[0m'   # Blue color for 'S'
    
                            Write-Host "$($style.tl)$($style.hr * 30)$($style.tr)" -ForegroundColor $BranchColor
                            Write-Host "$($style.vr) " -NoNewline -ForegroundColor $BranchColor
                            Write-Host "Processing Time: " -NoNewline -ForegroundColor White
                            Write-Host "$formattedTime" -NoNewline 
                            Write-host " $($style.vr)" -ForegroundColor $BranchColor
                            Write-Host "$($style.bl)$($style.hr * 30)$($style.br)" -ForegroundColor $BranchColor
    
                        }else{
                            Write-host "" 
                            Invoke-Expression "& '$functionToInvoke'"
                            Write-host "" 
                        }
    
                        
                        do{
                            
                            Write-Host "`rPress " -NoNewline
                            Write-Host "[Space Bar] " -ForegroundColor Green -NoNewline
                            Write-Host "to return to MainMenu"
                            $keyPress = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    
                        }until($keyPress.VirtualKeyCode -eq 32)
    
                        Clear-Host
                        & $MainScriptBlock
    
                    }
                    "q" {
                        Write-host '`nThe parameter [' -nonewline; Write-host 'QuitExpression' -f Red -nonewline; Write-host '] by default is set to [' -nonewline; Write-host 'Return' -f Cyan -nonewline; Write-host ']`n';
                        Invoke-Expression "& '$QuitExpression'"
                        $quitFlag = $true  # Set the quit flag to true
                        Break;             # Break out of the inner loop
                    }
                    "m" {Clear-Host; & $MainScriptBlock}
                }
    
            }until(($subSelectionINT -ge 1 -and $subSelectionINT -le $selectionNames.Count) -or ($subSelection -eq "q") -or ($subSelection -eq "m"))
        }
    } 
        
        & $MainScriptBlock
        
}
# SECTION 1 FUNCTIONS, THESE FUNCTIONS ARE EXECUTED DEPENDING ON WHAT OPTION IS CHOISEN IN SECTION 1
function Function-ForS1Option1{
    Write-Host "Executing...[Function for Section 1 Option 1]" -ForegroundColor Green
    Start-Sleep -Seconds 1
    Write-Host "SUCCESS!" -ForegroundColor Green
}
function Function-ForS1Option2{
    Write-Host "Executing...[Function for Section 1 Option 2]" -ForegroundColor Magenta
        Start-Sleep -Seconds 1
    Write-Host "SUCCESS!" -ForegroundColor Green
}
function Function-ForS1Option3{
    Write-Host "Executing...[Function for Section 1 Option 3]" -ForegroundColor Yellow
        Start-Sleep -Seconds 1
    Write-Host "SUCCESS!" -ForegroundColor Green
}

# SECTION 2 FUNCTIONS, THESE FUNCTIONS ARE EXECUTED DEPENDING ON WHAT OPTION IS CHOISEN IN SECTION 2
function Function-ForS2Option1{
    Write-Host "Executing...[Function for Section 2 Option 1]" -ForegroundColor Green
        Start-Sleep -Seconds 1
    Write-Host "SUCCESS!" -ForegroundColor Green
}
function Function-ForS2Option2{
    Write-Host "Executing...[Function for Section 2 Option 2]" -ForegroundColor Magenta
        Start-Sleep -Seconds 1
    Write-Host "SUCCESS!" -ForegroundColor Green
}
function Function-ForS2Option3{
    Write-Host "Executing...[Function for Section 2 Option 3]" -ForegroundColor Yellow
        Start-Sleep -Seconds 1
    Write-Host "SUCCESS!" -ForegroundColor Green
}

# SECTION 3 FUNCTIONS, THESE FUNCTIONS ARE EXECUTED DEPENDING ON WHAT OPTION IS CHOISEN IN SECTION 3
function Function-ForS3Option1{
    Write-Host "Executing...[Function for Section 3 Option 1]" -ForegroundColor Green
        Start-Sleep -Seconds 1
    Write-Host "SUCCESS!" -ForegroundColor Green
}
function Function-ForS3Option2{
    Write-Host "Executing...[Function for Section 3 Option 2]" -ForegroundColor Magenta
        Start-Sleep -Seconds 1
    Write-Host "SUCCESS!" -ForegroundColor Green
}
function Function-ForS3Option3{
    Write-Host "Executing...[Function for Section 3 Option 3]" -ForegroundColor Yellow
        Start-Sleep -Seconds 1
    Write-Host "SUCCESS!" -ForegroundColor Green
}

# CALL THE SHOW-TREEMENU FUNCTION AND PASS IT THE XML FILE
Show-Treemenu -XmlPath .\MenuConfig.xml 



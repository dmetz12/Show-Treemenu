Function Show-TreeMenu {
    [CmdletBinding()]
    param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$MenuName = "MainMenu",

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [array[]]$MenuItemSections,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [array[]]$MenuItemOptions,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [array[]]$MenuItemFunctions,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$SelectionPrompt = "Choose an Option",

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$QuitExpression,
    
    [Parameter()]
    [ValidateSet("Black","Darkblue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")]
    [ValidateNotNullOrEmpty()]
    [string]$MenuNameColor = "Cyan",

    [Parameter()]
    [ValidateSet("Black","Darkblue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")]
    [ValidateNotNullOrEmpty()]
    [string]$BranchColor = "DarkGray",

    [Parameter()]
    [ValidateSet("Black","Darkblue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")]
    [ValidateNotNullOrEmpty()]
    [string]$MenuItemSectionColor = "DarkGray",

    [Parameter()]
    [ValidateSet("Black","Darkblue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")]
    [ValidateNotNullOrEmpty()]
    [string]$MenuOptionColor = "White",

    [Parameter()]
    [ValidateSet("Black","Darkblue", "DarkGreen", "DarkCyan", "DarkRed", "DarkMagenta", "DarkYellow", "Gray", "DarkGray", "Blue", "Green", "Cyan", "Red", "Magenta", "Yellow", "White")]
    [ValidateNotNullOrEmpty()]
    [string]$SelectionPromptColor = "Cyan",

    [Parameter()]
    [ValidateSet("ASCII", "SingleLine", "DoubleLine")]
    [ValidateNotNullOrEmpty()]
    [string]$BranchStyle = "ASCII",

    [Parameter(ValueFromPipeline=$true, Mandatory)]
    [ValidateScript({Test-Path -Path $_})]
    [string]$xmlFilePath
    
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
    [xml]$xmlRaw = Get-Content -Path $xmlFilePath
    $xmlData = $xmlRaw.MenuConfig.Section 
    
    # SPLIT THEM INTO THEIR OWN VARIABLES TO MAKE THEM EASIER TO WORK WITH
    $xmlSections    = $xmlData.Section
    $xmlOptions     = $xmlData.Option
    $xmlFunctions   = $xmlData.Function

    # CONFIRM THE NUMBER OF OPTIONS AND FUNCTIONS ARE THE SAME TO ENSURE FUNCTIONALITY.
    if($xmlOptions.Count -ne $xmlFunctions.Count){
        Write-Host "========================================" -ForegroundColor Red
        Write-Host "Sections  ==> $($xmlSections.Count)"  -ForegroundColor Green        
        Write-Host "Options   ==> $($xmlOptions.Count)" -ForegroundColor Yellow
        Write-Host "Functions ==> $($xmlFunctions.Count)"   -ForegroundColor Magenta
        throw "The number of MenuItemOptions & MenuItemFunctions should be the same, please fix your [MenuConfig.xml] file."
    }
    
    # $menuItems = [System.Collections.Generic.List[object]]::New()
    
    # for($i = 0; $i -lt $MenuItemSections.count; $i++){
    
    #     $sections = $MenuItemSections[$i]
    #     $options = $MenuItemOptions[$i]
    #     $functions = $MenuItemFunctions[$i]
    
    #     $mitem = [PSCustomObject]@{
    #         Section     = $sections
    #         Option      = $options
    #         Function    = $functions
    #     }
    
    #     $menuItems.Add($mitem)
    # }
    
    # DISPLAY OBJECT FOR TESTING
    #$menuItems | Format-Table
    
    
$mainMenuScriptBlock = {
    
    # TOP DISPLAY OF THE MENU WITH MENUNAME
    Write-Host " $($style.tl)$($style.hr * 5)$($style.tr)" -ForegroundColor $BranchColor
    Write-Host " $($style.vr)    " -ForegroundColor $BranchColor -NoNewline; 
    Write-Host $MenuName -ForegroundColor $MenuNameColor
    Write-Host " $($style.vr)     $($style.vr)" -ForegroundColor $BranchColor
    
    $menuLoopCounter = 0
    $menuSectionCounter = 0
    
    do{
    $currentArrayItem = $null
    $currentArrayItem = $menuItems[$menuLoopCounter]
    
    $sectionOptions = $currentArrayItem | Select-Object -ExpandProperty Option
    
    $menuSectionCounter++
    
    Write-Host " $($style.vr)     $($style.ltj)$($style.hr * 5)" -ForegroundColor $BranchColor -NoNewline; 
    Write-Host "[$($menuSectionCounter)] $($currentArrayItem.Section)" -ForegroundColor $MenuItemSectionColor
    
    foreach($option in $sectionOptions){
    
        $optionIndex = $sectionOptions.IndexOf($option)
        $lastOptionIndex = $sectionOptions.Count - 1
        $optionCounter++
    
        if($optionIndex -eq $lastOptionIndex){
            Write-Host " $($style.vr)     $($style.vr)     $($style.bl)$($style.hr * 5)" -ForegroundColor $BranchColor -NoNewline
            Write-Host $option -ForegroundColor $MenuOptionColor
            Write-host " $($style.vr)     $($style.vr)" -ForegroundColor $BranchColor
        }else{
            Write-Host " $($style.vr)     $($style.vr)     $($style.hr)$($style.hr * 5)" -ForegroundColor $BranchColor -NoNewline
            Write-Host $option -ForegroundColor $MenuOptionColor
        }
    
    }
    
    
    $menuLoopCounter++
    
    }until($menuLoopCounter -eq $menuItems.Count)
    
    Write-Host " $($style.vr)    " -NoNewline -ForegroundColor $BranchColor
    Write-Host "[Q] Quit" -ForegroundColor Red
    Write-Host " $($style.vr)     $($style.vr)" -ForegroundColor $BranchColor
    Write-Host " $($style.bl)$($style.hr * 5)$($style.br)" -ForegroundColor $BranchColor
    
    
    $quitFlag = $false  # Add this line before the outer loop

    do{
    
        $selection = $(Write-Host " $selectionPrompt" -NoNewline -ForegroundColor $SelectionPromptColor; Write-Host " [1-$($menuItems.Count)] ==> " -NoNewline -ForegroundColor $SelectionPromptColor; Read-Host)
    
        switch ($selection){
    
            {$selection -ge 1 -and $selection -le $menuItems.Count}{
                $index = $selection - 1
    
                $selectionValue = $menuItems[$index]
                $selectionNames = $selectionValue | Select-Object -ExpandProperty Option
    
                Clear-Host
                Write-Host " $($style.tl)$($style.hr * 5)$($style.tr)" -ForegroundColor $BranchColor
                Write-Host " $($style.vr)     $($style.vr)" -ForegroundColor $BranchColor
                Write-Host " $($style.vr)    " -NoNewLine -ForegroundColor $BranchColor; Write-host "[M] $MenuName" -ForegroundColor $MenuNameColor
                Write-Host " $($style.vr)     $($style.vr)" -ForegroundColor $BranchColor
                Write-Host " $($style.vr)     $($style.ltj)$($style.hr * 5)" -ForegroundColor $BranchColor -NoNewline
                Write-Host $selectionValue.Section -ForegroundColor $MenuItemSectionColor
    
                $subMenuOptionCounter = 0
    
                foreach($subMenuOption in $selectionNames){
    
                $optionIndex = $selectionNames.IndexOf($subMenuOption)
                $lastOptionIndex = $selectionNames.Count - 1
                $subMenuOptionCounter++
    
                if($optionIndex -eq $lastOptionIndex){
                    Write-Host " $($style.vr)     $($style.vr)      $($style.bl)$($style.hr * 5)" -NoNewline -ForegroundColor $BranchColor
                    Write-Host "[$subMenuOptionCounter] $subMenuOption" -ForegroundColor $MenuOptionColor
                    Write-Host " $($style.vr)     $($style.vr)" -ForegroundColor $BranchColor
                }else{
                    Write-Host " $($style.vr)     $($style.vr)      $($style.hr)$($style.hr * 5)" -NoNewline -ForegroundColor $BranchColor
                    Write-Host "[$subMenuOptionCounter] $subMenuOption" -ForegroundColor $MenuOptionColor
                }
    
            }
    
            Write-Host " $($style.vr)    " -NoNewline -ForegroundColor $BranchColor
            Write-host "[Q] Quit" -ForegroundColor Red
            Write-Host " $($style.vr)     $($style.vr)" -ForegroundColor $BranchColor
            Write-Host " $($style.bl)$($style.hr * 5)$($style.br)" -ForegroundColor $BranchColor
    
            }
    
            "q" {
                Invoke-Expression -Command $QuitExpression
                $quitFlag = $true  # Set the quit flag to true
                Break;             # Break out of the inner loop
            }
    
        }
    
    }until(($selection -ge 1 -and $selection -le $menuItems.Count) -or ($selection -eq "q"))
    
    

    if($quitflag -eq $false){
    
    do{
    
        $subSelection = $(Write-Host " $selectionPrompt" -NoNewline -ForegroundColor $SelectionPromptColor; Write-Host " [1-$($selectionNames.Count)] ==> " -NoNewline -ForegroundColor $SelectionPromptColor; Read-Host)
    
        try{$subSelectionINT = [int]$subSelection}catch{}
    
        switch($subSelection){
            {[int]$subSelectionINT -ge 1 -and [int]$subSelectionINT -le $selectionNames.Count}{
    
                $subIndex = $subSelection - 1
                $selectionValue = $menuItems[$index]
                $subSelectionFunctions = $selectionValue | Select-Object Function
                $functionToInvoke = $subSelectionFunctions[$subIndex] | Select-Object -ExpandProperty Function
                

                Invoke-Expression -Command $functionToInvoke

                Write-Host "`nReturning to MainMenu..." -f Gray
                Start-Sleep -Seconds 2

                Clear-Host
                & $mainMenuScriptBlock
    
            }
            "q" {
                Invoke-Expression -Command $QuitExpression
                $quitFlag = $true  # Set the quit flag to true
                Break;             # Break out of the inner loop
            }
            "m" {Clear-Host;& $mainMenuScriptBlock}
    
        }
    
    }until(($subSelectionINT -ge 1 -and $subSelectionINT -le $selectionNames.Count) -or ($subSelection -eq "q") -or ($subSelection -eq "m"))
    
}
} 
    
    & $mainMenuScriptBlock
    
} 


function S1-Function1{
    Write-Host "Executing [S1-Function1]..." -ForegroundColor Green
    Write-Host "SUCCESS!" -ForegroundColor Green
}
function S1-Function2{
    Write-Host "Executing [S1-Function2]..." -ForegroundColor Magenta
    Write-Host "SUCCESS!" -ForegroundColor Green
}
function S2-Function1{
    Write-Host "Executing [S2-Function1]..." -ForegroundColor Yellow
    Write-Host "SUCCESS!" -ForegroundColor Green
}
function S2-Function2{
    Write-Host "Executing [S2-Function2]..." -ForegroundColor Yellow
    Write-Host "SUCCESS!" -ForegroundColor Green
}
function S3-Function1{
    Write-Host "Executing [S3-Function1]..." -ForegroundColor Yellow
    Write-Host "SUCCESS!" -ForegroundColor Green
}
function S3-Function2{
    Write-Host "Executing [S3-Function2]..." -ForegroundColor Yellow
    Write-Host "SUCCESS!" -ForegroundColor Green
}


# [xml]$TestXml = Get-Content -Path ".\Settings.xml"

# $TestXml.MenuConfig.Section 



Show-TreeMenu -MenuName "MainMenu" -BranchStyle SingleLine -BranchColor Gray -QuitExpression "Write-host 'I Quit!' -f Red; Return" -xmlFilePath "C:\Users\Daniel Metzler\Desktop\ShowTreemenu\Settings.xml"





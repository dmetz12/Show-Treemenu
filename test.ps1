$HorizontalLine = "─"



$style = @{
    tl = "┌" # TOP LEFT 
    tr = "┐" # TOP RIGHT
    hr = "─" # HORIZONTAL
    bl = "└" # BOTTOM LEFT
    br = "┘" # BOTTOM RIGHT
}






function Write-Ascii {
    param (
        [Parameter(ValueFromPipeline=$true, Mandatory=$true)][string[]] $InputText,
        [switch] $PrependChar,
        [switch] $Compression,
        [string] $ForegroundColor = 'Default',
        [string] $BackgroundColor = 'Default'
    )

    begin {
        Set-StrictMode -Version Latest
        $ErrorActionPreference = 'Stop'

        # Define the ASCII art data inline
        $Letters = @{
            'a' = @"
  __ _  
 / _` | 
| (_| | 
 \__,_|
"@
            'b' = @"
 _____  
| |__) 
| '_ \  
| |_) | 
|_.__/
"@
            'c' = @"
  ___  
 / __| 
| (__  
 \___|
"@
            # Add more characters here as needed
        }

        # Define the accepted characters
        $AcceptedChars = '[a-z]'
    }

    process {
        foreach ($Text in $InputText) {
            $Text = $Text.ToLower()

            if ($Text -match $AcceptedChars) {
                $ASCII = $Letters[$Text]

                if ($ASCII -ne $null) {
                    if ($PrependChar) {
                        $Text = $Text.PadLeft($ASCII[0] -split "`n")[0].Length)
                    }
                    
                    if ($ForegroundColor -ne 'Default' -and $BackgroundColor -ne 'Default') {
                        Write-Host -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor "$Text`n$ASCII"
                    }
                    elseif ($ForegroundColor -ne 'Default') {
                        Write-Host -ForegroundColor $ForegroundColor "$Text`n$ASCII"
                    }
                    elseif ($BackgroundColor -ne 'Default') {
                        Write-Host -BackgroundColor $BackgroundColor "$Text`n$ASCII"
                    }
                    else {
                        Write-Output "$Text`n$ASCII"
                    }
                }
                else {
                    Write-Host "Character '$Text' is not supported."
                }
            }
            else {
                Write-Host "Unsupported character: $Text"
            }
        }
    }

    # Rest of the script (Write-RainbowString, Get-Ascii, etc.)
}

# Call the Write-Ascii function
Write-Ascii "abc!"

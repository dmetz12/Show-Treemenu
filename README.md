# Show-Treemenu

## SYNOPSIS
Configures and displays a terminal menu based on end-user settings defined in a .XML file.

## DESCRIPTION
The **Show-Treemenu** function reads user-specific terminal menu settings from an .XML file
and uses these settings to create an organized menu.
Users can select from different menu sections,
options within those sections, and execute corresponding functions.

This function allows for **easy customization of terminal menus, making it convenient for users to access
and execute a collection of functions/scriptpaths in a structured and user-friendly manner**.

## DEMO
**[1.]** Configure your *MenuConfig.xml* file with your `SectionNames`, `Options`, & `Functions or ScriptPaths` that correspond to your `Options`.

![GitHub Logo](https://github.com/dmetz12/Show-Treemenu/blob/main/img/Showcase1.PNG)

**[2.]** Ensure the functions that will be called are dot sourced or loaded into memory, then run `Show-Treemenu -XmlPath "C:\Your\XML\Path\MenuConfig.xml"`. 

![GitHub Logo](https://github.com/dmetz12/Show-Treemenu/blob/main/img/Showcase2.PNG)

**[3.]** Make a selection from the MainMenu, the sections submenu will appear.

![GitHub Logo](https://github.com/dmetz12/Show-Treemenu/blob/main/img/Showcase3.PNG)

**[4.]** Make a selection from the generated submenu, the corresponding option's function will execute. 

![GitHub Logo](https://github.com/dmetz12/Show-Treemenu/blob/main/img/Showcase4.PNG)
**NOTE:** *The boolean parameter **[-Timer]** by default is set to $true and will render the time it took to process the function or script path executed. This can be disabled by adding **[-Timer $false]** when executing the Show-Treemenu function*.

### BranchStyle Demo
#### DoubleLine
![GitHub Logo](https://github.com/dmetz12/Show-Treemenu/blob/main/img/Showcase5.PNG)
#### ASCII
![GitHub Logo](https://github.com/dmetz12/Show-Treemenu/blob/main/img/Showcase6.PNG)

## SYNTAX

```
Show-Treemenu [-XmlPath] <String> [[-MenuTitle] <String>] [[-SelectionPrompt] <String>]
 [[-QuitExpression] <String>] [[-Timer] <Boolean>] [[-TitleColor] <String>] [[-BranchColor] <String>]
 [[-SectionColor] <String>] [[-OptionColor] <String>] [[-PromptColor] <String>] [[-BranchStyle] <String>]
 [<CommonParameters>]
```

## EXAMPLES

### EXAMPLE 1
```
Show-TreeMenu -XmlPath "C:\YourPath\ShowTreemenu\MenuConfig.xml"
```

### EXAMPLE 2
```
Show-TreeMenu -XmlPath "C:\YourPath\ShowTreemenu\MenuConfig.xml" -BranchColor Yellow
```

### EXAMPLE 3
```
Show-Treemenu -XmlPath .\MenuConfig.xml -TitleColor Green -BranchColor Cyan -SectionColor Yellow -OptionColor White -BranchStyle DoubleLine -PromptColor Green 
```

## PARAMETERS

### -XmlPath
The path of the **MenuConfig.xml** file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -MenuTitle
Simply the title of the menu.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: MainMenu
Accept pipeline input: False
Accept wildcard characters: False
```

### -SelectionPrompt
The phrase the user will be prompted with to make a choice/selection.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: Choose an Option
Accept pipeline input: False
Accept wildcard characters: False
```

### -QuitExpression
Use this to call a function to logoff an API, call a quit function / script path, or simply return to exit the menu.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: Return
Accept pipeline input: False
Accept wildcard characters: False
```

### -Timer
Gets the processing time of an executed function/scriptfile and returns it cleanly in **00h 00m 00s** time format.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: True
Accept pipeline input: False
Accept wildcard characters: False
```

### -TitleColor
The color of the title of the menu.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: Cyan
Accept pipeline input: False
Accept wildcard characters: False
```

### -BranchColor
The color of the **grid-like** symbols used to create the treemenu.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: Gray
Accept pipeline input: False
Accept wildcard characters: False
```

### -SectionColor
The color of the main sections or categories.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: Yellow
Accept pipeline input: False
Accept wildcard characters: False
```

### -OptionColor
The color of the options, below and indented underneath the sections.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: White
Accept pipeline input: False
Accept wildcard characters: False
```

### -PromptColor
The color of the phrase the user will be prompted with to make a choice/selection.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: Cyan
Accept pipeline input: False
Accept wildcard characters: False
```

### -BranchStyle
The style **ASCII**, **SingleLine**, or **DoubleLine** that will be used to generate the treemenu.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: SingleLine
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Dan Metzler
PowerShellVersion: PowerShell 5.1 or Later Recommended. 

If facing an issue with rendering the menu on PSVersion \< 5.1, try parameter \[-BranchStyle ASCII\] which is **NOT** using Box Drawing Symbols.

To use box drawing symbols effectively, it's recommended to use a newer version of PowerShell, such as PowerShell 5.1 or PowerShell 7, which 
provide better Unicode support and rendering capabilities.

## RELATED LINKS

[https://github.com/dmetz12](https://github.com/dmetz12)


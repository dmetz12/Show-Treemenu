---
external help file:
Module Name:
online version:
schema: 2.0.0
---

# Show-Treemenu

## SYNOPSIS
Configures and displays a terminal menu based on end-user settings defined in an XML file.

## SYNTAX

```
Show-Treemenu [-XmlPath] <String> [[-MenuTitle] <String>] [[-SelectionPrompt] <String>]
 [[-QuitExpression] <String>] [[-Timer] <Boolean>] [[-TitleColor] <String>] [[-BranchColor] <String>]
 [[-SectionColor] <String>] [[-OptionColor] <String>] [[-PromptColor] <String>] [[-BranchStyle] <String>]
 [<CommonParameters>]
```

## DESCRIPTION
The **Show-Treemenu** function reads user-specific terminal menu settings from an XML file
and uses these settings to create an organized menu.
Users can select from different menu sections,
options within those sections, and execute corresponding functions.

This function allows for **easy customization of terminal menus, making it convenient for users to access
and execute a collection of functions/scriptpaths in a structured and user-friendly manner**.

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
Show-TreeMenu -XmlPath "C:\YourPath\ShowTreemenu\MenuConfig.xml" -BranchColor Yellow -BranchStyle "DoubleLine"
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
Gets the processing time of an executed function/scriptfile and returns it cleanly in \`00h 00m 00s\` time format.

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

## RELATED LINKS

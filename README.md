# Show-Treemenu
## SYNOPSIS
Configures and displays a terminal menu based on user's settings from an XML file.

## DESCRIPTION
The `Show-Treemenu` function reads user-specific terminal menu settings from an XML file
and uses these settings to create an organized menu. Users can select from different menu sections,
options within those sections, and execute corresponding functions.

This function allows for easy customization of terminal menus, making it convenient for users to access
and execute a collection of functions/scriptpaths in a structured and user-friendly manner.

## PARAMETERS### -XmlPath &lt;String&gt;
Description:
The path of the [MenuConfig.xml] file.

\\\powershell
Required?                    true
Position?                    1
Default value
Accept pipeline input?       true (ByValue)
Accept wildcard characters?  false
\\\
 ### -MenuTitle &lt;String&gt;
Description:
Simply the title of the menu.

\\\powershell
Required?                    false
Position?                    2
Default value                MainMenu
Accept pipeline input?       false
Accept wildcard characters?  false
\\\
 ### -SelectionPrompt &lt;String&gt;
Description:
The phrase the user will be prompted with to make a choice/selection.

\\\powershell
Required?                    false
Position?                    3
Default value                Choose an Option
Accept pipeline input?       false
Accept wildcard characters?  false
\\\
 ### -QuitExpression &lt;String&gt;
Description:
Use this to call a function to logoff an API, call a quit function / script path, or simply return to exit the menu.

\\\powershell
Default value                Write-host '
The parameter [' -nonewline; Write-host 'QuitExpression' -f Red -nonewline; Write-host '] by default is set to [' -nonewline; Write-host 'Return' -f Cyan -nonewline; Write-host ']
'; Return
Accept pipeline input?       false
Accept wildcard characters?  false
\\\
 ### -TitleColor &lt;String&gt;
Description:
The color of the title of the menu.

\\\powershell
Required?                    false
Position?                    5
Default value                Cyan
Accept pipeline input?       false
Accept wildcard characters?  false
\\\
 ### -BranchColor &lt;String&gt;
Description:
The color of the "grid-like" symbols used to create the treemenu.

\\\powershell
Required?                    false
Position?                    6
Default value                Gray
Accept pipeline input?       false
Accept wildcard characters?  false
\\\
 ### -SectionColor &lt;String&gt;
Description:
Default ==&gt; [Yellow]
The color of the main sections or categories.

\\\powershell
Required?                    false
Position?                    7
Default value                Yellow
Accept pipeline input?       false
Accept wildcard characters?  false
\\\
 ### -OptionColor &lt;String&gt;
Description:
Default ==&gt; [White]
The color of the options, below and indented underneath the sections.

\\\powershell
Required?                    false
Position?                    8
Default value                White
Accept pipeline input?       false
Accept wildcard characters?  false
\\\
 ### -PromptColor &lt;String&gt;
Description:
The color of the phrase the user will be prompted with to make a choice/selection.

\\\powershell
Required?                    false
Position?                    9
Default value                Cyan
Accept pipeline input?       false
Accept wildcard characters?  false
\\\
 ### -BranchStyle &lt;String&gt;
Description:
The style [ASCII, SingleLine, or DoubleLine] that will be used to generate the treemenu.

\\\powershell
Required?                    false
Position?                    10
Default value                SingleLine
Accept pipeline input?       false
Accept wildcard characters?  false
\\\

## INPUTS


## OUTPUTS
No output type specified

## EXAMPLES### EXAMPLE 1
\\\powershell
PS &gt; & Show-TreeMenu -XmlPath "C:\Users\REPLACE_USER\Desktop\ShowTreemenu\MenuConfig.xml"
\\\
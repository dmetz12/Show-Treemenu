# Show-Treemenu
## SYNOPSIS
Configures and displays a terminal menu based on user's settings from an XML file.
## DESCRIPTION
The `Show-Treemenu` function reads user-specific terminal menu settings from an XML file
and uses these settings to create an organized menu. Users can select from different menu sections,
options within those sections, and execute corresponding functions.

This function allows for easy customization of terminal menus, making it convenient for users to access
and execute a collection of functions/scriptpaths in a structured and user-friendly manner.
# PARAMETERS

## **-XmlPath**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-TRUE-Red?) \
Description: The path of the [MenuConfig.xml] file.

  ## **-MenuTitle**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-FALSE-Green?) ![Foo](https://img.shields.io/badge/DefaultValue-MainMenu-Blue?color=5547a8)\
Description: Default ==> [MainMenu] Simply the title of the menu.

  ## **-SelectionPrompt**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-FALSE-Green?) ![Foo](https://img.shields.io/badge/DefaultValue-Choose an Option-Blue?color=5547a8)\


  ## **-QuitExpression**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-FALSE-Green?) ![Foo](https://img.shields.io/badge/DefaultValue-Write-host '
The parameter [' -nonewline; Write-host 'QuitExpression' -f Red -nonewline; Write-host '] by default is set to [' -nonewline; Write-host 'Return' -f Cyan -nonewline; Write-host ']
'; Return-Blue?color=5547a8)\
Description: Default ==> [Return] Use this to call a function to logoff an API, call a quit function / script path, or simply return to exit the menu.

  ## **-TitleColor**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-FALSE-Green?) ![Foo](https://img.shields.io/badge/DefaultValue-Cyan-Blue?color=5547a8)\
Description: Default ==> [Cyan] The phrase the user will be prompted with to make a choice/selection.

  ## **-BranchColor**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-FALSE-Green?) ![Foo](https://img.shields.io/badge/DefaultValue-Gray-Blue?color=5547a8)\
Description: Default ==> [Gray] The color of the "grid-like" symbols used to create the treemenu.

  ## **-SectionColor**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-FALSE-Green?) ![Foo](https://img.shields.io/badge/DefaultValue-Yellow-Blue?color=5547a8)\
Description: Default ==> [Yellow] The color of the main sections or categories.

  ## **-OptionColor**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-FALSE-Green?) ![Foo](https://img.shields.io/badge/DefaultValue-White-Blue?color=5547a8)\
Description: Default ==> [White] The color of the options, below and indented underneath the sections.

  ## **-PromptColor**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-FALSE-Green?) ![Foo](https://img.shields.io/badge/DefaultValue-Cyan-Blue?color=5547a8)\


  ## **-BranchStyle**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-FALSE-Green?) ![Foo](https://img.shields.io/badge/DefaultValue-SingleLine-Blue?color=5547a8)\
Description: Default ==> [Singleline] The style [ASCII, SingleLine, or DoubleLine] that will be used to generate the treemenu.


#### EXAMPLE 1
```powershell
P
C
:
\
T
e
m
p
>
S
h
o
w
-
T
r
e
e
M
e
n
u

-
X
m
l
P
a
t
h

"
C
:
\
U
s
e
r
s
\
R
E
P
L
A
C
E
_
U
S
E
R
\
D
e
s
k
t
o
p
\
S
h
o
w
T
r
e
e
m
e
n
u
\
M
e
n
u
C
o
n
f
i
g
.
x
m
l
"
```
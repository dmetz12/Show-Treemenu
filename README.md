# Show-Treemenu
## SYNOPSIS
Configures and displays a terminal menu based on user's settings from an XML file.
## DESCRIPTION
The `Show-Treemenu` function reads user-specific terminal menu settings from an XML file
and uses these settings to create an organized menu. Users can select from different menu sections,
options within those sections, and execute corresponding functions.

This function allows for `easy customization of terminal menus, making it convenient for users to access
and execute a collection of functions/scriptpaths in a structured and user-friendly manner`.
# PARAMETERS


## **-XmlPath**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-true-Red?)

The path of the [MenuConfig.xml] file.

## **-Timer**

> ![Foo](https://img.shields.io/badge/Type-Boolean-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-false-Red?) ![Foo](https://img.shields.io/badge/DefaultValue-True-Blue?color=5547a8)

Gets the processing time of an executed function/scriptfile and returns it cleanly in 00hour 00minute 00second format.

## **-MenuTitle**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-false-Red?) ![Foo](https://img.shields.io/badge/DefaultValue-MainMenu-Blue?color=5547a8)

Simply the title of the menu.

## **-SelectionPrompt**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-false-Red?) ![Foo](https://img.shields.io/badge/DefaultValue-Choose_an_Option-Blue?color=5547a8)

The phrase the user will be prompted with to make a choice/selection.

## **-QuitExpression**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-false-Red?) ![Foo](https://img.shields.io/badge/DefaultValue-Return-Blue?color=5547a8)

Use this to call a function to logoff an API, call a quit function / script path, or simply return to exit the menu.

## **-TitleColor**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-false-Red?) ![Foo](https://img.shields.io/badge/DefaultValue-Cyan-Blue?color=5547a8)

The color of the title of the menu.

## **-BranchColor**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-false-Red?) ![Foo](https://img.shields.io/badge/DefaultValue-Gray-Blue?color=5547a8)

The color of the "grid-like" symbols used to create the treemenu.

## **-SectionColor**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-false-Red?) ![Foo](https://img.shields.io/badge/DefaultValue-Yellow-Blue?color=5547a8)

The color of the main sections or categories.

## **-OptionColor**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-false-Red?) ![Foo](https://img.shields.io/badge/DefaultValue-White-Blue?color=5547a8)

The color of the options, below and indented underneath the sections.

## **-PromptColor**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-false-Red?) ![Foo](https://img.shields.io/badge/DefaultValue-Cyan-Blue?color=5547a8)

The color of the phrase the user will be prompted with to make a choice/selection.

## **-BranchStyle**

> ![Foo](https://img.shields.io/badge/Type-String-Blue?) ![Foo](https://img.shields.io/badge/Mandatory-false-Red?) ![Foo](https://img.shields.io/badge/DefaultValue-SingleLine-Blue?color=5547a8)

The style [ASCII, SingleLine, or DoubleLine] that will be used to generate the treemenu.

#### EXAMPLE 1
```powershell

PS > & Show-TreeMenu -XmlPath "C:\Users\REPLACE_USER\Desktop\ShowTreemenu\MenuConfig.xml"
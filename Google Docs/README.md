# Google Docs

## Add Format Code as style

1. Create a new script (`Tools > Script Editor`)
2. Copy the following code into the editor:

    ```js
    // Add new menu item
    function onOpen() {
    DocumentApp.getUi()
    .createMenu('Styles')
    .addItem('Format Code', 'formatCode')
    .addToUi();
    }

    // Define code styling
    var style = {};
    style[DocumentApp.Attribute.FONT_FAMILY] = DocumentApp.FontFamily.CONSOLAS;
    style[DocumentApp.Attribute.FONT_SIZE] = 10;
    style[DocumentApp.Attribute.BACKGROUND_COLOR] = "#DDDDDD";
    style[DocumentApp.Attribute.FOREGROUND_COLOR] = "#333333";
    style[DocumentApp.Attribute.BOLD] = false;

    // Apply code formatting
    function formatCode() {
    var selection = DocumentApp.getActiveDocument().getSelection();
    if (selection) {
        var elements = selection.getRangeElements();
        for (var i = 0; i < elements.length; i++) {
        var element = elements[i];

        // Only modify elements that can be edited as text; skip images and other non-text elements.
        if (element.getElement().editAsText) {
            var text = element.getElement().editAsText();

            // Style the selected part of the element, or the full element if it's completely selected.
            if (element.isPartial()) {
            text.setAttributes(element.getStartOffset(), element.getEndOffsetInclusive(), style);
            } else {
            text.setAttributes(style);
            }
        }
        }
    }
    }
    ```
1. Assign a trigger to run the onOpen function "On open" (`Edit > Current Project's Triggers`)
1. After authorizing the script, reload the original document
1. Use the new menu item to format selected text (`Styles > Format Code`)

[Source](https://webapps.stackexchange.com/a/117682/56505)

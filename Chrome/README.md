# Chrome

## Export/import search engines

Run the code in the following files in your DevTools console:

- to export to a JSON file: [`export.js`](export.js)
- to import from a JSON file: [`import.js`](import.js)

* Source: https://superuser.com/questions/280694/how-can-i-share-my-google-chrome-search-engine-entries

## Change Google Chrome cache folder

```powershell
$MyRegKey = Get-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\ChromeHTML\shell\open\command
$NewValue = $MyRegKey.'(Default)' + ' --disk-cache-dir="C:\Temp\Chrome"'
Set-ItemProperty -Path Registry::HKEY_CLASSES_ROOT\ChromeHTML\shell\open\command -Name '(Default)' -Value $NewValue
```

Default value on my machine = `"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" -- "%1"`
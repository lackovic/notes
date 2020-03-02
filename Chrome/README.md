# Chrome

## Export/import search engines

Run the code in the following files in your DevTools console:

- to export to a JSON file: [`export.js`](export.js)
- to import from a JSON file: [`import.js`](import.js)

* Source: https://superuser.com/questions/280694/how-can-i-share-my-google-chrome-search-engine-entries

## Change Google Chrome cache folder

```powershell
$Path = "Registry::HKEY_LOCAL_MACHINE\Software\Policies\Google\Chrome"
if (-not (Test-Path $Path)) { New-item -Path $Path -Force }
Set-ItemProperty -Path $Path -Name 'DiskCacheDir' -Value 'C:\Temp\Chrome'
```

This will move Chrome cache folder to `C:\Temp\Chrome` system-wide, for every user and regardless where Chrome is started from (shortcut or command line).

Default value: `%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache`

- [Source](http://www.chromium.org/administrators/policy-list-3#DiskCacheDir)

# Chrome

## Export/import search engines

Run the code in the following files in your DevTools console:

- to export to a JSON file: [`export.js`](export.js)
- to import from a JSON file: [`import.js`](import.js)

* Source: https://superuser.com/questions/280694/how-can-i-share-my-google-chrome-search-engine-entries

## Change Google Chrome cache folder

```powershell
Set-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Policies\Google\Chrome -Name 'DiskCacheDir' -Value 'C:\Temp\Chrome'
```

- [Source](http://www.chromium.org/administrators/policy-list-3#DiskCacheDir)

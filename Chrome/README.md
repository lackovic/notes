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

## Favorite extensions

- [I don't care about cookies](https://chrome.google.com/webstore/detail/i-dont-care-about-cookies/fihnjjcciajhdojfnbdddfaoknhalnja)

- [Privacy Badger](https://chrome.google.com/webstore/detail/privacy-badger/pkehgijcmpdhfbdbbnkijodmdjhbjlgp)

- [Google Meet Grid View](https://chrome.google.com/webstore/detail/google-meet-grid-view/bjkegbgpfgpikgkfidhcihhiflbjgfic)

- [Keepa - Amazon Price Tracker](https://chrome.google.com/webstore/detail/keepa-amazon-price-tracke/neebplgakaahbhdphmkckjjcegoiijjo?hl=en)

- [Save to Pocket](https://chrome.google.com/webstore/detail/save-to-pocket/niloccemoadcdkdjlinkgdfekeahmflj?hl=en)

- [Pocket Must Reads](https://chrome.google.com/webstore/detail/pocket-must-reads/mlnnopicjonfamklpcdfnbcomdlopmof)

- [Pop up blocker for Chrome - Poper Blocker](https://chrome.google.com/webstore/detail/pop-up-blocker-for-chrome/bkkbcggnhapdmkeljlodobbkopceiche?hl=en)

- [Send from Gmail (by Google)](https://chrome.google.com/webstore/detail/send-from-gmail-by-google/pgphcomnlaojlmmcjmiddhdapjpbgeoc)

- [Google Translate](https://chrome.google.com/webstore/detail/google-translate/aapbdbdomjkkjkaonfhkkikfgjllcleb)

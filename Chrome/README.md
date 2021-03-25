# Chrome

## Export/import search engines

1. Enter [`chrome://settings/searchEngines`](chrome://settings/searchEngines) in the address bar of Chrome to

1. Run the code in the following files in your DevTools console:

   - to export to a JSON file: [`export.js`](export.js)
   - to import from a JSON file: [`import.js`](import.js)

* [Source](https://superuser.com/a/1458616/54747)

## Change Google Chrome cache folder

```powershell
$Path = "Registry::HKEY_LOCAL_MACHINE\Software\Policies\Google\Chrome"
if (-not (Test-Path $Path)) { New-item -Path $Path -Force }
Set-ItemProperty -Path $Path -Name 'DiskCacheDir' -Value 'C:\Temp\Chrome'
```

This will move Chrome cache folder to `C:\Temp\Chrome` system-wide, for every user and regardless where Chrome is started from (shortcut or command line).

Default value: `%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache`

- [Source](http://www.chromium.org/administrators/policy-list-3#DiskCacheDir)

## Install Chrome in Ubuntu

```sh
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update
sudo apt-get install google-chrome-stable
```

## Must have extensions

- [I don't care about cookies](https://chrome.google.com/webstore/detail/i-dont-care-about-cookies/fihnjjcciajhdojfnbdddfaoknhalnja)

- [Don't add custom search engines](https://chrome.google.com/webstore/detail/dont-add-custom-search-en/dnodlcololidkjgbpeoleabmkocdhacc?hl=en)

- [Pop up blocker for Chrome - Poper Blocker](https://chrome.google.com/webstore/detail/pop-up-blocker-for-chrome/bkkbcggnhapdmkeljlodobbkopceiche?hl=en)

## Useful extensions

- [Improve YouTube! (Open-Source for YouTube)](https://chrome.google.com/webstore/detail/improve-youtube-open-sour/bnomihfieiccainjcjblhegjgglakjdd/related)

- [Privacy Badger](https://chrome.google.com/webstore/detail/privacy-badger/pkehgijcmpdhfbdbbnkijodmdjhbjlgp)

- [Google Meet Grid View](https://chrome.google.com/webstore/detail/google-meet-grid-view/bjkegbgpfgpikgkfidhcihhiflbjgfic)

- [Keepa - Amazon Price Tracker](https://chrome.google.com/webstore/detail/keepa-amazon-price-tracke/neebplgakaahbhdphmkckjjcegoiijjo?hl=en)

- [Save to Pocket](https://chrome.google.com/webstore/detail/save-to-pocket/niloccemoadcdkdjlinkgdfekeahmflj?hl=en)

- [Pocket Must Reads](https://chrome.google.com/webstore/detail/pocket-must-reads/mlnnopicjonfamklpcdfnbcomdlopmof)

- [Send from Gmail (by Google)](https://chrome.google.com/webstore/detail/send-from-gmail-by-google/pgphcomnlaojlmmcjmiddhdapjpbgeoc)

- [Google Translate](https://chrome.google.com/webstore/detail/google-translate/aapbdbdomjkkjkaonfhkkikfgjllcleb)

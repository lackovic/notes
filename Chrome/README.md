# Chrome

_Table of Contents_
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc)* -->

- [Export/import search engines](#exportimport-search-engines)
- [Disable notifications from all sites](#disable-notifications-from-all-sites)
- [Change Google Chrome cache folder](#change-google-chrome-cache-folder)
- [Install Chrome in Ubuntu](#install-chrome-in-ubuntu)
- [Must have extensions](#must-have-extensions)
- [Useful extensions](#useful-extensions)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Export/import search engines

1. Enter [`chrome://settings/searchEngines`](chrome://settings/searchEngines) in the address bar of Chrome to

1. Run the code in the following files in your DevTools console:

   - to export to a JSON file: [`export.js`](export.js)
   - to import from a JSON file: [`import.js`](import.js)

* [Source](https://superuser.com/a/1458616/54747)

## Disable notifications from all sites

Settings > Site Settings > Notifications > Sites can ask to send notifications = OFF

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

- [uBlacklist](https://chrome.google.com/webstore/detail/ublacklist/pncfbmialoiaghdehhbnbhkkgmjanfhe) in conjuction with [ublacklist-stackoverflow-translation](https://github.com/arosh/ublacklist-stackoverflow-translation)

- [Ghostery – Privacy Ad Blocker](https://chrome.google.com/webstore/detail/ghostery-%E2%80%93-privacy-ad-blo/mlomiejdfkolichcflejclcbmpeaniij)

## Useful extensions

- [Improve YouTube! (Open-Source for YouTube)](https://chrome.google.com/webstore/detail/improve-youtube-open-sour/bnomihfieiccainjcjblhegjgglakjdd/related)

- [Privacy Badger](https://chrome.google.com/webstore/detail/privacy-badger/pkehgijcmpdhfbdbbnkijodmdjhbjlgp)

- [Keepa - Amazon Price Tracker](https://chrome.google.com/webstore/detail/keepa-amazon-price-tracke/neebplgakaahbhdphmkckjjcegoiijjo?hl=en)

- [Save to Pocket](https://chrome.google.com/webstore/detail/save-to-pocket/niloccemoadcdkdjlinkgdfekeahmflj?hl=en)

- [Google Translate](https://chrome.google.com/webstore/detail/google-translate/aapbdbdomjkkjkaonfhkkikfgjllcleb)

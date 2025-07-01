# Chrome

_Table of Contents_
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
<!-- generated with [DocToc](https://github.com/thlorenz/doctoc)* -->

- [Export/import search engines](#exportimport-search-engines)
- [Disable notifications from all sites](#disable-notifications-from-all-sites)
- [Change Google Chrome cache folder](#change-google-chrome-cache-folder)
- [Install Chrome in Ubuntu](#install-chrome-in-ubuntu)
- [Set the Material You theme](#set-the-material-you-theme)
- [Must have extensions](#must-have-extensions)
- [YouTube extensions](#youtube-extensions)
- [Other useful extensions](#other-useful-extensions)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Make a Chrome shortcut open the default profile in Windows

Append `--profile-directory="Default"` to the target of the shortcut

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

## Set the Material You theme

1. three-dot menu in the top-right corner > _Help_ > _About Google Chrome_;

1. verify you have at version 116.0.5845.179/.180 or higher;

1. paste `chrome://flags` in the address bar and press Enter;

1. search for _Chrome Refresh_ 

1. enable both the following flags:
   
   ```
   chrome://flags/#chrome-refresh-2023
   chrome://flags/#chrome-webui-refresh-2023
   ```

1. click on _Relaunch_ at the bottom.

See also:

- [Chrome gets a fresh look and new features for its 15th birthday](https://blog.google/products/chrome/google-chrome-new-features-redesign-2023/)

## Must have extensions

- [I don't care about cookies](https://chrome.google.com/webstore/detail/i-dont-care-about-cookies/fihnjjcciajhdojfnbdddfaoknhalnja)

- [Don't add custom search engines](https://chrome.google.com/webstore/detail/dont-add-custom-search-en/dnodlcololidkjgbpeoleabmkocdhacc?hl=en)

- [History Blocker by Site](https://chromewebstore.google.com/detail/history-blocker-by-site/keamekimefemnbgegbfkdkmbomaahfai?pli=1) (see [this](https://superuser.com/questions/1684345/delete-translate-google-com-from-chrome-history))

- [Pop up blocker for Chrome - Poper Blocker](https://chrome.google.com/webstore/detail/pop-up-blocker-for-chrome/bkkbcggnhapdmkeljlodobbkopceiche?hl=en)

- [uBlacklist](https://chrome.google.com/webstore/detail/ublacklist/pncfbmialoiaghdehhbnbhkkgmjanfhe) in conjuction with [ublacklist-stackoverflow-translation](https://github.com/arosh/ublacklist-stackoverflow-translation)

- [Ghostery – Privacy Ad Blocker](https://chrome.google.com/webstore/detail/ghostery-%E2%80%93-privacy-ad-blo/mlomiejdfkolichcflejclcbmpeaniij)

## YouTube extensions

- [Return YouTube Dislike](https://chromewebstore.google.com/detail/return-youtube-dislike/gebbhagfogifgggkldgodflihgfeippi)

- [SponsorBlock](https://chromewebstore.google.com/detail/sponsorblock-for-youtube/mnjggcdmjocbbbhaepdhchncahnbgone): skips sponsorships, intros, and reminders.

- [PocketTube](https://chromewebstore.google.com/detail/pockettube-youtube-subscr/kdmnjgijlmjgmimahnillepgcgeemffb): groups subscriptions into collections.

- [Ad Auto-skipper](https://chromewebstore.google.com/detail/youtube-ad-auto-skipper/lokpenepehfdekijkebhpnpcjjpngpnd)

## Other useful extensions

- [Privacy Badger](https://chrome.google.com/webstore/detail/privacy-badger/pkehgijcmpdhfbdbbnkijodmdjhbjlgp)

- [Keepa - Amazon Price Tracker](https://chrome.google.com/webstore/detail/keepa-amazon-price-tracke/neebplgakaahbhdphmkckjjcegoiijjo?hl=en)

- [Save to Pocket](https://chrome.google.com/webstore/detail/save-to-pocket/niloccemoadcdkdjlinkgdfekeahmflj?hl=en)

- [Rememberry](https://chromewebstore.google.com/detail/rememberry-translate-and/dipiagiiohfljcicegpgffpbnjmgjcnf): translates selected text to any language.

- [Disable keyboard shortcuts](https://chromewebstore.google.com/detail/disable-keyboard-shortcut/aidbmcboeighgdnilpdljbedbbiocphj) (used to disable `Ctrl+D` to bookmark the current page, which is often pressed accidentally)

; AutoHotkey is a scripting language for Microsoft Windows which provides
; keyboard shortcuts that allows users to automate repetitive tasks.
;
; Hotkey Modifier Symbols
; https://www.autohotkey.com/docs/Hotkeys.htm#Symbols
;
; 1. Install it with winget: winget install -e --id AutoHotkey.AutoHotkey
; 2. Copy this file to shell:startup
; 3. Run AutoHotkey
; --------------------------------------------------------------
; ^ = ctrl
; ! = alt
; + = shift
; # = lwin|rwin
; --- Web pages ---------------------------------------------------------------

; Ctrl+Alt+C = opens Google Calendar in a new window of Chrome
; Ctrl+Alt+D = opens Google Drive in a new window of Chrome
; Ctrl+Alt+G = opens Gmail in a new window of Chrome
; Ctrl+Alt+M = opens Google Maps in a new window of Chrome
; Ctrl+Alt+T = opens Google Translate in a new window of Chrome

^!+#c::Run("Chrome.exe `"https://calendar.google.com/`" `" --new-window `"")
^!+#g::Run("Chrome.exe `"https://mail.google.com/`" `" --new-window   `"")
^!+#m::Run("Chrome.exe `"https://www.google.ee/maps/`" `" --new-window `"")
^!+#j::Run("Chrome.exe `"https://keep.google.com/`" `" --new-window `"")
^!+#t::Run("Chrome.exe `"https://translate.google.com/`" `" --new-window `"")
^!+#x::
{
    if WinExist("Telegram")
        WinActivate()
    else
        Run("`"C:\Users\marco\AppData\Roaming\Telegram Desktop\Telegram.exe`"")
    return
}

; --- Local apps --------------------------------------------------------------

; Ctrl+Alt+K = launches or brings to front KeePass
^+#!k::
{
    if WinExist("KeePass")
        WinActivate()
    else
        Run("`"C:\Program Files (x86)\KeePass2x\KeePass.exe`"")
    return
}

; --- File Explorer -----------------------------------------------------------

; F4 = sets view to details and all columns to fit width
F4::
{
    Send("{LCtrl down}{LShift down}6{LCtrl up}{LShift up}")
    Send("{LCtrl down}{NumpadAdd}{LCtrl up}")
    return
}

; --- Acronyms ----------------------------------------------------------------

::bbl::be back later
::brb::be right back
::btw::by the way

; --- SQL ---------------------------------------------------------------------

::sfr::SELECT * FROM
:o:slk::LIKE '%%'{Left 2}

; --- Markdown --------------------------------------------------------------------

:o:mkc::````{Left 1}
:o:mkbc::```````n`n`````` {Up 1}

; --- Disable Windows hotkeys -----------------------------------------------------

#w::return ; pen settings
#c::return ; cortana/copilot
#i::return ; system settings
#g::return ; Game Bar Xbox
#+::return ; zoom
#k::return ; Connect
#f::return ; feedback hub
#,::return ; show open windows transparent
; #v::return ; Clipboard history
; #p::return ; monitor settings
; #a::return ; notification sidebar
; #r::return ; run dialog
; #l::return ; sign out
; #.::return ; Emojis

; --- System ------------------------------------------------------------------

; Win+F12 = Puts the computer to sleep
; ^#F12::
; { 
;     ; Sleep/Suspend:
;     DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)
;     ; Hibernate:
;     ;DllCall("PowrProf\SetSuspendState", "int", 1, "int", 0, "int", 0)
;     return
; }

; --- Typography ------------------------------------------------------------------

; Associates Alt Gr + , with ~ (, VK=BC SC=033 ~={U+223C})
;<^>!,::Send("{Text}~")

; Associates Alt Gr + . with ` (. VK=BE SC=034 `={U+0060})
;<^>!.::Send("{Text}``")

; Associates Alt Gr + - with — (- VK=BD SC=035 —={U+2014})
;<^>!-::Send("{Text}—")

; Replaces § with ~
;+SC02B::~
; Replaces ç with `
;+SC027::`

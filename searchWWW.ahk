;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Automate boring stuff with Auto Hotkey                                                                                           ;
; 24/02/2025                                                                                                                       ;
; This script can use clipboard text content or your selected text to search chrome web browser, or youtube or else it can give    ;
; the content as a prompt to ChatGPT or Deepseek.                                                                                  ;
; PrintScreen -> google search                                                                                                     ;
; ScrollLock -> youtube search                                                                                                     ;
; Pause -> prompt ChatGPT                                                                                                          ;
; Insert -> prompt Deepseek                                                                                                        ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;press PrintScreen to search selected text or clipboard on google
PrintScreen::
    PreventDoubleTriggering()
    query := GetQuery()
    Run, https://www.google.com/search?q=%query%
    return

;press PrintScreen to search selected text or clipboard on youtube
ScrollLock::
    PreventDoubleTriggering()
    query := GetQuery()
    Run, https://www.youtube.com/results?search_query=%query%
    return

;press Pause to prompt ChatGPT
Pause::
    PreventDoubleTriggering()
    query := GetQuery()
    
    Run, https://chat.openai.com/chat
    
    WinWaitActive, ahk_class Chrome_WidgetWin_1
    Sleep, 2000
    Send, ^v  ; (Ctrl + V)
    Sleep, 0025
    Send, {Enter}
    return

;press Insert to prompt Deepseek
Insert::
    PreventDoubleTriggering()
    query := GetQuery()
   
    Run, https://chat.deepseek.com/
    
    WinWaitActive, ahk_class Chrome_WidgetWin_1
    Sleep, 1000
    Send, ^v  ; (Ctrl + V)
    Sleep, 0025
    Send, {Enter}
    return

GetQuery() {
    Send, ^c  ; (Ctrl + C)
    ClipWait, 1
    if (Clipboard != "" && ClipboardAll != Clipboard){
    	return Clipboard
    }
    return   
}

PreventDoubleTriggering(){
    if (A_PriorHotkey = "PrintScreen" and A_TimeSincePriorHotkey < 400)
        return	
}

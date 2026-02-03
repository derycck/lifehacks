#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, [force]
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; --- LEITURA DE CONFIGURAÇÃO ---
IniRead, EverythingPath, %A_ScriptDir%\config.ini, AppPaths, Everything, %A_Space%
IniRead, ShareReadyPath, %A_ScriptDir%\config.ini, AppPaths, ShareReady, %A_Space%
IniRead, RandomMsgTudoBem, %A_ScriptDir%\config.ini, AppPaths, MsgTudoBem, %A_Space%
IniRead, RandomMsgAfk, %A_ScriptDir%\config.ini, AppPaths, MsgAfk, %A_Space%
IniRead, CamsetPath, %A_ScriptDir%\config.ini, AppPaths, Camset, %A_Space%
;
; Exemplo de arquivo config.ini
;
; [AppPaths]
; Everything=D:\app\everything\1.5\Everything.lnk
; ShareReady=D:\AHK\scripts\ShareReady.ahk
;
; -------------------------------
; super vertical window
ResizeWin(Width = 0,Height = 0)
{
  WinGetPos,X,Y,W,H,A
  If %Width% = 0
    Width := W

  If %Height% = 0
    Height := H

  WinRestore, A ; restore window if in fullscreen mode
  WinMove,A,,35,-1400,%Width%,%Height% ; resize centralize. 420 = (1920-1200)/2 | 35 = (1280-30-1240)/2+30  (40=30, 5, 5)
}

RAlt & U::
if GetKeyState("Shift", "P") ; Se Shift estiver (P)ressionado
    {
        ; RAlt + Shift + U
        ; Move janelas ativas no monitor 2 para o monitor 1
        Run, %ShareReadyPath%
    }
    Else
    {
        ; RAlt + U
        ; super vertical window
        ResizeWin(1300,2150)
    }
return

; volumes
LWin & F2::SoundSet,-1
LWin & F3::SoundSet,+1
RAlt & -::SoundSet,-1
RAlt & =::SoundSet,+1

; Ativar janela do Wezterm
LWin & space::
    if WinExist("ahk_exe wezterm-gui.exe")
        WinActivate
    else
        Run, wezterm
return

; enter
RAlt & 9::send {blind}{enter}

; insert
RAlt & SC027::send {Insert} ;ç

; asterisco
SC028::send {*} ;~

; &
RAlt & SC028::send {&} ;~

; backspace
RAlt & space::send {blind}{BackSpace}

; til chapeu agudo grave
RAlt & a::send {~}
RAlt & s::send {^}
RAlt & v::send {``}
RAlt & c::send {SC01A} ; agudo
; Usado simulação de tecla física com o Scan Code (SC) 01A, para manter o comportamento de dead key, para acentuar a próxima letra.

; brackets curly brackets
; Adicionar função de Shift para enviar: $
RAlt & e::
    if(GetKeyState("Shift", "P")) {
        send {$}
    } else {
        send {[}
    }
return

; Adicionar função de Shift para enviar: %
RAlt & r::
    if(GetKeyState("Shift", "P")) {
        send {`%}
    } else {
        send {]}
    }
return

; Adicionar função de Shift para enviar: &
RAlt & d::
    if(GetKeyState("Shift", "P")) {
        send {&}
    } else {
        send {{}
    }
return

; Adicionar função de Shift para enviar: *
RAlt & f::
    if(GetKeyState("Shift", "P")) {
        send {*}
    } else {
        send {}}
    }
 return

; pgup pgdown
RAlt & n::send {blind}{pgup}
RAlt & m::send {blind}{PgDn}

; Desabilitar Capslock
Capslock & Shift::return ; anula shift capslock
Capslock::return ; anula capslock isolado

; Delete
; Ctrl & Capslock::return ; anula ctrl capslock
Capslock & space::send {blind}{delete}

; blind ensure that others hotkeys (ctrl, shift, alt) will be send with the binds
; home and end keys
RAlt & p::send {blind}{End}
RAlt & o::send {blind}{Home}

; RAlt+w=? | RAlt+shift+q=:
RAlt & w::
    if(GetKeyState("Shift", "P")) {
        send, {:}
    } else {
        send, {?}
    }
return

; RAlt+q=/ | RAlt+shift+q=;
RAlt & q::
    if(GetKeyState("Shift", "P")) {
        send, {;}
    } else {
        send, {/}
    }
return

; RAlt+z=\
RAlt & z::send, {\}

; RAlt+x=|
RAlt & x::send, {|}

; win+f para pesquisa no app everything
#F::
if (EverythingPath != "" && FileExist(EverythingPath))
    Run, %EverythingPath%
else
    MsgBox, 16, Erro, "O caminho do Everything nao foi configurado ou nao existe valida no config.ini".
return

; Mudar o dispositivo de áudio padrão para headphone
RAlt & 4::Run, %ComSpec% /c "nircmd.exe setdefaultsounddevice "Realtek HD Audio 2nd output" 1"

; Mudar o dispositivo de áudio padrão para autofalantes
RAlt & 5::Run, %ComSpec% /c "nircmd.exe setdefaultsounddevice "Alto-falantes-notebook" 1"

; Arrows & navigation start
Hotkey, *h, Off
Hotkey, *j, Off
Hotkey, *k, Off
Hotkey, *l, Off

*RAlt::
    Hotkey, *i, on
    Hotkey, *j, on
    Hotkey, *k, on
    Hotkey, *l, on

return

*RAlt up::
    Hotkey, *i, off
    Hotkey, *j, off
    Hotkey, *k, off
    Hotkey, *l, off
return

*k::send {blind}{down}
*j::send {blind}{left}
*i::send {blind}{up}
*l::send {blind}{right}
; -- Arrows & navigation end

; Inserir mensagem por atalho
RAlt & 1::
    Run, %RandomMsgTudoBem%
return

RAlt & 2:: ; Respondendo que estou ausente
    Run, %RandomMsgAfk%
return

; Exclusivo para janela de configuração da webcam. Video Proc Amp Properties
#IfWinActive, ahk_class #32770
; Configurar webcam via script Camset
F1::
    Run, %CamsetPath%
return
#IfWinActive
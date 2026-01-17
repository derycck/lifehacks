; Script de AutoHotkey v1.1 que move janelas do Monitor 2 para o monitor 1.

; Utilidade: Antes de iniciar uma video-conferência com compartilhamento de tela, é essencial mover todas as janelas abertas para o monitor q não terá tela-compartilhada, evitando exibir algo pessoal por acidente.

#NoEnv
#SingleInstance, Force

; Obtém informações sobre os monitores
SysGet, MonitorCount, MonitorCount

; Loop para pegar coordenadas de cada monitor
Loop, %MonitorCount% {
    SysGet, Mon%A_Index%, Monitor, %A_Index%
    ; MonNLeft, MonNTop, MonNRight, MonNBottom são criados aqui
}

if (MonitorCount < 2)
    ExitApp

; WinGet obtém a lista de todos os IDs de janelas
WinGet, id, List,,, Program Manager

Loop, %id% {
    this_id := id%A_Index%
    WinGetTitle, this_title, ahk_id %this_id%

    ; Filtra janelas sem título ou invisíveis para limpar a saída
    if (this_title = "")
        continue

    ; Verifica se a janela está visível
    WinGet, Style, Style, ahk_id %this_id%
    if !(Style & 0x10000000) ; WS_VISIBLE
        continue

    ; Pega a posição central da janela para decidir onde ela está
    WinGetPos, X, Y, Width, Height, ahk_id %this_id%
    CenterX := X + (Width / 2)
    CenterY := Y + (Height / 2)

    ; Verifica se o centro da janela cai no Monitor 2
    if (CenterX >= Mon2Left && CenterX < Mon2Right && CenterY >= Mon2Top && CenterY < Mon2Bottom) {
        ; Verifica se a janela está maximizada
        WinGet, WinState, MinMax, ahk_id %this_id%

        if (WinState = 1) { ; Maximizada
            WinRestore, ahk_id %this_id%
            WinMove, ahk_id %this_id%,, Mon1Left, Mon1Top
            WinMaximize, ahk_id %this_id%
        } else { ; Normal
            ; Calcula posição relativa no Monitor 1
            NewX := X - Mon2Left + Mon1Left
            NewY := Y - Mon2Top + Mon1Top
            WinMove, ahk_id %this_id%,, NewX, NewY
        }
    }
}

ExitApp
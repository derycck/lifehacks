; Script de AutoHotkey v1.1 que move janelas do Monitor 2 para o monitor 1.

; Utilidade: Antes de iniciar uma video-conferência com compartilhamento de tela, é essencial mover todas as janelas abertas para o monitor que não terá tela-compartilhada, evitando exibir algo pessoal por acidente.

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
; Captura a janela ativa para não movê-la
WinGet, active_id, ID, A
; Calcula a largura e altura do Monitor 1 para redimensionar janelas grandes
Mon1Width  := Mon1Right  - Mon1Left
Mon1Height := Mon1Bottom - Mon1Top
; A variável id é do tipo lista de IDs de janelas
Loop, %id% {
    this_id := id%A_Index%
    ; Se a janela analisada for a janela ativa, não move
    if (this_id = active_id)
        continue
    ; Pega o título da janela a partir do ID. eg: this_title = WinGetTitle(ahk_id=this_id)
    WinGetTitle, this_title, ahk_id %this_id%

    ; Filtra janelas sem título ou invisíveis para limpar a saída
    if (this_title = "")
        continue

    ; Verifica se a janela está visível
    ; Style command retrieves an 8-digit hexadecimal number representing the style of a window.
    ; https://www.autohotkey.com/docs/v1/lib/WinGet.htm#SubCommands
    WinGet, Style, Style, ahk_id %this_id%
    if !(Style & 0x10000000) ; WS_VISIBLE
        ; Se a janela não estiver visível, pula.
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
            ; NewX := X - Mon2Left + Mon1Left
            ; NewY := Y - Mon2Top + Mon1Top
            ; WinMove, ahk_id %this_id%,, NewX, NewY
            ; Se a janela for maior que o monitor 1, redimensiona para caber
            WinMove, ahk_id %this_id%,, Mon1Left, Mon1Top, Mon1Width, Mon1Height

        }
    }
}

ExitApp
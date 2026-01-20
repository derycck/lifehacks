#NoEnv
#SingleInstance, force

SetTitleMatchMode, 2

WinTitle := "ahk_class #32770"
SliderValue := 50

; padrao
ControlGetPos, X, Y, Width, Height, Button10, %WinTitle%
CenterX := X + (Width / 2)
CenterY := Y + (Height / 2)
MouseMove, %CenterX%, %CenterY%
MouseClick, L, %CenterX%, %CenterY%

; Brilho
; ControlGetPos, X, Y, Width, Height, msctls_trackbar321, %WinTitle%
; CenterX := X + (Width / 2)
; CenterY := Y + (Height / 2)
; MouseMove, %CenterX%, %CenterY%
; MouseClickDrag, L, %CenterX%, %CenterY%, % CenterX + 9, %CenterY%
; ControlClick, msctls_trackbar321, %WinTitle% ; -1

; Contraste
ControlGetPos, X, Y, Width, Height, msctls_trackbar322, %WinTitle%
slider_default_pos := - 55
CenterX := X + (Width / 2) + slider_default_pos ; posicionar no interruptor do slider
CenterY := Y + (Height / 2)
MouseMove, %CenterX%, %CenterY%
goal := 47
delta := (goal - 32) / 1.85  ; Para cada 1.85 pontos acima de 32, move 1 pixel
MouseClickDrag, L, %CenterX%, %CenterY%, % CenterX + delta, %CenterY%
ControlClick, msctls_trackbar322, %WinTitle% ; +1  | nao usar esse comando

; Matiz
ControlGetPos, X, Y, Width, Height, msctls_trackbar323, %WinTitle%
slider_default_pos := 0
CenterX := X + (Width / 2) + 0 ; posicionar no interruptor do slider
CenterY := Y + (Height / 2)
MouseMove, %CenterX%, %CenterY%
goal := -10
delta := (goal - 0) / (48/20)
; Para cada 2.4 pontos acima de 0, move 1 pixel
; ao subir 20 pixels, subiu 48 pontos
MouseClickDrag, L, %CenterX%, %CenterY%, % CenterX + delta, %CenterY%
ControlClick, msctls_trackbar322, %WinTitle% ; +1  | nao usar esse comando

; Saturação
ControlGetPos, X, Y, Width, Height, msctls_trackbar324, %WinTitle%
slider_default_pos := 20
CenterX := X + (Width / 2) + slider_default_pos ; posicionar no interruptor do slider
CenterY := Y + (Height / 2)
MouseMove, %CenterX%, %CenterY%
goal := 90
delta := (goal - 64) * 1.5  ; Para cada 1.5 pontos acima de 64, move 1 pixel^^
MouseClickDrag, L, %CenterX%, %CenterY%, % CenterX + delta, %CenterY%

; Gama
ControlGetPos, X, Y, Width, Height, msctls_trackbar326, %WinTitle%
CenterX := X + (Width / 2)
CenterY := Y + (Height / 2)
MouseMove, %CenterX%, %CenterY%
goal := 120
delta := (goal - 120) / (1/2.5)  ; Para cada 1/2.5 pontos acima de 120, move 1 pixel
MouseClickDrag, L, %CenterX%, %CenterY%, % CenterX + delta, %CenterY%

; Controle de branco
; - Remover do automatico - Click checkbox
ControlGetPos, X, Y, Width, Height, Button7, %WinTitle%
CenterX := X + (Width / 2)
CenterY := Y + (Height / 2)
MouseMove, %CenterX%, %CenterY%
MouseClick, L, %CenterX%, %CenterY%
; - Ajuste do controle de branco
ControlGetPos, X, Y, Width, Height, msctls_trackbar327, %WinTitle%
slider_default_pos := -25
CenterX := X + (Width / 2) + slider_default_pos
CenterY := Y + (Height / 2)
; Mover e arrastar o mouse
MouseMove, %CenterX%, %CenterY%
goal := 4800
delta := (goal - 4000) / 25  ; Para cada 25 pontos acima de 4000, move 1 pixel
MouseClickDrag, L, %CenterX%, %CenterY%, % CenterX + delta, %CenterY%

; Composição de luz de fundo
ControlGetPos, X, Y, Width, Height, msctls_trackbar328, %WinTitle%
CenterX := X + (Width / 2)
CenterY := Y + (Height / 2)
; Mover e arrastar o mouse
MouseMove, %CenterX%, %CenterY%
MouseClickDrag, L, %CenterX%, %CenterY%, % CenterX + 50, %CenterY%


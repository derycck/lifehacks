"""
Move janelas do Monitor 2 para o monitor 1.

Utilidade: Antes de iniciar uma video-conferência com compartilhamento de tela,
é essencial mover todas as janelas abertas para o monitor q não terá
tela-compartilhada, evitando exibir algo pessoal por acidente.

Cenário: Você vai compartilhar a tela do Monitor 2 no Teams/Zoom/Slack e quer
garantir que nenhuma janela pessoal (WhatsApp, Bloco de Notas com senhas, etc.)
esteja visível lá.

Requisito: lib pywin32
"""

import ctypes

import win32api
import win32con
import win32gui

# ==============================================================================
# Configuração de DPI Awareness
# Essencial para que as coordenadas funcionem corretamente em setups com
# escalas diferentes (ex: Laptop 150% + Monitor Externo 100%)
# ==============================================================================
try:
    ctypes.windll.shcore.SetProcessDpiAwareness(1)  # PROCESS_SYSTEM_DPI_AWARE
except Exception:
    ctypes.windll.user32.SetProcessDPIAware()


def get_monitor_info():
    """
    Retorna uma lista de retângulos (left, top, right, bottom) dos monitores.
    Equivalente ao Loop SysGet do AHK.
    """
    monitors = win32api.EnumDisplayMonitors()
    # monitors retorna uma lista de tuplas: (hMonitor, hdcMonitor, PyRect)
    # PyRect é (left, top, right, bottom)
    monitor_rects = [
        win32api.GetMonitorInfo(m[0])["Monitor"] for m in monitors
    ]
    return monitor_rects


def move_windows_from_secondary_to_primary():
    monitors = get_monitor_info()

    if len(monitors) < 2:
        print("Menos de 2 monitores detectados. Encerrando.")
        return

    # Definindo Monitor 1 (Alvo) e Monitor 2 (Origem)
    # Nota: A ordem depende de como o Windows enumera.
    # Assume-se aqui index 0 = Primário/Target e index 1 = Secundário/Source
    # Isso mapeia a lógica Mon1 e Mon2 do script AHK.
    target_mon = monitors[0]  # Mon1 (Destino)
    source_mon = monitors[1]  # Mon2 (Origem - onde as janelas estão agora)

    # Desempacotando coordenadas para clareza (Source)
    s_left, s_top, s_right, s_bottom = source_mon
    # Desempacotando coordenadas para clareza (Target)
    t_left, t_top, _, _ = target_mon

    def enum_window_callback(hwnd, _):
        """Callback executado para cada janela de nível superior."""

        # 1. Filtro: Título Vazio
        title = win32gui.GetWindowText(hwnd)
        if not title:
            return

        # 2. Filtro: Program Manager (Desktop)
        if title == "Program Manager":
            return

        # 3. Filtro: Visibilidade (WS_VISIBLE)
        # IsWindowVisible é wrapper direto do bit check (Style & 0x10000000)
        if not win32gui.IsWindowVisible(hwnd):
            return

        # 4. Geometria: Pegar bounding box da janela
        try:
            rect = win32gui.GetWindowRect(
                hwnd
            )  # Retorna (left, top, right, bottom)
        except Exception:
            # Algumas janelas podem fechar durante a iteração
            return

        x, y, r, b = rect
        width = r - x
        height = b - y

        # Calcular o centróide
        center_x = x + (width // 2)
        center_y = y + (height // 2)

        # 5. Lógica: O centro está dentro do Monitor 2 (Source)?
        is_in_source = (
            center_x >= s_left
            and center_x < s_right
            and center_y >= s_top
            and center_y < s_bottom
        )

        if is_in_source:
            print(f"Movendo: {title}")

            # Verificar estado da janela (Maximizada, Minimizada ou Normal)
            # GetWindowPlacement retorna tupla, índice 1 é o cmdShow
            placement = win32gui.GetWindowPlacement(hwnd)
            show_cmd: int = placement[1]

            is_maximized = show_cmd == win32con.SW_SHOWMAXIMIZED  # 3

            if is_maximized:
                # Equivalente a WinRestore -> WinMove -> WinMaximize
                # Nota: SW_RESTORE é necessário antes de mover entre monitores
                # para recalcular DPI/Bordas corretamente.
                win32gui.ShowWindow(hwnd, win32con.SW_RESTORE)

                # Move para a posição 0,0 do monitor alvo (Left, Top)
                # width e height são mantidos (embora irrelevantes pois será maximizada logo em seguida)
                win32gui.MoveWindow(hwnd, t_left, t_top, width, height, True)

                win32gui.ShowWindow(hwnd, win32con.SW_MAXIMIZE)
            else:
                # Janela Normal/Flutuante
                # Calcular posição relativa
                # NewX = X Atual - Esquerda Monitor Origem + Esquerda Monitor Destino
                new_x = x - s_left + t_left
                new_y = y - s_top + t_top

                # WinMove em Python requer X, Y, W, H e flag de Repaint
                win32gui.MoveWindow(hwnd, new_x, new_y, width, height, True)

    # Inicia a iteração
    win32gui.EnumWindows(enum_window_callback, None)


if __name__ == "__main__":
    move_windows_from_secondary_to_primary()

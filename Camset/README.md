# Camset AutoHotkey v1.1

**Problema:** Webcams genéricas ou drivers padrão do Windows (UVC) frequentemente perdem suas configurações de imagem (brilho, contraste, balanço de branco, etc.) ao reiniciar o computador ou desconectar a câmera. Ajustar manualmente os sliders na janela de propriedades toda vez é repetitivo, impreciso e consome tempo antes de reuniões.

**Solução:** Um script que automatiza a interação com a janela padrão de propriedades de vídeo do Windows ("Video Proc Amp"). Ele localiza a janela, clica no botão "Padrão" para resetar e então arrasta cada slider (Contraste, Saturação, Gama, etc.) para posições pré-definidas e otimizadas para o ambiente do usuário.

## Como funciona
O script assume que a janela de propriedades da webcam está aberta (`ahk_class #32770`). Ele realiza a seguinte sequência:

1.  **Reset:** Clica no botão de restaurar padrões.
2.  **Contraste:** Define valor ~47.
3.  **Matiz:** Define valor ~-10.
4.  **Saturação:** Define valor ~90.
5.  **Gama:** Define valor ~120.
6.  **Controle de Branco:** Desmarca a caixa "Automático" e define um valor manual (4800k).
7.  **Luz de Fundo:** Define compensação máxima.

## Uso
Este script é chamado por um atalho global (ex: `F1` no script *OnlyLetter*) quando a janela de propriedades da câmera está ativa.

**Abertura da Janela de Propriedades da Câmera**

Ela pode ser aberta manualmente pelo OBS ou via script .bat que executa o comando abaixo:

```shell
start "" ffmpeg -f dshow -show_video_device_dialog true -i video="HD Webcam"
```

Este comando depende de:
- Ter o [FFmpeg](https://ffmpeg.org/download.html) instalado e disponível no PATH do sistema.
- Substituir `"HD Webcam"` pelo nome exato do dispositivo da sua webcam.
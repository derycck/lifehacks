# OnlyLetter AutoHotkey v1.1

Problema: Uso do teclado com movimentação constante das mãos para teclas não-alfabéticas (setas, home, end, page up/down, etc) e símbolos ([], {}, ~, ^, ´, `, etc) é desconfortável, lento, pouco ergonômico e pode causar lesões por esforço repetitivo.

Solução: Remapear teclas para que todas as funções possam ser acessadas sem tirar as mãos da posição padrão de digitação. Idealmente se usa todo o teclado sem mover os pulsos do lugar, só movendo os dedos.

## Mapeamentos de Teclas

### RAlt (Alt Direito)

A tecla `RAlt` funciona como uma tecla modificadora principal ("camada de função") para a maioria dos atalhos. **As setas de navegação** só funcionam enquanto `RAlt` estiver pressionado.

| Atalho                  | Ação                                                                       |
| :---------------------- | :------------------------------------------------------------------------- |
| `RAlt + Q`              | Envia `/`.                                                                 |
| `RAlt + W`              | Envia `?`.                                                                 |
| `RAlt + E`              | Envia `[` (abre colchete).                                                 |
| `RAlt + R`              | Envia `]` (fecha colchete).                                                |
| `RAlt + A`              | Envia `~` (til).                                                           |
| `RAlt + S`              | Envia `^` (circunflexo).                                                   |
| `RAlt + D`              | Envia `{` (abre chaves).                                                   |
| `RAlt + F`              | Envia `}` (fecha chaves).                                                  |
| `RAlt + Z`              | Envia `\` (barra invertida).                                               |
| `RAlt + X`              | Envia `\|` (pipe).                                                         |
| `RAlt + C`              | Envia `´` (agudos).                                                        |
| `RAlt + V`              | Envia ``` ` ``` (grave).                                                   |
| `RAlt + 9`              | Envia `Enter`.                                                             |
| `RAlt + Espaço`         | Envia `Backspace`.                                                         |
| `RAlt + O`              | Envia `Home`.                                                              |
| `RAlt + P`              | Envia `End`.                                                               |
| `RAlt + N`              | Envia `Page Up`.                                                           |
| `RAlt + M`              | Envia `Page Down`.                                                         |
| `RAlt + '` (tecla ç)    | Envia `Insert`.                                                            |
| `RAlt + ~` (tecla &)    | Envia `&`.                                                                 |
| `RAlt + U`              | Redimensiona a janela ativa para um formato vertical ("super vertical").   |
| `RAlt + -`              | Diminuir Volume.                                                           |
| `RAlt + =`              | Aumentar Volume.                                                           |
| `RAlt + 4`              | Define dispositivo de áudio para o fone de ouvido (via nircmd).            |
| `RAlt + 5`              | Define dispositivo de áudio para o alto-falantes do notebook (via nircmd). |
| `RAlt + 1`              | Digita mensagem de texto pré-definida. Depende de script externo.          |
| `RAlt + 2`              | Digita mensagem de texto pré-definida. Depende de script externo.          |
| **Navegação de setas ** |                                                                            |
| `RAlt + I`              | Seta para Cima (`Up`).                                                     |
| `RAlt + K`              | Seta para Baixo (`Down`).                                                  |
| `RAlt + J`              | Seta para Esquerda (`Left`).                                               |
| `RAlt + L`              | Seta para Direita (`Right`).                                               |

---

### RAlt + SHIFT

| Atalho             | Ação                                       |
| :----------------- | :----------------------------------------- |
| `RAlt + Shift + W` | Envia `:` (dois pontos).                   |
| `RAlt + Shift + Q` | Envia `;` (ponto e vírgula).               |
| `RAlt + Shift + U` | Executa o script externo `ShareReady.ahk`. |
| `RAlt + Shift + e` | Envia `$` (cifrão).                        |
| `RAlt + Shift + r` | Envia `%` (porcentagem).                   |
| `RAlt + Shift + d` | Envia `&` (e comercial).                   |
| `RAlt + Shift + f` | Envia `*` (asterisco).                     |


---

### Tecla Windows (LWin)

| Atalho          | Ação                                      |
| :-------------- | :---------------------------------------- |
| `LWin + F2`     | Diminuir Volume.                          |
| `LWin + F3`     | Aumentar Volume.                          |
| `Win + F`       | Abre o programa de pesquisa "Everything". |
| `LWin + Espaço` | Ativa ou abre o terminal Wezterm.         |

---

### Tecla Capslock

| Atalho              | Ação   |
| :------------------ | :----- |
| `Capslock + Espaço` | Delete |

### Outros Mapeamentos Simples

| Tecla Original | Ação       |
| :------------- | :--------- |
| `~` (tecla *)  | Envia `*`. |

### Baseado em janela ativa

Alguns atalhos funcionam apenas quando uma janela específica está ativa.

**Janela do Video Proc Amp Properties**

| Atalho | Ação                                                                    |
| :----- | :---------------------------------------------------------------------- |
| `F1`   | Executa o script externo `camset.ahk`. Ajusta a configuração da webcam. |

### Desativação de Capslock

O script desativa propositalmente a tecla `Capslock` (Maiúsculas) para possibilitar seu uso em combinações de teclas sem alterar o estado de maiúsculas/minúsculas do sistema operacional.

Tanto o pressionamento simples de `Capslock` quanto a combinação `Shift + Capslock` são anulados e não têm efeito algum.

## Contexto

**Controle de volume**\
Foi definido atalhos para serem usados tanto com a mão esquerda quanto com a mão direita, para facilitar o ajuste de volume quando uma das mãos estiver ocupada.

**Super vertical**\
Só aplicável quando o segundo monitor estiver posicionado exatamente acima do monitor principal. Ele redimensiona a janela ativa para começar no topo do monitor superior (secundário) e terminar na parte inferior do monitor principal (primário), aproveitando ao máximo o espaço vertical disponível.

Útil para leitura documentos longos, códigos, etc.

**ShareReady**\
Executa um script que prepara o sistema para compartilhamento de tela em videochamadas. Ele move todas as janelas ativas no monitor secundário para o monitor principal. Assim o monitor secundário fica "limpo" e pronto para ter sua imagem compartilhada.

**Controle de dispositivo de saída de áudio**\
Atalhos para alternar rapidamente entre dois dispositivos de áudio: alto-falantes do notebook e fones de ouvido. Requer o utilitário externo `nircmd.exe` [(1)](https://www.nirsoft.net/utils/nircmd.html), que deve estar na mesma pasta do script ou em uma pasta incluída na variável de ambiente `PATH`.

Caso um dispositivo desejado tenha nome duplicado com outro dispositivo, é necessário os diferenciar. Para isso deve-se ir no Painel de Controle de Som do Windows e renomear o dispositivo de reprodução desejado para algo diferente.

A troca de áudio via `nircmd` depende que os dispositivos no Painel de Controle de Som do Windows tenham **exatamente** os nomes: `"Realtek HD Audio 2nd output"` e `"Alto-falantes-notebook"`. Caso contrário, os comandos falharão silenciosamente.

No computador onde ele foi originalmente usado, o dispositivo de auto-falantes do notebook tinha o nome padrão "Alto-falantes", bem como outros drives de áudio tinham o mesmo nome, o que causava conflito. Por isso foi renomeado para "Alto-falantes-notebook" para evitar problemas.

**Correção de erros de digitação**\
Deletar caracteres à esquerda: `RAlt + Espaço` (backspace) \
Deletar caracteres à direita: `Capslock + Espaço` (delete)


## Requisitos e Configuração

### Layout de Teclado
Este script foi projetado especificamente para o layout **ABNT2** (Brasileiro). Ele utiliza "Scan Codes" de teclas físicas específicas deste layout (como a tecla `ç` e a tecla `~` ao lado do Enter).

Em teclados ANSI (US International), alguns atalhos físicos podem não corresponder ou não funcionar.

### Arquivo config.ini (Obrigatório)

Para que os atalhos de scripts externos (`ShareReady`, `Camset`, Mensagens) e a pesquisa (`Everything`) funcionem, você **deve criar** um arquivo `config.ini` na mesma pasta do script `ahk_onlyletter.ahk`.

Exemplo de conteúdo para o `config.ini`:

```ini
[AppPaths]
; Caminho para o atalho ou executável do Everything
Everything=C:\Program Files\Everything\Everything.exe

; Caminhos para os scripts auxiliares (ajuste conforme a localização no seu repo/disco)
ShareReady=D:\ahk\scripts\ShareReady\ShareReady.ahk
Camset=D:\ahk\scripts\Camset\camset.ahk
MsgTudoBem=D:\ahk\scripts\OnlyLetter\MsgTudoBem.ahk
MsgAfk=D:\ahk\scripts\OnlyLetter\MsgAfk.ahk
```

Sem este arquivo, o script exibirá erros ou não executará as ações.

## Ressalvas e Limitações Técnicas

1. **Monitor "Super Vertical" (Hardcoded):**
   A função `RAlt + U` (sem shift) utiliza coordenadas fixas (`35, -1400`) no código. Ela foi feita para um setup onde o monitor secundário está *acima* do primário.
   **Ação necessária:** Você provavelmente precisará editar a função `ResizeWin` dentro do arquivo `.ahk` e ajustar os valores de `WinMove` para a resolução e posição do seu monitor.

2. **Atalho F1 em Diálogos:**
   O atalho `F1` para abrir a config da webcam está vinculado à classe de janela `#32770`. Esta é a classe padrão para a maioria das caixas de diálogo do Windows (ex: "Salvar Como", "Propriedades"). Ao pressionar F1 nessas janelas, o script da webcam será acionado em vez da Ajuda do Windows.

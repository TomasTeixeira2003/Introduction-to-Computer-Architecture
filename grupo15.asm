; **************************************************************************************************
; * Grupo número: 15           
; *
; * Henrique Carrão, 100313
; * Mariana Horta, 102512
; * Tomás Teixeira, 103796
; **************************************************************************************************

; **************************************************************************************************
; * COMANDOS: 
;       Mover pessoa: 1 (esquerda) e 2 (direita)
;       Disparar bala: 0
;       Start: C
;       Pause/Resume: D
;       End: E

; **************************************************************************************************
; * Constantes
; **************************************************************************************************
; GERAIS
TRUE    EQU 1   ; valor de verdade - verdadeiro
FALSE   EQU 0   ; valor de verdade - falso

; MÁSCARAS
MASC_3_0    EQU 0FH     ; para isolar os 4 bits de menor peso, ao ler as colunas do teclado

; MEDIA CENTER - COMANDOS
DEFINE_LINHA    EQU 600AH   ; endereço do comando para definir a linha
DEFINE_COLUNA   EQU 600CH   ; endereço do comando para definir a coluna
DEFINE_PIXEL    EQU 6012H   ; endereço do comando para escrever um pixel
APAGA_AVISO     EQU 6040H   ; endereço do comando para apagar o aviso de nenhum cenário selecionado
APAGA_TODOS     EQU 6002H   ; endereço do comando para apagar todos os pixels de todos os ecrãs
ESCOLHE_ECRA    EQU 6004H   ; endereço do comando para selecionar um ecrã
SEL_CEN_FUNDO   EQU 6042H   ; endereço do comando para selecionar um cenário de fundo
APAGA_FRONTAL   EQU 6044H   ; endereço do comando para apagar o cenário frontal
SEL_CEN_FRONTAL EQU 6046H   ; endereço do comando para selecionar um cenário frontal
REPRODUZIR      EQU 605AH   ; endereço do comando para reproduzir um som/vídeo

; TECLADO - DEFINIÇÃO DAS TECLAS

TECLA_BALA      EQU 0       ; tecla para disparar a bala
MOVE_ESQ        EQU 1       ; tecla para mover a pessoa para a esquerda
MOVE_DIR        EQU 2       ; tecla para mover a pessoa para a direita
TECLA_START     EQU 0CH     ; tecla para começar o jogo
TECLA_PAUSE     EQU 0DH     ; tecla para suspender/continuar o jogo
TECLA_END       EQU 0EH     ; tecla para terminar o jogo

; CORES - CÓDIGO ARGB
PRETO       EQU	0F000H
BRANCO      EQU 0FFFFH
AZUL_C      EQU 0F2DCH
AZUL_E      EQU 0F12CH
VERMELHO    EQU 0FC11H
AMARELO     EQU 0FED0H
LARANJA     EQU 0FD70H
BEJE        EQU 0FFC7H
CASTANHO    EQU 0FB40H
CINZA       EQU 0F777H
TRANSP      EQU 0000H   ; "cor" usada para apagar o pixel

; ECRÃ - DADOS
MIN_COLUNA  EQU 0   ; número da coluna mais à esquerda que um objeto pode ocupar
MAX_COLUNA	EQU 63  ; número da coluna mais à direita que um objeto pode ocupar
MIN_LINHA   EQU 0   ; número da linha mais para cima que um objeto pode ocupar
MAX_LINHA   EQU 31  ; número da linha mais para baixo que um objeto pode ocupar
N_ESTRADAS  EQU 8   ; número de estradas do background

; CENÁRIOS - OPÇÕES
CEN_INICIAL         EQU 0   ; número do cenário de fundo inicial
CEN_ESTRADA         EQU 1   ; número do cenário de fundo da estrada
CEN_ACABOU_CARRO    EQU 2   ; número do cenário de fundo por perda por embate com um carro
CEN_ACABOU_ENERGIA  EQU 3   ; número do cenário de fundo por perda por falta de energia
CEN_ACABOU_TECLA    EQU 4   ; número do cenário de fundo de game over por clicar na TECLA_END
CEN_PAUSA           EQU 5   ; número do cenário de fundo inicial

; SONS - OPÇÕES
SOM_DISPARO             EQU 0
SOM_GARRAFA_BEBIDA      EQU 1
SOM_CARRO_DESTRUIDO     EQU 2
SOM_ACABOU_CARRO        EQU 3
SOM_ACABOU_ENERGIA      EQU 4
SOM_GARRAFA_DESTRUIDA   EQU 5

; DISPLAY - DADOS
DISPLAYS            EQU 0A000H  ; endereço dos displays de 7 segmentos (periférico POUT-1)
MIN_VAL_DISPLAYS    EQU 0       ; valor mínimo dos displays
MAX_VAL_DISPLAYS    EQU 100     ; valor máximo dos displays

; CONTROLO - DADOS
; GERAIS
EM_JOGO         EQU 0   ; flag que avisa que se está a jogar
ACABOU          EQU 1   ; flag que avisa que se perdeu
PAUSA           EQU 2   ; flag que avisa que se está em pausa
; ACABAR
ACABOU_DEFAULT  EQU 0   ; flag que avisa que se terminou o jogo pela TECLA_END
ACABOU_ENERGIA  EQU 1   ; flag que avisa que se perdeu o jogo por falta de energia
ACABOU_CARRO    EQU 2   ; flag que avisa que se perdeu o jogo por embate com um carro

; TECLADO - DADOS
TEC_LIN     EQU 0C000H  ; endereço das linhas do teclado (periférico POUT-2)
TEC_COL     EQU 0E000H  ; endereço das colunas do teclado (periférico PIN)
LINHA_F     EQU 1000b   ; última linha do teclado (primeira a testar)

; PESSOA - DADOS
LINHA_PESSOA_I  EQU 27      ; linha inicial da pessoa
COLUNA_PESSOA_I EQU 30      ; coluna inicial da pessoa
LARGURA_PESSOA  EQU 5       ; largura da pessoa
ALTURA_PESSOA   EQU 5       ; altura da pessoa
ECRA_PESSOA     EQU 4       ; ecrã em que é desenhada a pessoa
DESLOCA_ESQ     EQU -1      ; o que incrementar à posição da pessoa para mover para a esquerda
DESLOCA_DIR     EQU +1      ; o que incrementar à posição da pessoa para mover para a direita
NAO_DESLOCA     EQU 0       ; o que incrementar à posição da pessoa para não a mover
ATRASO_PESSOA   EQU 500     ; valor utilizado para reduzir a velocidade da pessoa

; INFINITO - DADOS
LARGURA_INF_0   EQU 3   ; largura do infinito_0
ALTURA_INF_0    EQU 1   ; altura do infinito_0
LARGURA_INF_1   EQU 3   ; largura do infinito_1
ALTURA_INF_1    EQU 2   ; altura do infinito_1

; CARROS - DADOS
LARGURA_CARRO_0     EQU 4   ; largura do carro_0
ALTURA_CARRO_0      EQU 3   ; altura do carro_0
LARGURA_CARRO_1     EQU 4   ; largura do carro_1
ALTURA_CARRO_1      EQU 4   ; altura do carro_1
LARGURA_CARRO_2     EQU 5 	; largura do carro_2
ALTURA_CARRO_2      EQU 5   ; altura do carro_2

; GARRAFA - DADOS
LARGURA_GARRAFA_0   EQU 3   ; largura da garrafa_0
ALTURA_GARRAFA_0    EQU 3   ; altura da garrafa_0
LARGURA_GARRAFA_1   EQU 4   ; largura da garrafa_1
ALTURA_GARRAFA_1    EQU 4   ; altura da garrafa_1
LARGURA_GARRAFA_2   EQU 4   ; largura da garrafa_2
ALTURA_GARRAFA_2    EQU 5   ; altura da garrafa_2

; BALA - DADOS
LINHA_BALA_DEFAULT  EQU 0   ; linha default da bala
COLUNA_BALA_DEFAULT EQU 0   ; coluna default da bala
LARGURA_BALA        EQU 1   ; largura da bala
ALTURA_BALA         EQU 2   ; altura da bala
ALCANCE_BALA        EQU 14  ; alcance máximo da bala

; OBSTÁCULOS - DADOS
COLUNA_OBSTACULO_0  EQU 2   ; coluna inicial do obstáculo 0
COLUNA_OBSTACULO_1  EQU 18  ; coluna inicial do obstáculo 1
COLUNA_OBSTACULO_2  EQU 34  ; coluna inicial do obstáculo 2
COLUNA_OBSTACULO_3  EQU 50  ; coluna inicial do obstáculo 3
LINHA_OBSTACULOS_I  EQU 0   ; linha inicial dos obstáculos
N_TIPOS             EQU 2   ; número de tipos de obstáculos
N_TIPOS_PROB_TOTAL  EQU 4   ; número total de tipos contando com probabilidades (1 garrafa +
                            ;3 carros == 4 obstáculos)
TIPO_GARRAFA        EQU 0   ; tipo de obstáculo a criar (garrafa)
TIPO_CARRO          EQU 1   ; tipo de obstáculo a criar (carro)
N_OBSTACULOS        EQU 4   ; número de obstáculos no ecrã
ECRA_OBSTACULOS     EQU 0   ; ecrã em que se começa a desenhar os obstáculos (ecrã 0 até ecrã 3)
MOVS_ALT_REPRE      EQU 2   ; número de movimentos necessários para o obstáculo evoluir de aspeto
ULT_REPRE           EQU 4   ; representação final do obstáculo
ALTURA_OBSTACULOS   EQU 5   ; altura dos obstáculos na sua forma final
COMECA_EXPLOSAO     EQU 2   ; flag que inicializa a explosão do obstáculo
ACABA_EXPLOSAO      EQU 1   ; flag que termina a explosão do obstáculo
NAO_EXPLOSAO        EQU 0   ; flag que avisa que não há explosão (pois não houve colisão)

; EXPOSÃO - DADOS
LARGURA_EXPLOSAO    EQU 5   ; largura da explosão
ALTURA_EXPLOSAO     EQU 5   ; altura da explosão

; ENERGIA - DADOS
ENERGIA_DEC_TEMPO   EQU -5   ; valor a subtrair à energia por cada interrupção 2
ENERGIA_DEC_BALA    EQU -5   ; valor a subtrair à energia por cada bala disparada
ENERGIA_INC_GARRAFA EQU 10  ; valor a adicionar à energia por cada colisão da pessoa com uma garrafa
ENERGIA_INC_CARRO   EQU 5   ; valor a adicionar à energia quando se destrói um carro

; **************************************************************************************************
; * Dados   
; **************************************************************************************************
    PLACE       1000H

; PROCESSOS - PILHAS
	STACK 100H		    ; espaço reservado para a pilha do processo "programa principal"
SP_INICIAL_PROG_PRINC:  ; este é o endereço com que o SP deste processo deve ser inicializado

	STACK 100H			; espaço reservado para a pilha do processo "controlo"
SP_INICIAL_CONTROLO:    ; este é o endereço com que o SP deste processo deve ser inicializado
							
	STACK 100H			; espaço reservado para a pilha do processo "teclado"
SP_INICIAL_TECLADO:     ; este é o endereço com que o SP deste processo deve ser inicializado

	STACK 100H		    ; espaço reservado para a pilha do processo "energia"
SP_INICIAL_ENERGIA:     ; este é o endereço com que o SP deste processo deve ser inicializado

	STACK 100H		    ; espaço reservado para a pilha do processo "pessoa"
SP_INICIAL_PESSOA:      ; este é o endereço com que o SP deste processo deve ser inicializado

	STACK 100H			; espaço reservado para a pilha do processo "bala"
SP_INICIAL_BALA:        ; este é o endereço com que o SP deste processo deve ser inicializado

; SP inicial de cada processo "obstaculo"							
	STACK 100H			    ; espaço reservado para a pilha do processo "obstaculo", instância 0
SP_INICIAL_OBSTACULO_0:     ; este é o endereço com que o SP deste processo deve ser inicializado
						
	STACK 100H			    ; espaço reservado para a pilha do processo "obstaculo", instância 1
SP_INICIAL_OBSTACULO_1:     ; este é o endereço com que SP deste processo deve ser inicializado
							
	STACK 100H			    ; espaço reservado para a pilha do processo "obstaculo", instância 2
SP_INICIAL_OBSTACULO_2:     ; este é o endereço com que o SP deste processo deve ser inicializado

	STACK 100H			    ; espaço reservado para a pilha do processo "obstaculo", instância 3
SP_INICIAL_OBSTACULO_3:     ; este é o endereço com que o SP deste processo deve ser inicializado

; tabela das rotinas de interrupção
TAB_BTE:
    WORD    int_obstaculos  ; rotina de atendimento da interrupção 0
    WORD    int_bala        ; rotina de atendimento da interrupção 1
    WORD    int_energia     ; rotina de atendimento da interrupção 2

; LOCKs para cada rotina de interrupção comunicar ao processo respetivo que a interrupção ocorreu
INT_MOV_OBSTACULO:  LOCK    0 ; permite a movimentação de cada obstáculo (garrafas e carros)
INT_MOV_BALA:       LOCK    0 ; permite a movimentação da bala
INT_DEC_ENERGIA:    LOCK    0 ; permite o decremento periódico da energia

; tabela com as colunas em que os obstáculos são inicializados
ESTRADAS_INICIAIS:				
	WORD COLUNA_OBSTACULO_0
	WORD COLUNA_OBSTACULO_1
	WORD COLUNA_OBSTACULO_2
	WORD COLUNA_OBSTACULO_3

; tabela com os SP's iniciais de cada processo "obstaculo"
SP_OBSTACULOS:
    WORD    SP_INICIAL_OBSTACULO_0
    WORD    SP_INICIAL_OBSTACULO_1
    WORD    SP_INICIAL_OBSTACULO_2
    WORD    SP_INICIAL_OBSTACULO_3

; tabela coma linha em que cada obstáculo está (inicializada com MIN_LINHA)
LINHA_OBSTACULOS:				
	WORD LINHA_OBSTACULOS_I
	WORD LINHA_OBSTACULOS_I
	WORD LINHA_OBSTACULOS_I
	WORD LINHA_OBSTACULOS_I

; tabela com a coluna em que cada obstáculo está (inicializada com os valores de ESTRADAS_INICIAIS)
COLUNA_OBSTACULOS:				
	WORD COLUNA_OBSTACULO_0
	WORD COLUNA_OBSTACULO_1
	WORD COLUNA_OBSTACULO_2
	WORD COLUNA_OBSTACULO_3
    
; tabela com o tipo de cada obstáculo (inicializada com o tipo inicial)
TIPO_OBSTACULOS:
    WORD TIPO_CARRO
    WORD TIPO_CARRO
    WORD TIPO_GARRAFA
    WORD TIPO_CARRO

; tabela com o estado de explosão de cada obstáculo
EXPLOSAO_OBSTACULOS:
    WORD NAO_EXPLOSAO
    WORD NAO_EXPLOSAO
    WORD NAO_EXPLOSAO
    WORD NAO_EXPLOSAO

; PESSOA - DADOS
COLUNA_PESSOA:  WORD    COLUNA_PESSOA_I ; coluna da pessoa

; BALA - DADOS
LINHA_BALA:     WORD    LINHA_BALA_DEFAULT      ; linha da bala
COLUNA_BALA:    WORD    COLUNA_BALA_DEFAULT     ; coluna da bala
BALA_EXISTE:    WORD    FALSE                   ; flag que que avisa se a bala existe ou não

; LOCKs para o teclado comunicar com todos os processos
TECLA_PRESS:     LOCK 0  ; permite a comunicação da tecla pressionada a todos os processos
TECLA_CONTINUO:  LOCK 0  ; permite a comunicação da tecla pressionada continuamente com o processo
                         ;pessoa

; DISPLAYS - VALOR
DISPLAYS_VAL:       WORD   MAX_VAL_DISPLAYS  ; imagem do valor dos displays (inicializa-se a 100)

; OBSTÁCULOS - POSSÍVEIS COLUNAS
ESTRADAS:       WORD 2, 10, 18, 26, 34, 42, 50, 58  ; colunas correspondentes às estradas

; CONTROLO
ESTADO_JOGO:    WORD    ACABOU          ; flag que indica o estado do jogo
COMO_ACABOU:    WORD    ACABOU_DEFAULT  ; flag que avisa como acabou o jogo

JA_PASSOU_PAUSA: WORD 1     ; flag para corrigir o bug de dupla pausa

; OBSTÁCULOS - REPRESENTAÇÕES
OBSTACULOS_REPRES:  ; tabela com as diferentes representações dos obstáculos dependendo do tipo e da 
                    ;sua dimensão
    WORD DEF_INF_0,     DEF_INF_0
    WORD DEF_INF_1,     DEF_INF_1
    WORD DEF_GARRAFA_0, DEF_CARRO_0
    WORD DEF_GARRAFA_1, DEF_CARRO_1
    WORD DEF_GARRAFA_2, DEF_CARRO_2

; OBJETOS - DEFINIÇÕES
DEF_PESSOA:				                        ; tabela que define a pessoa (cor, largura, pixels)
	WORD	LARGURA_PESSOA, ALTURA_PESSOA       ; dimensões da pessoa
    ; Pixels da pessoa
    WORD	TRANSP, CASTANHO,   CASTANHO,   CASTANHO,   TRANSP
    WORD	TRANSP, CASTANHO,   CASTANHO,   BEJE,       TRANSP   
    WORD	BEJE,   AZUL_C,     AZUL_C,     AZUL_C,     BEJE
    WORD	BEJE,   AZUL_C,     AZUL_C,     AZUL_C,     BEJE
    WORD	TRANSP, PRETO,      TRANSP,     PRETO,      TRANSP   

DEF_INF_0:                                  ; tabela que define o infinito_0 (cor, largura, pixels)
    WORD    LARGURA_INF_0, ALTURA_INF_0     ; dimensões do infinito_0
    ; Pixels do infinito
    WORD    TRANSP, TRANSP, CINZA 

DEF_INF_1:                                  ; tabela que define o infinito_1 (cor, largura, pixels)
    WORD    LARGURA_INF_1, ALTURA_INF_1     ; dimensões do infinito_1
    ; Pixels do infinito
    WORD    TRANSP, CINZA,  CINZA
    WORD    TRANSP, CINZA,  CINZA


DEF_CARRO_0:                                    ; tabela que define o carro (cor, largura, pixels)
    WORD    LARGURA_CARRO_0, ALTURA_CARRO_0     ; dimensões do carro
    ; Pixels do carro
    WORD    TRANSP,     TRANSP,     VERMELHO,   TRANSP      
    WORD    TRANSP,     PRETO,      VERMELHO,   PRETO          
    WORD    TRANSP,     TRANSP,     AZUL_C,     TRANSP           

DEF_CARRO_1:                                    ; tabela que define o carro (cor, largura, pixels)
    WORD    LARGURA_CARRO_1, ALTURA_CARRO_1     ; dimensões do carro
    ; Pixels do carro
    WORD    PRETO,      VERMELHO,   VERMELHO,   PRETO      
    WORD    TRANSP,     VERMELHO,   VERMELHO,   TRANSP          
    WORD    PRETO,      AZUL_C,     AZUL_C,     PRETO          
    WORD    TRANSP,     VERMELHO,   VERMELHO,   TRANSP       
    
DEF_CARRO_2:                                    ; tabela que define o carro (cor, largura, pixels)
    WORD    LARGURA_CARRO_2, ALTURA_CARRO_2     ; dimensões do carro
    ; Pixels do carro
    WORD    PRETO,  VERMELHO,   VERMELHO,   VERMELHO,   PRETO   
    WORD    TRANSP, VERMELHO,   VERMELHO,   VERMELHO,   TRANSP       
    WORD    TRANSP, VERMELHO,   VERMELHO,   VERMELHO,   TRANSP       
    WORD    PRETO,  AZUL_C,     AZUL_C,     AZUL_C,     PRETO   
    WORD    TRANSP, VERMELHO,   VERMELHO,   VERMELHO,   TRANSP       

DEF_GARRAFA_0:                                  ; tabela que define a garrafa (cor, largura, pixels)
    WORD LARGURA_GARRAFA_0, ALTURA_GARRAFA_0    ; dimensões da garrafa
    ; Pixels da garrafa
    WORD TRANSP,    TRANSP,    AZUL_C    
    WORD TRANSP,    TRANSP,    BRANCO    
    WORD TRANSP,    TRANSP,    AZUL_C     

DEF_GARRAFA_1:                                  ; tabela que define a garrafa (cor, largura, pixels)
    WORD LARGURA_GARRAFA_1, ALTURA_GARRAFA_1    ; dimensões da garrafa
    ; Pixels da garrafa
    WORD TRANSP,    TRANSP,    AZUL_E,     TRANSP   
    WORD TRANSP,    AZUL_C,    AZUL_C,     AZUL_C   
    WORD TRANSP,    BRANCO,    BRANCO,     BRANCO    
    WORD TRANSP,    AZUL_C,    AZUL_C,     AZUL_C   

DEF_GARRAFA_2:                                  ; tabela que define a garrafa (cor, largura, pixels)
    WORD LARGURA_GARRAFA_2, ALTURA_GARRAFA_2    ; dimensões da garrafa
    ; Pixels da garrafa
    WORD TRANSP,    TRANSP,    AZUL_E,     TRANSP
    WORD TRANSP,    AZUL_C,    AZUL_C,     AZUL_C
    WORD TRANSP,    BRANCO,    BRANCO,     BRANCO
    WORD TRANSP,    AZUL_C,    AZUL_C,     AZUL_C
    WORD TRANSP,    AZUL_C,    AZUL_C,     AZUL_C

DEF_BALA:                               ; tabela que define a bala (cor, largura, pixels)                     
    WORD LARGURA_BALA, ALTURA_BALA      ; dimensões da bala
    ; Pixels da bala
    WORD LARANJA
    WORD AMARELO

DEF_EXPLOSAO_CARRO:                             ; tabela que define a explosão do carro (cor, 
                                                ;largura, pixels)
    WORD LARGURA_EXPLOSAO, ALTURA_EXPLOSAO      ; dimensões da explosão do carro
    ; Pixels da explosão do carro
    WORD TRANSP,    VERMELHO,   LARANJA,    VERMELHO,   TRANSP
    WORD VERMELHO,  LARANJA,    LARANJA,    LARANJA,    VERMELHO
    WORD LARANJA,   LARANJA,    AMARELO,    LARANJA,    LARANJA
    WORD VERMELHO,  LARANJA,    LARANJA,    LARANJA,    VERMELHO
    WORD TRANSP,    VERMELHO,   LARANJA,    VERMELHO,   TRANSP

DEF_EXPLOSAO_GARRAFA:                           ; tabela que define a explosão da garrafa (cor, 
                                                ;largura, pixels)
    WORD LARGURA_EXPLOSAO, ALTURA_EXPLOSAO      ; dimensões da explosão da garrafa
    ; Pixels da explosão da garrafa
    WORD TRANSP,    BRANCO,     AZUL_C,     BRANCO,     TRANSP
    WORD BRANCO,    AZUL_C,     AZUL_C,     AZUL_C,     BRANCO
    WORD AZUL_C,    AZUL_C,     AZUL_E,     AZUL_C,     AZUL_C
    WORD BRANCO,    AZUL_C,     AZUL_C,     AZUL_C,     BRANCO
    WORD TRANSP,    BRANCO,     AZUL_C,     BRANCO,     TRANSP



; **************************************************************************************************
; * Código
; **************************************************************************************************
    PLACE      0
inicio:		
; inicializações
    MOV SP, SP_INICIAL_PROG_PRINC   ; inicializa o stack pointer do programa principal

    MOV BTE, TAB_BTE            ; inicializa BTE (registo de Base da Tabela de Exceções)

    MOV [APAGA_AVISO], R1       ; apaga o aviso de nenhum cenário selecionado (o valor de R1 não é
                                ;relevante)
    MOV [APAGA_TODOS], R1	    ; apaga todos os pixels já desenhados (o valor de R1 não é relevante)	
    MOV	R1, CEN_INICIAL         ; cenário de fundo número 0
    MOV [SEL_CEN_FUNDO], R1     ; seleciona o cenário de fundo
    
    EI0		; permite interrupções 0
	EI1		; permite interrupções 1
	EI2		; permite interrupções 2
	EI		; permite interrupções (geral)


main:
    CALL teclado    ; cria o processo "teclado"
    CALL controlo   ; cria o processo "controlo"

; **************************************************************************************************
; * Processos
; **************************************************************************************************


; **************************************************************************************************
; CONTROLO - Processo responsável por decidir o estado do jogo (EM_JOGO, PAUSA ou ACABOU)
;
; **************************************************************************************************
PROCESS SP_INICIAL_CONTROLO

controlo:
    
    MOV R1, [TECLA_PRESS]   ; lê o LOCK e bloqueia até ser pressionada uma tecla
    MOV R2, [ESTADO_JOGO]   ; lê o estado do jogo
    MOV R3, ACABOU
    CMP R2, R3              ; verifica se o jogo está terminado
    JNZ continue            ; se não está continua
    MOV R2, TECLA_START     
    CMP R1, R2              ; verifica se está a ser pressionada a TECLA_START
    JZ start_jogo           ; se está, salta para start_jogo
    ;JMP controlo

continue:
    MOV R3, TECLA_PAUSE     
    CMP R1, R3              ; verifica se está a ser pressionada a TECLA_PAUSE
    JZ pausa_jogo           ; se está, salta para pausa_jogo

end:
    MOV R2, [ESTADO_JOGO]   ; lê o estado do jogo
    CMP R2, ACABOU          ; verifica se o jogo está terminado
    JZ controlo             ; se está, volta ao início do processo
    MOV R4, TECLA_END       
    CMP R1, R4              ; verifica se está a ser pressionada a TECLA_END
    JZ end_jogo             ; se está, salta para end_jogo
    JMP controlo            ; volta ao início do processo
  
start_jogo:
    MOV R1, EM_JOGO
    MOV [ESTADO_JOGO], R1       ; muda o estado do jogo para EM_JOGO
    MOV [APAGA_TODOS], R1	    ; apaga todos os pixels já desenhados (o valor de R1 não é relevante)	
    MOV	R1, CEN_ESTRADA         ; cenário de fundo número 1
    MOV [SEL_CEN_FUNDO], R1     ; seleciona o cenário de fundo
    
    CALL energia    ; cria o processo "energia"
    CALL pessoa     ; cria o processo "pessoa"
    CALL bala       ; cria o processo "bala"
    
    MOV R11, N_OBSTACULOS   ; número de obstáculos a usar (até 4)
call_obstaculos:
    SUB R11, 1              ; próximo obstáculo
    CALL obstaculo          ; cria o processo "obstaculo" correspondente ao número guardado em R11
    CMP R11, 0              ; já criou as instâncias todas?
    JNZ call_obstaculos     ; se não, continua
    JMP controlo            ; volta ao início do processo

pausa_jogo:
    ; para contornar bug do simulador (VER RELATÓRIO)
    ; faz com que a segunda vez que o PEPE passe aqui não desfaça a pausa que fez, ou não ponha em
    ; pausa novamente o que tirou de pausa
    ; (pois ao chamar a TECLA_PAUSE ocorre o erro de ler duas vezes o TECLA_PRESS)
    MOV R0, [JA_PASSOU_PAUSA]   ; lê JA_PASSOU_PAUSA
    CMP R0, 1                   
    JNZ repoe_flag_pausa
    MOV R0, 0
    MOV [JA_PASSOU_PAUSA], R0
    ; fim da resolução bug

    MOV R0, [ESTADO_JOGO]       ; lê o estado do jogo
    MOV R1, PAUSA               
    CMP R0, R1                  ; verifica se o jogo está no modo PAUSA 
    JZ tira_pausa               ; se estiver, salta para tira_pausa
    MOV R0, PAUSA               ; guarda PAUSA em R0 para atualizar o estado do jogo em 
                                ;atualiza_estado_pausa
    MOV R1, CEN_PAUSA
    MOV [SEL_CEN_FRONTAL], R1   ; seleciona o cenário frontal CEN_PAUSA
    JMP atualiza_estado_pausa

tira_pausa:
    MOV [APAGA_FRONTAL], R0     ; apaga o cenário frontal
    MOV R0, EM_JOGO             ; guarda EM_JOGO em R0 para atualizar o estado do jogo em 
                                ;atualiza_estado_pausa 

atualiza_estado_pausa:
    MOV [ESTADO_JOGO], R0   ; muda o estado do jogo para PAUSA ou EM_JOGO
    JMP controlo            ; volta ao início do processo

; para contornar bug do simulador
repoe_flag_pausa:
    MOV R0, 1
    MOV [JA_PASSOU_PAUSA], R0
    JMP controlo                ; volta ao início do processo
; fim da resolução do bug

end_jogo:
    MOV R1, ACABOU
    MOV [ESTADO_JOGO], R1       ; muda o estado do jogo para ACABOU
    MOV [APAGA_TODOS], R1	    ; apaga todos os pixels já desenhados (o valor de R1 não é relevante)	
    
    MOV R0, [COMO_ACABOU]       ; lê o valor de COMO_ACABOU para decidir qual o cenário a usar

verifica_acabou_carro:
    MOV R1, ACABOU_CARRO
    CMP R0, R1                      ; verifica se o jogo acabou por embate com um carro
    JNZ verifica_acabou_energia     ; se não, passa à próxima verificação
    MOV R2, CEN_ACABOU_CARRO        ; move para R2 o cenário de fundo a ser usado  
    JMP selecionar_fim

verifica_acabou_energia:
    MOV R1, ACABOU_ENERGIA      
    CMP R0, R1                  ; verifica se o jogo acabou por falta de energia
    JNZ acabou_tecla            ; se não, acabou por o jogador ter carregado na TECLA_END 
    MOV R2, CEN_ACABOU_ENERGIA  ; move para R2 o cenário de fundo a ser usado
    JMP selecionar_fim

acabou_tecla:
    MOV R2, CEN_ACABOU_TECLA    ; move para R2 o cenário de fundo a ser usado  

selecionar_fim:                  
    MOV [SEL_CEN_FUNDO], R2     ; seleciona o cenário de fundo do fim do jogo
    JMP controlo                ; volta ao início do processo



; **************************************************************************************************
; TECLADO - Processo que deteta quando se carrega numa tecla do teclado e escreve o valor da tecla 
;           num LOCK.
;
; **************************************************************************************************
PROCESS SP_INICIAL_TECLADO	; indicação de que a rotina que se segue é um processo, com indicação do 
                            ;valor para inicializar o SP
teclado:					
    MOV R0, LINHA_F     ; começamos a verificação pela última linha
    MOV R2, TEC_LIN     ; guarda o endereço das linhas
    MOV R3, TEC_COL     ; guarda o endereço das colunas
    MOV R4, MASC_3_0    ; máscara para selecionar os 4 bits de menor peso
    
espera_tecla:			; neste ciclo espera-se até uma tecla ser premida
	WAIT				; este ciclo é potencialmente bloqueante, pelo que tem de ter um ponto de 
                        ;fuga (aqui pode comutar para outro processo)

	MOVB [R2], R0		; escrever no periférico de saída (linhas)
	MOVB R1, [R3]		; ler do periférico de entrada (colunas)
	AND  R1, R4			; elimina bits para além dos bits 0-3
	JNZ ha_tecla        ; se R1 diferente de 0, há alguma tecla pressionada
    SHR R0, 1           ; passa à linha acima
    JNZ espera_tecla    ; se R0 diferente de 0, ainda há linhas a testar
	MOV R0, LINHA_F     ; recomeçamos a verificação pela última linha
	JMP espera_tecla

ha_tecla:
    CALL converte_tecla     ; devolve o valor da tecla pressionada 				
	MOV [TECLA_PRESS], R5	; informa quem estiver bloqueado neste LOCK que uma tecla foi carregada
							;(o valor escrito é o valor da tecla pressionada)

ha_tecla_pressionada:	; neste ciclo espera-se até NENHUMA tecla estar premida
	YIELD				; este ciclo é potencialmente bloqueante, pelo que tem de
						;ter um ponto de fuga (aqui pode comutar para outro processo)

	MOV	[TECLA_CONTINUO], R5	; informa quem estiver bloqueado neste LOCK que uma tecla está a ser 
                                ;carregada						
    MOVB [R2], R0			    ; escrever no periférico de saída (linhas)
    MOVB R1, [R3]			    ; ler do periférico de entrada (colunas)
	AND  R1, R4			        ; elimina bits para além dos bits 0-3
	JNZ  ha_tecla_pressionada	; se ainda houver uma tecla premida, espera até não haver

	JMP	espera_tecla		





; **************************************************************************************************
; OBSTACULO - Processo que desenha um obstaculo (garrafa ou carro) e o move horizontalmente, com
;		      temporização marcada por uma interrupção. Este processo está preparado para ter várias 
;             instâncias (vários processos serem criados com o mesmo código), com o argumento (R11)
;		      a indicar o número de cada instância. Esse número é usado para indexar tabelas com 
;             informação para cada uma das instâncias, nomeadamente o valor inicial do SP (que tem 
;             de ser único para cada instaância) e o LOCK que lê à espera que a interrupção 
;             respetiva ocorra
;
; Argumentos:   R11 - número da instância do processo (cada instância fica com uma cópia 
;               independente dos registos, com os valores que os registos tinham na altura da 
;               criação do processo. O valor de R11 deve ser mantido ao longo de toda a vida do 
;               processo
;
; **************************************************************************************************
PROCESS SP_INICIAL_OBSTACULO_0

obstaculo:
    MOV R10, R11			; cópia do nº de instância do processo
	SHL R10, 1			    ; multiplica por 2 porque as tabelas são de WORDS
	MOV R9, SP_OBSTACULOS   ; tabela com os SPs iniciais das várias instâncias deste processo
	MOV	SP, [R9+R10]		; re-inicializa SP deste processo, de acordo com o nº de instância

    MOV R9, ECRA_OBSTACULOS ; primeiro ecrã dos obstáculos
    ADD R9, R11             ; ecrã do obstáculo correspondente de acordo com offset
    MOV [ESCOLHE_ECRA], R9  ; selecionar o ecrã

    MOV R1, LINHA_OBSTACULOS_I  ; linha inicial dos obstáculos
    MOV R9, LINHA_OBSTACULOS    ; tabela das linhas de cada obstáculo
	MOV [R9+R10], R1            ; linha do obstáculo correspondente

    MOV R9, ESTRADAS_INICIAIS   ; tabela das colunas de cada obstáculo
	MOV R2, [R9+R10]            ; coluna do obstáculo correspondente
    MOV R9, COLUNA_OBSTACULOS   ; tabela das colunas de cada obstáculo
    MOV [R9+R10], R2            ; coluna do obstáculo correspondente

    CMP R11, 2                  ; verifica se estamos no 3º obstáculo a ser definido
    JNZ coloca_tipo_carro       ; se não, salta para coloca_tipo_carro
    MOV R8, TIPO_GARRAFA        ; seleciona o tipo do obstáculo a ser criado
    JMP inicializa_tipo         

coloca_tipo_carro:
    MOV R8, TIPO_CARRO          ; seleciona o tipo do obstáculo a ser criado

inicializa_tipo:
    MOV R9, TIPO_OBSTACULOS     ; tabela com os tipos dos obstáculos
    MOV [R9+R10], R8            ; define o tipo do obstáculo na tabela TIPO_OBSTACULOS

    MOV R8, NAO_EXPLOSAO            ; seleciona a opção de que os obstáculos não estão a explodir
    MOV R9, EXPLOSAO_OBSTACULOS     ; tabela que define o estado de explosão dos obstáculos
    MOV [R9+R10], R8                ; define o estado de explosão do obstáculo

escolhe_nova_repre:
    CALL escolhe_repre  ; escolhe qual é a representação visual a usar de acordo com a posição e o
                        ;tipo de obstáculo

ciclo_obstaculo:
    CALL desenha_obj                ; desenha o obstáculo

espera_int_obstaculo:    
    MOV  R3, [INT_MOV_OBSTACULO]    ; espera-se que chegue o momento de mover o obstáculo

    MOV R9, ECRA_OBSTACULOS ; primeiro ecrã dos obstáculos
    ADD R9, R11             ; ecrã do obstáculo correspondente de acordo com offset
    MOV [ESCOLHE_ECRA], R9  ; selecionar o ecrã

    ; verifica o estado atual do jogo
    MOV R9, [ESTADO_JOGO]   ; lê o estado do jogo
    CMP R9, PAUSA           ; verifica se o jogo está em pausa
    JZ espera_int_obstaculo ; com o jogo em pausa, não faz nada e fica à espera de nova interrupção
    CMP R9, ACABOU          ; verifica se o jogo já acabou      
    JZ termina_obstaculo    ; se o jogo terminou, termina o processo do obstáculo

    CALL trata_colisoes     ; trata das colisões dos obstáculos  

    CALL apaga_obj  ; apaga o obstáculo

    MOV R9, EXPLOSAO_OBSTACULOS ; tabela que define o estado de explosão dos obstáculos
    MOV R9, [R9+R10]            ; lê o estado de explosão do obstáculo
    CMP R9, COMECA_EXPLOSAO     ; verifica se o obstáculo está a começar a explodir
    JZ explode_obstaculo        ; se sim, explode o obstáculo

    CMP R9, ACABA_EXPLOSAO      ; verifica se o obstáculo já acabou de explodir
    JNZ avanca_obstaculo        ; se não, movimenta o obstáculo
    MOV R8, NAO_EXPLOSAO        
    MOV R9, EXPLOSAO_OBSTACULOS ; tabela que define o estado de explosão dos obstáculos
    MOV [R9+R10], R8            ; define que o obstáculo não está a explodir
    JMP novo_obstaculo  

avanca_obstaculo:
    MOV R9, MAX_LINHA   
    CMP R1, R9          ; verifica se chegou à última linha do ecrã
    JZ novo_obstaculo   ; se o obstáculo chegou ao final do ecrã então este irá desaparecer e outro
                        ;obstáculo diferente surgirá no topo do ecrã

    ; avança o obstáculo 1 linha para baixo
    ADD R1, 1   
    MOV R9, LINHA_OBSTACULOS    ; tabela que define as linhas dos obstáculos
    MOV [R9+R10], R1            ; aumenta a linha do obstáculo

    JMP escolhe_nova_repre

explode_obstaculo:
    MOV R9, TIPO_OBSTACULOS         ; tabela com os tipos dos obstáculos  
    MOV R9, [R9+R10]                ; lê o tipo do obstáculo
    CMP R9, TIPO_GARRAFA            ; verifica se é uma garrafa
    JNZ explode_carro               ; se não for, explode o obstáculo carro  
    MOV R4, DEF_EXPLOSAO_GARRAFA    ; tabela que define a garrafa em explosão
    JMP desenha_explosao            ; desenha a garrafa a explodir

explode_carro:
    MOV R4, DEF_EXPLOSAO_CARRO      ; tabela que define o carro a explodir

desenha_explosao:
    MOV R8, ACABA_EXPLOSAO      
    MOV R9, EXPLOSAO_OBSTACULOS ; tabela que define o estado de explosão dos obstáculos
    MOV [R9+R10], R8            ; muda o estado de explosão do obstáculo
    JMP ciclo_obstaculo

novo_obstaculo:
    MOV R0, N_ESTRADAS  
    CALL rand_int               ; obtém um número aleatório entre 0 e N_ESTRADAS-1
    SHL R0, 1                   ; será o índice de uma tabela definida com WORDs
    MOV R2, ESTRADAS            ; tabela da posição onde escrever os obstáculos de modo a eles
                                ;ficarem cenrtados na estrada
    MOV R2, [R2+R0]             ; estrada escolhida de forma aleatória
    MOV R8, COLUNA_OBSTACULOS   ; tabela das colunas dos obstáculos
    MOV [R8+R10], R2            ; coloca o obstáculo numa nova estrada (coluna)

    MOV R9, LINHA_OBSTACULOS    ; tabela das linhas dos obstáculos
    MOV R1, MIN_LINHA
    MOV [R9+R10], R1            ; coloca o obstáculo no topo da estrada (primeira linha)

    MOV R0, N_TIPOS_PROB_TOTAL  
    CALL rand_int               ; obtém um número aleatório entre 0 e N_TIPOS_PROB_TOTAL
    CMP R0, TIPO_GARRAFA        ; compara o TIPO_GARRAFA com o número escolhido aleatoriamente
    JZ altera_tipo              ; se for igual, já se tem um tipo
    MOV R0, TIPO_CARRO          ; coloca o número aleatório como TIPO_CARRO

altera_tipo:
    MOV R9, TIPO_OBSTACULOS     ; tabela com os tipos dos obstáculos 
    MOV [R9+R10], R0            ; altera o tipo do obstáculo

    JMP escolhe_nova_repre

termina_obstaculo:
    RET


; **************************************************************************************************
; PESSOA - Processo que desenha a pessoa e a move horizontalmente de forma contínua.
; **************************************************************************************************
PROCESS SP_INICIAL_PESSOA

pessoa:
    MOV R1, LINHA_PESSOA_I  ; inicializa a linha da pessoa
    MOV R2, COLUNA_PESSOA_I ; inicializa a coluna da pessoa
    MOV R9, COLUNA_PESSOA
    MOV [COLUNA_PESSOA], R2 ; inicializa na memória a coluna da pessoa
    MOV R4, DEF_PESSOA      ; tabela de definição da pessoa
    MOV R9, ECRA_PESSOA     
    MOV [ESCOLHE_ECRA], R9  ; seleciona o ecrã da pessoa para a desenhar

ciclo_pessoa:
    CALL desenha_obj        ; desenha a pessoa

ciclo_espera:
    MOV R10, ATRASO_PESSOA  ; coloca em R10 o valor do atraso da pessoa

espera_mov:
    MOV R5, [TECLA_CONTINUO]    ; lê o LOCK e bloqueia até o teclado escrever nele novamente 
    MOV R9, ECRA_PESSOA     
    MOV [ESCOLHE_ECRA], R9      ; seleciona o ecrã da pessoa para a desenhar

    ; verifica o estado atual do jogo
    MOV R9, [ESTADO_JOGO]   ; lê o estado do jogo
    CMP R9, PAUSA           ; verifica se o jogo está em pausa
    JZ espera_mov           ; com o jogo em pausa, não faz nada e fica à espera de nova indicação
    CMP R9, ACABOU          ; verifica se o jogo já acabou
    JZ termina_pessoa       ; se o jogo terminou, termina o processo da pessoa
    SUB R10, 1              ; diminui o atraso
    JNZ espera_mov

testa_move_esq:
    MOV R6, MOVE_ESQ
    CMP R5, R6              ; verifica se a tecla pressionada corresponde a MOVE_ESQ
    JNZ testa_move_dir      ; se não for, testa se é para mover para a direita
    MOV R7, DESLOCA_ESQ     ; sentido do movimento
    JMP mover_pessoa        ; o movimento é para a esquerda

testa_move_dir:
    MOV R6, MOVE_DIR
    CMP R5, R6              ; verifica se a tecla pressionada corresponde a MOVE_DIR
    JNZ ciclo_espera  
    MOV R7, DESLOCA_DIR     ; sentido do movimento

mover_pessoa:
    CALL testa_limites_pessoa   ; testa se a pessoa chegou aos limites laterais do ecrã
    CMP R7, NAO_DESLOCA         ; verifica se o movimento está impedido
    JZ ciclo_espera             ; se sim, volta a esperar que alguma tecla seja pressionada

continua_move_pessoa:
    CALL apaga_obj              ; apagar a pessoa para  a voltar a desenhar numa nova posição
    ADD R2, R7                  ; adicionar o deslocamento à coluna da pessoa
    MOV [COLUNA_PESSOA], R2     ; atualizar em memória a coluna da pessoa
    JMP ciclo_pessoa

termina_pessoa:
    RET


; **************************************************************************************************
; ENERGIA - Processo responsável pela diminuição periódica da energia marcada pela interrupção 2
; **************************************************************************************************
PROCESS SP_INICIAL_ENERGIA

energia:
    MOV R1, MAX_VAL_DISPLAYS
    MOV [DISPLAYS_VAL], R1     ; inicializa o valor da energia a 100
    MOV R0, [DISPLAYS_VAL]      ; imagem do valor dos displays
    CALL hex2dec                ; transforma o valor guardado em R0 de hexadecimal para decimal
    MOV [DISPLAYS], R0          ; coloca a imagem do valor dos displays nos displays

espera_int_energia:
    MOV R4, [INT_DEC_ENERGIA]   ; bloqueia neste LOCK até a interrupção 2 ocorrer

    ; verifica o estado atual do jogo
    MOV R9, [ESTADO_JOGO]
    CMP R9, PAUSA
    JZ espera_int_energia   ; com o jogo em pausa, não faz nada e fica à espera de nova interrupção
    CMP R9, ACABOU       
    JZ termina_energia      ; se o jogo terminou, termina o processo da energia

    MOV R5, ENERGIA_DEC_TEMPO   ; diminui o valor dos displays
    CALL add_energia
    JMP espera_int_energia

termina_energia:
    RET



; **************************************************************************************************
; BALA - 
; **************************************************************************************************
PROCESS SP_INICIAL_BALA

bala:
    MOV R4, DEF_BALA            ; tabela de definição da bala
    MOV R7, TRUE
    MOV R8, FALSE
    MOV R9, 0    ;ECRA_PESSOA

    MOV [BALA_EXISTE], R8

espera_disparo:
    MOV [BALA_EXISTE], R8       ; a bala ainda não foi disparada
    MOV R5, [TECLA_PRESS]       ; lê o LOCK e bloqueia até ser pressionada uma tecla

    ; verifica o estado atual do jogo
    MOV R9, [ESTADO_JOGO]
    CMP R9, PAUSA
    JZ espera_disparo       ; com o jogo em pausa, não faz nada e fica à espera que seja disparada
    CMP R9, ACABOU       
    JZ termina_bala         ; se o jogo terminou, termina o processo da bala

    CMP R5, TECLA_BALA      ; verifica se a tecla pressionada é a da bala
    JNZ espera_disparo      ; se não for, volta a esperar
    
    MOV R5, SOM_DISPARO
    MOV [REPRODUZIR], R5

    MOV R1, LINHA_PESSOA_I      ; inicializa a linha da bala
    SUB R1, 2
    MOV [LINHA_BALA], R1
    MOV R2, [COLUNA_PESSOA]     ; inicializa a coluna da bala
    ADD R2, 2
    MOV [COLUNA_BALA], R2
    MOV [BALA_EXISTE], R7       ; avisa que a bala existe

    MOV R5, ENERGIA_DEC_BALA
    CALL add_energia

    MOV [ESCOLHE_ECRA], R9      ; seleciona o ecrã para desenhar a bala

move_bala:
    CALL desenha_obj

espera_int_bala:
    MOV R5, [INT_MOV_BALA]  ; lê o LOCK e bloqueia até ocorrer a interrupção 1

    ; verifica o estado atual do jogo
    MOV R9, [ESTADO_JOGO]
    CMP R9, PAUSA
    JZ espera_int_bala      ; com o jogo em pausa, não faz nada e fica à espera de nova interrupção
    CMP R9, ACABOU       
    JZ termina_bala         ; se o jogo terminou, termina o processo da energia
     
    MOV [ESCOLHE_ECRA], R9  ; seleciona o ecrã para desenhar a bala

    CALL apaga_obj
    SUB R1, 1               ; move a bala 1 pixel para cima
    MOV [LINHA_BALA], R1
    MOV R6, ALCANCE_BALA
    CMP R1, R6
    JZ espera_disparo
    MOV R6, [BALA_EXISTE]
    CMP R6, TRUE            ; verifica se a bala ainda existe
    JZ move_bala            ; se existir volta a tentar movê-la
    JMP espera_disparo      ; se não, volta a ficar à espera que a tecla da bala seja pressionada

termina_bala:
    RET
    

; **************************************************************************************************
; * Rotinas
; **************************************************************************************************

; **************************************************************************************************
; CONVERTE_TECLA - Devolve o valor da tecla correspondente à linha e à coluna dadas como argumentos.
;
; Argumentos:   R0 - valor primário da linha
;               R1 - valor primário da coluna
;
; Retorna:  R5 - valor da tecla detetada convertido
; **************************************************************************************************
converte_tecla:  
    PUSH R0
    PUSH R1 
    MOV R5, -1  ; valor inicia a -1 pois a numeração das linhas começa em 0

converte_l:         ; converter o bit a 1 da linha em valor numérico
    ADD R5, 1       ; contar o número de vezes que se desloca o valor da linha
    SHR R0, 1       ; desloca o valor da linha, 1 bit de cada vez
    CMP R0, 0       ; verifica se ainda não chegou a zero
    JNZ converte_l
    SHL R5, 2       ; multiplica o valor por 4
    SUB R5, 1       ; retira 1 pois a numeração das colunas começa em 0

converte_c:         ; converter o bit a 1 da coluna em valor numérico
    ADD R5, 1       ; contar o número de vezes que se desloca o valor da coluna
    SHR R1, 1       ; desloca o valor da coluna, 1 bit de cada vez
    CMP R1, 0       ; verifica se ainda não chegou a zero
    JNZ converte_c

sair_converte_tecla:
    POP R1
    POP R0
    RET

; **************************************************************************************************
; DESENHA_OBJ - Desenha um objeto na linha e coluna indicadas com a forma e cor definidas na tabela
;               indicada.
;
; Argumentos:   R1 - linha do objeto
;               R2 - coluna do objeto
;               R4 - tabela que define o objeto
; **************************************************************************************************
desenha_obj:
    PUSH R0
    PUSH R1
    PUSH R2
	PUSH R3
    PUSH R5
    PUSH R6
    PUSH R7
    PUSH R8
    MOV	R5, [R4]    ; obtém a largura do objeto
    MOV R6, [R4+2]  ; obtém a altura do objeto
    MOV R0, 4
    MOV R7, R2      ; cria uma cópia da coluna do pixel de referência do objeto

desenha_pixels:       	    ; desenha os pixels do objeto a partir da tabela
	MOV	R3, [R4+R0]         ; obtém a cor do pixel atual a desenhar do objeto
    CALL eh_pos_valida      ; verifica se a linha e coluna estão dentro dos limites do ecrã
    CMP R8, FALSE
    JZ desenha_prox_posicao ; se a posição não for válida passa à próxima posição
	CALL escreve_pixel      ; escreve cada pixel do objeto

desenha_prox_posicao:	
    ADD	R0, 2			; endereço da cor do próximo pixel
    ADD R2, 1           ; próxima coluna
    SUB R5, 1			; menos uma coluna para tratar
    JNZ desenha_pixels  ; continua até percorrer toda a largura do objeto
    MOV R5, [R4]        ; restaurar o valor da largura
    MOV R2, R7          ; restaurar o valor da coluna
    ADD R1, 1           ; próxima linha
    SUB R6, 1			; menos uma linha para tratar
    JNZ desenha_pixels  ; continua até percorrer toda a altura do objeto

sair_desenha_obj:
    POP R8
    POP R7
    POP R6
    POP	R5
	POP	R3
    POP R2
    POP R1
    POP R0
	RET

; **************************************************************************************************
; APAGA_OBJ - Apaga um objeto na linha e coluna indicadas com a forma definida na tabela indicada.
;
; Argumentos:   R1 - linha do objeto
;               R2 - coluna do objeto
;               R4 - tabela que define o objeto
; **************************************************************************************************
apaga_obj:
    PUSH R1
	PUSH R2
	PUSH R3
    PUSH R5
    PUSH R6
    PUSH R7
    MOV R3, TRANSP  ; "cor" para apagar os pixeis do objeto
    MOV	R5, [R4]    ; obtém a largura do objeto
    MOV R6, [R4+2]  ; obtém a altura do objeto
    MOV R7, R2      ; cria uma cópia da coluna do pixel de referência do objeto

apaga_pixels:       	; apaga os pixels do objeto a partir da tabela
	CALL escreve_pixel	; escreve cada pixel do objeto
    ADD R2, 1           ; próxima coluna
    SUB R5, 1			; menos uma coluna para tratar
    JNZ apaga_pixels    ; continua até percorrer toda a largura do objeto
    MOV R5, [R4]        ; restaurar o valor da largura
    MOV R2, R7          ; restaurar o valor da coluna
    ADD R1, 1           ; próxima linha
    SUB R6, 1			; menos uma linha para tratar
    JNZ apaga_pixels    ; continua até percorrer toda a altura do objeto

sair_apaga_obj:
    POP R7
    POP R6
    POP	R5
	POP	R3
	POP	R2
    POP R1
	RET

; **************************************************************************************************
; ESCREVE_PIXEL - Escreve um pixel na linha e coluna indicadas.
;
; Argumentos:   R1 - linha
;               R2 - coluna
;               R3 - cor do pixel (em formato ARGB de 16 bits)
; **************************************************************************************************
escreve_pixel:
	MOV  [DEFINE_LINHA], R1		; seleciona a linha
	MOV  [DEFINE_COLUNA], R2    ; seleciona a coluna
	MOV  [DEFINE_PIXEL], R3		; altera a cor do pixel na linha e coluna já selecionadas
	RET

; **************************************************************************************************
; EH_POS_VALIDA - Verifica se a posição dada está dentro dos limites do ecrã
;
; Argumentos:   R1 - linha
;               R2 - coluna
;    
; Retorna:  R8 - valor que indica se a linha é válida
; **************************************************************************************************
eh_pos_valida:
    PUSH R0
    
    MOV R0, MIN_LINHA
    CMP R1, R0              ; compara a linha com o limite inferior do ecrã 
    JN pos_nao_valida       ; se a linha é menor, então não é válida

    MOV R0, MAX_LINHA       
    CMP R1, R0              ; compara a linha com o limite superior do ecrã 
    JP pos_nao_valida       ; se a linha é maior, então não é válida

    MOV R0, MIN_COLUNA
    CMP R2, R0              ; compara a coluna com o limite esquerdo do ecrã 
    JN pos_nao_valida       ; se a coluna é menor, então não é válida

    MOV R0, MAX_COLUNA       
    CMP R2, R0              ; compara a coluna com o limite direito do ecrã 
    JP pos_nao_valida       ; se a coluna é maior, então não é válida

    MOV R8, TRUE            ; coloca a TRUE o valor de retorno 
    JMP sair_eh_pos_valida

pos_nao_valida:
    MOV R8, FALSE   ; coloca a FALSE o valor de retorno

sair_eh_pos_valida:
    POP R0
    RET

; **************************************************************************************************
; TESTA_LIMITES_PESSOA - Testa se a pessoa chegou aos limites do ecrã e nesse caso impede o
;                        movimento (força R7 a 0). Caso contrário, permite o movimento (mantém R7).
;
; Argumentos:	R2 - coluna em que a pessoa está
;			    R6 - largura da pessoa
;			    R7 - sentido de movimento da pessoa (valor a somar à coluna em cada movimento)
;
; Retorna:  R7 - 0 se já tiver chegado ao limite, inalterado caso contrário	
; **************************************************************************************************
testa_limites_pessoa:
	PUSH	R4
	PUSH	R6

    MOV R6, LARGURA_PESSOA
    CMP R7, DESLOCA_ESQ             ; verifica se a pessoa se está a deslocar apra a esquerda
    JNZ testa_limite_direito        ; caso não esteja, vai testar o limite direito
testa_limite_esquerdo:		        
	MOV	R4, MIN_COLUNA              ; mínima coluna que um objeto pode estar
	CMP	R2, R4                      ; vê se a pessoa chegou ao limite esquerdo
    JP sair_testa_limites_pessoa
    JMP impede_movimento            ; se sim, impede o movimento

testa_limite_direito:		        
	ADD	R6, R2			            ; posição a seguir ao extremo direito da pessoa
	MOV	R4, MAX_COLUNA              ; máxima coluna que um objeto pode estar
	CMP	R6, R4                      ; vê se a pessoa chegou ao limite direito
	JNP sair_testa_limites_pessoa	; se não chegou à posição limite, sai da rotina

impede_movimento:
	MOV	R7, NAO_DESLOCA     ; impede o movimento, forçando R7 a 0

sair_testa_limites_pessoa:	
	POP	R6
	POP	R4
	RET            

; **************************************************************************************************
; HEX2DEC - Converte número em base hexadecimal no mesmo número mas representado em base decimal.
;               
; Argumentos:   R0 - valor em base hexadecimal
;
; Retorna:  R0 - valor em base decimal
; **************************************************************************************************
hex2dec:
    PUSH R3
    PUSH R5
    PUSH R6

    MOV R6, 10  ; base decimal

    MOV R3, R0  ; copia o primeiro dígito
    MOD R3, R6  ; resto da divisão por 10 dá o valor final do primeiro dígito em base decimal
    DIV R0, R6  ; o quociente por 10 dá o número de vezes que a representação do primeiro dígito
                ;excedeu o maior dígito decimal (9)

    MOV R5, R0  ; copia o segundo dígito
    MOD R5, R6  ; resto da divisão por 10 dá o valor final do segundo dígito em base decimal
    DIV R0, R6  ; o quociente por 10 dá o número de vezes que a representação do segundo dígito
                ;excedeu o maior dígito decimal (9)

prox_dig:
    SHL R0, 4   ; arranjar espaço para o segundo dígito
    OR R0, R5   ; adicionar o segundo dígito
    SHL R0, 4   ; arranjar espaço para o primeiro dígito
    OR R0, R3   ; adicionar o primeiro dígito
    JMP sair_hex2dec

sair_hex2dec:
    POP R6
    POP R5
    POP R3
    RET

; **************************************************************************************************
; RAND_INT - determina um valor aleatório entre 0 e R0 - 1
;               
; Argumentos:   R0 - número de valores possíveis (valores entre 0 e n-1) (limites possíveis: 2, 4,
;               8, 16)
;
; Retorna:  R0 - valor aleatório
; **************************************************************************************************
rand_int:
    PUSH R1

    SUB R0, 1           ; retira-se 1 ao limite, pois começa em zero
    MOV R1, [TEC_COL]   ; ler os bits do PIN (valor da coluna do teclado)
    SHR R1, 4           ; aproveita-se apenas os 4 bits de maior peso e coloca-se em nibble low

    AND R1, R0  ; filtra os bits aleatórios de R1 para serem menores ou iguais a R0
    MOV R0, R1  ; copia os bits filtrados para R0

sair_rand_int:
    POP R1
    RET

; **************************************************************************************************
; ESCOLHE_REPRE - escolhe a representação do obstáculo correspondente à linha em que está no ecrã
;                 (ou seja, depende da distância à pessoa)
;               
; Argumentos:   R10 - offset correspondente ao número do obstáculo
;
; Retorna:  R4 - endereço da representação do obstáculo
; **************************************************************************************************
escolhe_repre:
    PUSH R0
    PUSH R1

    MOV R4, TIPO_OBSTACULOS
    MOV R4, [R4+R10]        ; guarda o tipo do obstáculo em R4

    ; guarda em R0 o offset da representação de acordo com o valor de linha atual do obstáculo
    MOV R0, LINHA_OBSTACULOS
    MOV R0, [R0+R10]
    MOV R1, MOVS_ALT_REPRE  ; divide-se o valor da linha pelo número de linhas por representação
    DIV R0, R1

    CMP R0, ULT_REPRE
    JN selecionar_linha
    MOV R0, ULT_REPRE   ; se o offset for superior à última representação, então fica com o valor
                        ;da última representação

selecionar_linha:
    SHL R0, 1                   ; multiplica-se por 2 pois é uma tabela de WORDS
    ADD R4, R0
    SHL R4, 1                   ; multiplica-se por 2 pois é uma tabela de WORDS
    MOV R0, OBSTACULOS_REPRES
    MOV R4, [R4+R0]             ; associa a R4 o endereço da representação a partir da tabela

sair_escolhe_repre:
    POP R1
    POP R0
    RET

; **************************************************************************************************
; TRATA_COLISOES - trata as possíveis colisões que podem ocorrer com um obstáculo (carro-pessoa,
;                  carro-bala, garrafa-pessoa, garrafa-bala), possibilitando a execução das
;                  consequências das mesmas.
;               
; Argumentos:   R10 - offset correspondente ao número do obstáculo
;
; Retorna:  
; **************************************************************************************************
trata_colisoes:
    PUSH R0 
    PUSH R1
    PUSH R2
    PUSH R3
    PUSH R4
    PUSH R5
    PUSH R6
    PUSH R7
    PUSH R8
    PUSH R9

    ; limite superior do obstáculo (R8)
    MOV R8, LINHA_OBSTACULOS
    MOV R8, [R8+R10]

    ; limite inferior do obstáculo (R9)
    MOV R9, R8
    ADD R9, ALTURA_OBSTACULOS
    SUB R9, 1

    ; limite esquerdo do obstáculo (R6)
    MOV R6, COLUNA_OBSTACULOS
    MOV R6, [R6+R10]

    ; limite direito do obstáculo (R7)
    MOV R7, R6
    ADD R7, LARGURA_CARRO_2
    SUB R7, 1

    ; ajustes nos limites laterais consoante o tipo de obstáculo
    MOV R4, TIPO_OBSTACULOS
    MOV R4, [R4+R10]            ; R4 guarda o tipo do obstáculo
    MOV R0, TIPO_GARRAFA
    CMP R4, R0
    JNZ testa_bala_disparada    ; se for garrafa tem de encurtar a largura 1 unidade tanto à
                                ;esquerda como à direita
    ADD R6, 1
    SUB R7, 1

testa_bala_disparada:
    ; verifica se a bala foi disparada
    MOV R0, [BALA_EXISTE]
    CMP R0, TRUE
    JNZ testa_colisao_pessoa    ; se não foi, verifica a próxima colisão

    ; verifica se a coluna da bala está entre as colunas do obstáculo
    MOV R0, [COLUNA_BALA]
    MOV R1, R6
    MOV R2, R7
    CALL pertence_interv
    CMP R3, TRUE
    JNZ testa_colisao_pessoa ; se não está, verifica a próxima colisão

    ; verifica se a linha da bala coincide ou está a cima do limite inferior do obstáculo
    MOV R0, [LINHA_BALA]
    SUB R0, 1
    CMP R0, R9
    JNP colidiu_bala    ; se sim, ocorreu colisão

testa_colisao_pessoa:
    ; verifica se o limite inferior do obstáculo já atingiu o limite superior da pessoa
    MOV R1, LINHA_PESSOA_I
    CMP R9, R1
    JN sair_trata_colisoes  ; se não, então já não há mais colisões a tratar

    ; coloca em R1 o limite esquerdo da pessoa e em R2 o limite direito da pessoa
    MOV R1, [COLUNA_PESSOA]
    MOV R2, R1
    MOV R5, LARGURA_PESSOA
    ADD R2, R5              ; adiciona-se a largura da pessoa ao limite esquerdo
    SUB R2, 1               ; retira-se uma unidade
    
    ; verifica se o limite esquerdo do obstáculo está entre os limites laterais da pessoa
    MOV R0, R6
    CALL pertence_interv
    CMP R3, TRUE
    JZ colidiu_pessoa   ; se sim, então ocorreu colisão
    
    ; verifica se o limite direito do obstáculo está entre os limites laterais da pessoa
    MOV R0, R7
    CALL pertence_interv
    CMP R3, TRUE
    JNZ sair_trata_colisoes ; se sim, então ocorreu colisão

colidiu_pessoa:
    ; verifica qual o tipo de obstáculo com que a pessoa colidiu
    MOV R0, TIPO_GARRAFA
    CMP R4, R0
    JNZ colisao_pessoa_carro

colisao_pessoa_garrafa:
    ; verificar se a água já foi bebida (explodiu na pessoa)
    MOV R0, NAO_EXPLOSAO
    MOV R1, EXPLOSAO_OBSTACULOS
    MOV R2, [R1+R10]
    CMP R0, R2
    JNZ sair_trata_colisoes 

    MOV R5, SOM_GARRAFA_BEBIDA
    MOV [REPRODUZIR], R5        ; reproduz o som de beber a água

    MOV R5, ENERGIA_INC_GARRAFA 
    CALL add_energia            ; adiciona a respetiva energia por ter bebido a água
    MOV R0, COMECA_EXPLOSAO     ; informa que ocorreu explosão da garrafa
    MOV [R1+R10], R0
    JMP sair_trata_colisoes

colisao_pessoa_carro:
    MOV R0, ACABOU
    MOV [ESTADO_JOGO], R0   ; informa que o jogo terminou
    MOV R0, ACABOU_CARRO
    MOV [COMO_ACABOU], R0   ; informa que o jogo terminou por colisão da pessoa com o carro
    MOV R0, TECLA_END
    MOV [TECLA_PRESS], R0   ; desbloqueia o processo controlo para tratar este término do jogo

    ; para explodir o obstáculo e não mover mais uma linha antes de terminar o jogo
    MOV R1, COMECA_EXPLOSAO
    MOV R0, EXPLOSAO_OBSTACULOS
    MOV [R0+R10], R1

    JMP sair_trata_colisoes

colidiu_bala:
    ; faz com que a bala desapareça
    MOV R0, FALSE
    MOV [BALA_EXISTE], R0

    ; informa que o obstáculo está em explosão
    MOV R0, COMECA_EXPLOSAO
    MOV R1, EXPLOSAO_OBSTACULOS
    MOV [R1+R10], R0

    ; verifica com que tipo de obstáculo a bala colidiu
    MOV R0, TIPO_GARRAFA
    CMP R4, R0
    JNZ colisao_bala_carro

colisao_bala_garrafa:
    MOV R5, SOM_GARRAFA_DESTRUIDA
    MOV [REPRODUZIR], R5
    JMP sair_trata_colisoes

; se o obstáculo em explosão for um carro, aumenta a energia da pessoa
colisao_bala_carro:
    MOV R5, SOM_CARRO_DESTRUIDO
    MOV [REPRODUZIR], R5    ; reproduz o som de explosão do carro

    MOV R5, ENERGIA_INC_CARRO
    CALL add_energia            ; incrementa a respetiva energia advinda da colisão

sair_trata_colisoes:
    POP R9
    POP R8
    POP R7
    POP R6
    POP R5
    POP R4
    POP R3
    POP R2
    POP R1
    POP R0
    RET


; **************************************************************************************************
; PERTENCE_INTERV - verifica se um dado valor R0 pertence a um intervalo fechado de limite esquerdo
;                   R1 e limite direito R2.
;               
; Argumentos:   R0 - número a testar
;               R1 - limite esquerdo do intervalo
;               R2 - limite direito do intervalo
;
; Retorna:  R3 - TRUE se pertencer ao intervalo, FALSE caso contrário
; **************************************************************************************************
pertence_interv:
    CMP R0, R1
    JN nao_pertence ; se R0 for menor que R1 então R0 não poderá pertencer ao intervalo [R1, R2]
    CMP R0, R2
    JP nao_pertence ; se R0 for maior que R2 então R0 não poderá pertencer ao intervalo [R1, R2]
    MOV R3, TRUE
    JMP sair_pertence_interv
nao_pertence:
    MOV R3, FALSE
sair_pertence_interv:
    RET

; **************************************************************************************************
; ADD_ENERGIA - adiciona à energia (mostrada nos displays) o valor que é dado como argumento e
;               atualiza o valor nos displays.
;               
; Argumentos:   R5 - valor a adicionar à energia 
; **************************************************************************************************
add_energia:
    PUSH R0
    PUSH R1

    MOV R0, [DISPLAYS_VAL]      ; lê imagem do valor dos displays
    ADD R0, R5                  ; adiciona o valor ao valor dos displays

    ; verifica se atingiu o máximo de energia e, se sim, fixa o valor em MAX_VAL_DISPLAYS
    MOV R1, MAX_VAL_DISPLAYS    
    CMP R0, R1
    JNP testa_min_energia
    MOV R0, R1

testa_min_energia:
    ; verifica se atingiu o mínimo de energia e, se sim, fixa o valor em MIN_VAL_DISPLAYS
    MOV R1, MIN_VAL_DISPLAYS
    CMP R0, R1
    JP atualizar_displays
    MOV R0, R1

    MOV R1, ACABOU
    MOV [ESTADO_JOGO], R1   ; altera o estado do jogo para ACABOU
    MOV R1, ACABOU_ENERGIA
    MOV [COMO_ACABOU], R1   ; informa que acabou por falta de energia
    MOV R1, TECLA_END
    MOV [TECLA_PRESS], R1   ; desbloqueia o processo controlo para tratar este término do jogo

    MOV R5, SOM_ACABOU_ENERGIA
    MOV [REPRODUZIR], R5        ; reproduz o som de ter terminado o jogo por falta de energia
    
atualizar_displays:
    MOV [DISPLAYS_VAL], R0      ; atualiza o valor da imagem dos displays
    CALL hex2dec                ; transforma o valor guardado em R0 de hexadecimal para decimal
    MOV [DISPLAYS], R0          ; colocar a imagem do valor dos displays nos displays

sair_add_energia:
    POP R1
    POP R0
    RET

; **************************************************************************************************
; * Interrupções
; **************************************************************************************************

; **************************************************************************************************
; int_obstaculos: - rotina de interrupção que informa quando um obstáculo se deve mover.
; **************************************************************************************************
int_obstaculos:
	MOV	[INT_MOV_OBSTACULO], R0	; desbloqueia o processo obstaculo
	RFE

; **************************************************************************************************
; int_bala - rotina de interrupção que informa quando a bala se deve mover.
; **************************************************************************************************
int_bala:
	MOV	[INT_MOV_BALA], R0	; desbloqueia o processo bala
	RFE

; **************************************************************************************************
; int_energia - rotina de interrupção que informa quando o nível de energia deve diminuir um valor
;               periódico.
; **************************************************************************************************
int_energia:
	MOV	[INT_DEC_ENERGIA], R0	; desbloqueia o processo energia
	RFE
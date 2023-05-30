.data
  menu: .asciiz "1 - Fahrenheit - > Celsius\n2 - Fibonnacci\n3 - Enesimo par\n4 - Sair\n \n"
  paramentro_sub_fahrenheit: .float 32
  paramentro_div_fahrenheit: .float 1.8
  
.text
  ## Cria um "la�o de repeti��o". Aqui, poderia ser qualquer nome, mas para criar semelhan�a as outras linguagens,
  ## ser� adotado o nome while
  while:
    ## Todo o c�digo dentro desse m�dulo ser� repetido infinitamente, at� o usu�rio escolher a op��o 4
    
    
    jal quebraLinha # Chama a fun��o que quebrar� a linha
    
    ## Neste trecho, ser� mostrado o menu de op��es definido na vari�vel menu
    la    $a0, menu         # Aqui o valor definido em menu � carregado no registrador $a0
    jal imprimeTexto        # chamando a fun��o que vai imprimir um texto
            
            
    ## Neste trecho, ser� lida e salva a escolha do usu�rio
    jal leInteiro           # chamando a fun��o que vai ler um inteiro
    move $s0, $v0	    # Salvando a escolha do usu�rio no registrador $s0
    
    
    ## Neste trecho, a depender da escolha do usu�rio, ser� executada uma fun��o diferente
    beq   $s0, 1, fahrenheit_celcius       # Se for escolhido 1, chama a fun��o que converte fahrenheit para c�lcius                                  
    beq   $s0, 2, fibonacci                # Se for escolhido 2, chama a fun��o que mostra o en�simo termo de fibonacci
    beq   $s0, 3, enesimo_par              # Se for escolhido 3, chama a fun��o que mostra o en�simo termo n�mero par
    beq   $s0, 4, finalizar_programa       # Se for escolhido 4, chama a fun��o que vai encerrar o programa

                                    
    j while # executa o m�dulo while de novo
    
    
  ## Criando a fun��o que vai finalizar o programa  
  finalizar_programa:
    ## Nessa fun��o o programa ser� encerrado
    li $v0, 10               # Aqui atribu�mos o valor 10 para $v0
    syscall		     # e ao chamar o syscall com $v0 = 10, o programa � finalizado.

  
  ## Criando a fun��o que vai imprimir textos
  imprimeTexto:
    ## Essa fun��o imprimir� o texto armazenado no registrador $a0
    li    $v0, 4            # Nessa linha o valor 4 � atribu�do ao registrador $v0
    syscall                 # e aqui a fun��o syscall � chamada, ela olhar� o valor de $v0 e executar� uma a��o
                            # Nesse caso, como o valor � 4, ser� chamada a fun��o print_string, 
                            # que exibir� em tela o valor armazenado no registrador $a0
                            
    jr $ra   # Retornar� o valor da fun��o aonde ela foi chamada
    
  ## Criando a fun��o que vai imprimir inteiros
  imprimeInteiro:
    ## Essa fun��o imprimir� o inteiro armazenado no registrador $a0
    li    $v0, 1            # Nessa linha o valor 1 � atribu�do ao registrador $v0
    syscall                 # e aqui a fun��o syscall � chamada, ela olhar� o valor de $v0 e executar� uma a��o
                            # Nesse caso, como o valor � 1, ser� chamada a fun��o print_int, 
                            # que exibir� em tela o valor armazenado no registrador $a0
                            
    jr $ra   # Retornar� o valor da fun��o aonde ela foi chamada
    
  ## Criando a fun��o que vai ler inteiros
  leInteiro:
    ## Essa fun��o ler� um inteiro informado pelo usu�rio
    li    $v0, 5            # Nessa linha o valor 5 � atribu�do ao registrador $v0
    syscall                 # e aqui a fun��o syscall � chamada, ela olhar� o valor de $v0 e executar� uma a��o
                            # Nesse caso, como o valor � 5, ser� chamada a fun��o read_int, 
                            # que esperar� que usu�rio digite um n�mero inteiro
                            
    jr $ra   # Retornar� o valor da fun��o aonde ela foi chamada
  
  ## Criando a fun��o que vai imprimir float
  imprimeFloat:
    ## Essa fun��o imprimir� o float armazenado no registrador $f12
    li    $v0, 2           # Nessa linha o valor 2 � atribu�do ao registrador $v0
    syscall                 # e aqui a fun��o syscall � chamada, ela olhar� o valor de $v0 e executar� uma a��o
                            # Nesse caso, como o valor � 2, ser� chamada a fun��o print_float, 
                            # que exibir� em tela o valor armazenado no registrador $f12
                                     
    jr $ra   # Retornar� o valor da fun��o aonde ela foi chamada
  
  ## Criando a fun��o que vai ler float
  leFloat:
    ## Essa fun��o ler� um ponto flotoante informado pelo usu�rio
    li    $v0, 6            # Nessa linha o valor 6 � atribu�do ao registrador $f0
    syscall                 # e aqui a fun��o syscall � chamada, ela olhar� o valor de $f0 e executar� uma a��o
                            # Nesse caso, como o valor � 6, ser� chamada a fun��o read_float, 
                            # que esperar� que usu�rio digite um n�mero de ponto flotoante
                            
    jr $ra   # Retornar� o valor da fun��o aonde ela foi chamada
  
  
  ## Criando a fun��o que vai quebrar a linha de c�digo
  quebraLinha: 
    ## Essa fun��o ir� atribuir o caractere de quebra de linha ao registrador $a0 e atribuir o valor 11 ao $v0
    li $a0, '\n'
    li $v0, 11
    syscall # como o valor em $v0 � 11, ser� chamada a fun��o print_char, que vai buscar o valor do caractere em $a0

    ## Como o caractere em $a0 � o \n, a linha ser� quebrada

    jr $ra  # Retornar� o valor da fun��o aonde ela foi chamada
  

  ## Criando a fun��o que vai converter o valor informado de c�lcius para fahrenheit
  fahrenheit_celcius:
    ## Nessa fun��o ser� feita a convers�o de fahrenheit para c�lcius
    ## A f�rmula utilizada �: Celsius = (Fahrenheit - 32)/1.8
    
   ## L� a temperatura em Fahrenheit do usu�rio
   jal leFloat

    ## Aplicando a f�rmula para converter o valor em Fahrenheit para C�lcius
    lwc1 $f1, paramentro_sub_fahrenheit  # Atribui o valor de paramentro_sub_fahrenheit(32) ao registrador $f1  
    sub.s $f0, $f0, $f1       # Subtrai 32 do valor em Fahrenheit informado pelo usuario e salva em $f0
    lwc1 $f1, paramentro_div_fahrenheit # Atribui o valor de paramentro_div_fahrenheit(1.8) ao registrador $f1
    div.s $f0, $f0, $f1          # Divide o valor em $f0 por 1.8
   
    mov.s $f12, $f0 # Move o valor de $f0 para $f12
    
    # A temperatura em Celsius est� em $f12
    jal imprimeFloat #Imprime o valor
    
    jal quebraLinha #Pular linha

    j while #Volta ao menu principal
  
  
  ## Criando a fun��o para calcular o en�simo termo da sequ�ncia de Fibonacci
  fibonacci:
   

  ## Criando a fun��o que ir� calcular o en�simo n�mero par
  enesimo_par:

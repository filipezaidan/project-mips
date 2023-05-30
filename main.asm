### No .data é o local onde será declarado a inicialização das variaveis que sera utilizado durante a execução do programa
.data
  menu: .asciiz "1 - Fahrenheit - > Celsius\n2 - Fibonnacci\n3 - Enesimo par\n4 - Sair\n \n"
  
  entrada_fahrenheit_celcius: .asciiz "\nDigite a temperatura em Fahrenheit para que eu possa converta-la para Celcius: "
  entrada_fibonacci: .asciiz "\nDigite o enésimo termo que você deseja saber na sequência em Fibonacci: "
  entrada_enesimo_par: .asciiz "\nDigite o enésimo termo par: "
  
  paramentro_sub_fahrenheit: .float 32
  paramentro_div_fahrenheit: .float 1.8
  
  saida_resultado: .asciiz "Resultado: "
  
.text
  ## Cria um "laço de repetição". Aqui, poderia ser qualquer nome, mas para criar semelhança as outras linguagens,
  ## será adotado o nome while
  while:
    ## Todo o código dentro desse módulo será repetido infinitamente, até o usuário escolher a opção 4
    
    jal quebraLinha # Chama a função que quebrará a linha
    
    ## Neste trecho, será mostrado o menu de opções definido na variável menu
    la    $a0, menu         # Aqui o valor definido em menu é carregado no registrador $a0
    jal imprimeTexto        # chamando a função que vai imprimir um texto
            
            
    ## Neste trecho, será lida e salva a escolha do usuário
    jal leInteiro           # chamando a função que vai ler um inteiro
    move $s0, $v0	    # Salvando a escolha do usuário no registrador $s0
    
    
    ## Neste trecho, a depender da escolha do usuário, será executada uma função diferente
    beq   $s0, 1, fahrenheit_celcius       # Se for escolhido 1, chama a função que converte fahrenheit para célcius                                  
    beq   $s0, 2, fibonacci                # Se for escolhido 2, chama a função que mostra o enésimo termo de fibonacci
    beq   $s0, 3, enesimo_par              # Se for escolhido 3, chama a função que mostra o enésimo termo número par
    beq   $s0, 4, finalizar_programa       # Se for escolhido 4, chama a função que vai encerrar o programa

                                    
    j while # executa o módulo while de novo
    
    
  ## Criando a função que vai finalizar o programa  
  finalizar_programa:
    ## Nessa função o programa será encerrado
    li $v0, 10               # Aqui atribuímos o valor 10 para $v0
    syscall		     # e ao chamar o syscall com $v0 = 10, o programa é finalizado.
    
  
  ## Criando a função que vai imprimir textos
  imprimeTexto:
    ## Essa função imprimirá o texto armazenado no registrador $a0
    li    $v0, 4            # Nessa linha o valor 4 é atribuído ao registrador $v0
    syscall                 # e aqui a função syscall é chamada, ela olhará o valor de $v0 e executará uma ação
                            # Nesse caso, como o valor é 4, será chamada a função print_string, 
                            # que exibirá em tela o valor armazenado no registrador $a0
                            
    jr $ra   # Retornará o valor da função aonde ela foi chamada
    
  ## Criando a função que vai imprimir inteiros
  imprimeInteiro:
    ## Essa função imprimirá o inteiro armazenado no registrador $a0
    li    $v0, 1            # Nessa linha o valor 1 é atribuído ao registrador $v0
    syscall                 # e aqui a função syscall é chamada, ela olhará o valor de $v0 e executará uma ação
                            # Nesse caso, como o valor é 1, será chamada a função print_int, 
                            # que exibirá em tela o valor armazenado no registrador $a0
                            
    jr $ra   # Retornará o valor da função aonde ela foi chamada
    
  ## Criando a função que vai ler inteiros
  leInteiro:
    ## Essa função lerá um inteiro informado pelo usuário
    li    $v0, 5            # Nessa linha o valor 5 é atribuído ao registrador $v0
    syscall                 # e aqui a função syscall é chamada, ela olhará o valor de $v0 e executará uma ação
                            # Nesse caso, como o valor é 5, será chamada a função read_int, 
                            # que esperará que usuário digite um número inteiro
                            
    jr $ra   # Retornará o valor da função aonde ela foi chamada
  
  ## Criando a função que vai imprimir float
  imprimeFloat:
    ## Essa função imprimirá o float armazenado no registrador $f12
    li    $v0, 2           # Nessa linha o valor 2 é atribuído ao registrador $v0
    syscall                 # e aqui a função syscall é chamada, ela olhará o valor de $v0 e executará uma ação
                            # Nesse caso, como o valor é 2, será chamada a função print_float, 
                            # que exibirá em tela o valor armazenado no registrador $f12
                                     
    jr $ra   # Retornará o valor da função aonde ela foi chamada
  
  ## Criando a função que vai ler float
  leFloat:
    ## Essa função lerá um ponto flotoante informado pelo usuário
    li    $v0, 6            # Nessa linha o valor 6 é atribuído ao registrador $f0
    syscall                 # e aqui a função syscall é chamada, ela olhará o valor de $f0 e executará uma ação
                            # Nesse caso, como o valor é 6, será chamada a função read_float, 
                            # que esperará que usuário digite um número de ponto flotoante
                            
    jr $ra   # Retornará o valor da função aonde ela foi chamada
  
  
  ## Criando a função que vai quebrar a linha de código
  quebraLinha: 
    ## Essa função irá atribuir o caractere de quebra de linha ao registrador $a0 e atribuir o valor 11 ao $v0
    li $a0, '\n'
    li $v0, 11
    syscall # como o valor em $v0 é 11, será chamada a função print_char, que vai buscar o valor do caractere em $a0

    ## Como o caractere em $a0 é o \n, a linha será quebrada

    jr $ra  # Retornará o valor da função aonde ela foi chamada
  
  ## Criando a função que vai converter o valor informado de célcius para fahrenheit
  fahrenheit_celcius:
    ## Nessa função será feita a conversão de fahrenheit para célcius
    ## A fórmula utilizada é: Celsius = (Fahrenheit - 32)/1.8

    la $a0, entrada_fahrenheit_celcius # Salva o valor da entrada_fahrenheit_celcius em $a0
    jal imprimeTexto  # Imprime o texto que está em entrada_fahrenheit_celcius
    
   ## Lê a temperatura em Fahrenheit do usuário
   jal leFloat

    ## Aplicando a fórmula para converter o valor em Fahrenheit para Célcius
    lwc1 $f1, paramentro_sub_fahrenheit  # Atribui o valor de paramentro_sub_fahrenheit(32) ao registrador $f1  
    sub.s $f0, $f0, $f1       # Subtrai 32 do valor em Fahrenheit informado pelo usuario e salva em $f0
    lwc1 $f1, paramentro_div_fahrenheit # Atribui o valor de paramentro_div_fahrenheit(1.8) ao registrador $f1
    div.s $f0, $f0, $f1          # Divide o valor em $f0 por 1.8
   
    mov.s $f12, $f0 # Move o valor de $f0 para $f12
   
    la $a0, saida_resultado  #Salva o valor da saida_resultado em $a0
    jal imprimeTexto #Imprime o valor de saida_resultado 
    
    # A temperatura em Celsius está em $f12
    jal imprimeFloat #Imprime o valor
    
    jal quebraLinha #Pular linha

    j while #Volta ao menu principal
  
  ## Criando a função para calcular o enésimo termo da sequência de Fibonacci
  fibonacci:
    ## Nessa função, será calculado o enésimo termo da sequência de fibonacci, a partir de um valor inserido 
    ## pelo usuário. 
    ## O cálculo será feito salvando os dois termos anteriores em registradores diferentes, um representando
    ## o último termo, e o outro representando o penúltimo termo.
  
   la $a0, entrada_fibonacci
   jal imprimeTexto
  
    # Primeiro, será pego o enésimo termo a partir do usuário
    jal leInteiro
    move $s0, $v0  # Coloca o enésimo termo no registrador $s0
    
    
    # Inicialmente, os registradores $s1 e $s2 armazenaram os primeiros termos da sequência
    li $s1, 0       # Primeiro termo da sequência de fibonacci
    li $s2, 1       # Segundo termo da sequência de fibonacci


    # Se o enésimo termo for o primeiro ou o segundo termo, pulará o loop e irá direto para o código final
    beq $s0, 0, fim_fibonacci  # Se o enésimo termo for 0, ir direto pro final
    beq $s0, 1, fim_fibonacci  # Se o enésimo termo for 1, ir direto pro final


    # Como os dois primeiros termos já foram definidos, é preciso reduzir 2 do número de vezes que o loop
    # irá se repetir, ou seja, diminuir 2 do contador, que nesse caso é o enésimo termo informado pelo usuário
    # que está no registrado $s0
    addi $s0, $s0, -2  # Decrementar o enésimo termo em 2 (ele serve de contador para o loop)
    loop_fibonacci:
        add $s3, $s1, $s2         # Soma os dois termos anteriores e salva o resultado no registrado $s3
        move $s1, $s2             # O penúltimo termo passa a ser o último atual
        move $s2, $s3             # O último termo passa a ser a soma dos dois termos anteiores
        addi $s0, $s0, -1         # Decrementa o enésimo termo em 1 (lembrando, ele serve de contador aqui)
        bgtz $s0, loop_fibonacci  # Se o enésimo termo for maior que 0, repete o loop
  
  ## Criando a função que finalizará a sequência de fibonacci
  fim_fibonacci:
  
    la $a0, saida_resultado #Salva o valor da saida_resultado em $a0
    jal imprimeTexto #Imprime o texto da saida_resultado
    
    # O enésimo termo  está em $s2
    move $a0, $s2 # Move o valor de $s2 para $a0
    jal imprimeInteiro # Imprime o valor 
    
    jal quebraLinha # Pular linha
    
    j while # Volta para o menu 
   

  ## Criando a função que irá calcular o enésimo número par
  enesimo_par:
    ## Nessa função é calculado o enésimo número par a partir de um valor informado pelo usuário
    
    ## Pega enésimo termo do usuário
    jal leInteiro
    move $s0, $v0  # Salva o valor do enésimo termo em $s0

    # Para pegar o enésimo número par, basta multiplicar a sua posição por 2
    li $s1, 2       # Atribui o valor 2 ao registrador $s1
    mult $s0, $s1   # Multiplica o enésimo termo por 2
    mflo $s0        # Salva o resultado da multiplicação em $s0

    # O enésimo número par está em $s0
    move $a0, $s0 # Move o valor de $s0 para $a0
    jal imprimeInteiro # Imprime o valor que está em $a0
    
    jal quebraLinha # Pula linha
    
    j while # Volta para o menu principal

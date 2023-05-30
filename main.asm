.data
  menu: .asciiz "1 - Fahrenheit - > Celsius\n2 - Fibonnacci\n3 - Enesimo par\n4 - Sair\n \n"
  paramentro_sub_fahrenheit: .float 32
  paramentro_div_fahrenheit: .float 1.8
  
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
    
   ## Lê a temperatura em Fahrenheit do usuário
   jal leFloat

    ## Aplicando a fórmula para converter o valor em Fahrenheit para Célcius
    lwc1 $f1, paramentro_sub_fahrenheit  # Atribui o valor de paramentro_sub_fahrenheit(32) ao registrador $f1  
    sub.s $f0, $f0, $f1       # Subtrai 32 do valor em Fahrenheit informado pelo usuario e salva em $f0
    lwc1 $f1, paramentro_div_fahrenheit # Atribui o valor de paramentro_div_fahrenheit(1.8) ao registrador $f1
    div.s $f0, $f0, $f1          # Divide o valor em $f0 por 1.8
   
    mov.s $f12, $f0 # Move o valor de $f0 para $f12
    
    # A temperatura em Celsius está em $f12
    jal imprimeFloat #Imprime o valor
    
    jal quebraLinha #Pular linha

    j while #Volta ao menu principal
  
  
  ## Criando a função para calcular o enésimo termo da sequência de Fibonacci
  fibonacci:
   

  ## Criando a função que irá calcular o enésimo número par
  enesimo_par:

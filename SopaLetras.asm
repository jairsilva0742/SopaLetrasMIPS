	.text
	.globl main

main:
	#Se Abre Archivo con SysCall
	li   $v0, 13       # Codigo para Abrir Archivo de System Call
	la   $a0, fin      # Se pone la dirección del archivo
	li   $a1, 0        
	syscall            # Se abre Archivo
	move $s6, $v0      # Descriptor de archivo se mueve a otra posición para dejar a V0 libre 

	#Leer de Archivo
	li   $v0, 14       # Codigo para Leer de Archivo de System Call
	move $a0, $s6      # Se mueve a $a0 descriptor de archivo 
	la   $a1, buffer   # La dirección del buffer que lee
	li   $a2, 8192     # se pone el tamaño en bytes requeridos
	syscall            # Se Lee archivo

	# Se imprime texto de archivo 
	li   $v0, 4       # Codigo para Imprimir en Consola de System Call
	la $a0, buffer    # Se trae la información del Buffer
	syscall           # Se imprime Texto leído del archivo

	# Se cierra e archivo
	li   $v0, 16      # Codigo para Cerrar de Archivo de System Call
	move $a0, $s6     # El archivo se mueve a $ao de acuerdo a requerimiento
	syscall           # Se cierra Archivo
	
    	# Mensaje para ingreso de palabra
    	li $v0, 4
   	la $a0, msj1
    	syscall

    	# Lectura de String
    	li $v0, 8
    	la $a0, input
    	la $a1, 50
    	syscall
	
	# Inicio de Busqueda de Palabra
	la $s2, buffer #Se pone el Buffer en $S2



Loop:	
	la $t3,input #La dirección de la palabra clave en $t3
	lbu $s4, 0($s2) 	#Cargo la primera letra encontrada de la sopa de letras en $s4
	lbu $s5, 0($t3)	 #Cargo la primera letra de la palabra en $s5
	beq $s4,0x20,end 	#comparo $s4 con el espacio, si es espacio el programa va a la etiqueta end
	beq $s4,$s5,Loop2 	#comparo $s4 con $s5, si son iguales la primera letra de la sopa de 
				#letras es igual a la primera de la palabra buscada y me dirijo al loop2
	beq $s4,$zero, end_loop #comparo $s4 con el vacío, si hay vacío salgo del loop iterativo
	beq $s4,0x0d, end 	#comparo $s4 con el carro, esto indica que es el final de la sopa de letra y el programa 
				#va a la etiqueta end
	beq $s4,0x0a,end 	#comparo $s4 con el salto de pagina, si hay salto el programa va a la etiqueta end
end:	
	addi $s2, $s2, 1	#Si se pasan todos los condicionales anteriores, entonces se avanza en un byte en la sopa de letras
	j Loop			#Se reinicia el loop iterativo ya que no se ha encontrado la palabra

Loop2:				#Si se ingresa al Loop 2 es por que se encontró la primera letra buscada y se van a buscar las siguientes
	addi $t3,$t3,1		#Se avanza en una posición en $t3, que es donde esta la palabra buscada
	lbu $s4, 2($s2)		#Se carga en $s4 la siguiente letra en la sopa de letras, la cual está a dos posiciones teniendo 
				#en cuenta el espacio
	lbu $s5, 0($t3)		#Se carga en $s5 la siguiente letra de la palabra buscada (ya se había avanzado)
	beq $s5,0x0a, exito	#Cuando se recorra toda la palabra buscada quiere decir que todas las palabras estaban en la sopa de 
				#letras, con lo cual se alcanzó la posicion del vacío, entonces el programa se dirjirá a la exito
	addi $s2,$s2,2		#Se avanza en 2 posiciones en $s2 teniendo en cuenta el espacio, para la siguiente evaluación
	beq $s4,$s5,Loop2	#Si las letras que estan en $s4 y $s5 son iguales, se evaluan las siguientes letras por lo cual se regresa
				#al inicio del Loop2
	j Loop		#A este punto se llega sin pasar por el Loop2 y es la terminación cuando no se haya la letra

exito:
	li $v0, 4
	la $a0, msj
	syscall
end_loop:
	#la $t3,palabraClave #La dirección de la palabra clave en $t3
	#addi $s6,$zero,0
#invertir_palabra:

	#lbu $s7,0($t3)
	#beq $s7,$zero, encolar
	#addi $t3,$t3,1
	#add $s6,$s6,1
	#j invertir_palabra
#encolar:
	#subi $t3,$t3,1
	#lbu $s3,0($t3)

 	
.data  
fin: .asciiz "SopaLetras.txt"      # Dirección de archivo plano
.align 2
buffer: .space 6000              # tamaño del buffer que lee texto
.align 2
palabraClave: .asciiz "ARQUIT"
.align 2
msj: .ascii "La Palabra se ha encontrado"
.align 2
msj1: .asciiz "Por favor escriba alguna palabra que desee buscar: "
.align 2
input:       .space 10

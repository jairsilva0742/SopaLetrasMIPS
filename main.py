import math
f=open('SopaLetras.txt','r')
sopa=f.read()
print(sopa)
s=input("Digite la palabra a ingresar")

def encontrarPalabra(letra,s):
    match=0
    for b in range(len(s)):
        if letra[b]==s[b]: #si cada una de las palabras
            match=match+1
    return match
def organizarVertical(sopa,s):
    letra=[]
    for a in range(len(s)):
            j=r+(100*a)
            letra.append(sopa[j])# agrego las palabras en horizontal, teniendo en ce
    return letra

def organizarHorizontal(sopa,s):
    letra=[]
    for a in range(len(s)):
        j=r+(2*a)
        letra.append(sopa[j])
    return letra

def posicionHorizontal(r,s):
    fila=math.ceil(r/100)
    inicial=((r+2)/2)-((fila-1)*50)
    final=((r+(len(s)-1)*2)/2)-((fila-1)*50)
    datos=[inicial,final,fila]
    return datos

def posicionVertical(r,s):
    filainf=math.floor(r/100)
    columna=(math.ceil(r-(filainf*100))+2)/2
    inicial=filainf+1
    final=inicial+(len(s)-1)
    datos=[inicial,final,columna]
    return datos

def busquedaHorizontal(sopa,r,s):
    letra=organizarHorizontal(sopa,s)
    print(letra)
    z=encontrarPalabra(letra,s)     

    return z
def busquedaVertical(sopa,r,s):
    letraV=organizarVertical(sopa,s)  
    print(letraV)
    z=encontrarPalabra(letraV,s)  

    return z
    

letra=[]
for r in range(len(sopa)):#LONGITUD
    letra.append(sopa[r])
    
    if letra[0]==s[0]: #Encuentro que case la primera letra
        z=busquedaVertical(sopa,r,s)
   
        print(z)
        if z==len(s):
            posicion=posicionVertical(r,s)
            
            print(" se encontró {} entre las posiciones {} y {}, de forma vertical, en la columna {}".format(s,posicion[0],posicion[1],posicion[2]))
            break
        #Busqueda Horizontal
        z=busquedaHorizontal(sopa,r,s)
        
        if z==len(s):
            posicion=posicionHorizontal(r,s)

            print(" se encontró {} entre las posiciones {} y {}, de forma horizontal, en la fila {}".format(s,posicion[0],posicion[1],posicion[2]))
            break
        
    
    if letra[0]==s[len(s)-1]:
        sinv=s[::-1]
        z=busquedaVertical(sopa,r,sinv)
   
        print(z)
        if z==len(s):
            posicion=posicionVertical(r,sinv)
            
            print(" se encontró {} entre las posiciones {} y {}, de forma vertical, en la columna {}".format(s,posicion[0],posicion[1],posicion[2]))
            break
        #Busqueda Horizontal
        z=busquedaHorizontal(sopa,r,sinv)
        
        if z==len(s):
            posicion=posicionHorizontal(r,sinv)

            print(" se encontró {} entre las posiciones {} y {}, de forma horizontal, en la fila {}".format(s,posicion[0],posicion[1],posicion[2]))
            break
        
        
    letra=[]    

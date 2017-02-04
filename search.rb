$reservadas ={
  'reservada_number'  	   =>  /\Anumber\b/                   ,
  'reservada_repeat'  	   =>  /\Arepeat\b/                   ,
  'reservada_times' 	     =>  /\Atimes\b/                    ,
  'reservada_func'         =>  /\Afunc\b/                     ,
  'reservada_write' 	     =>  /\Awrite\b/                    ,
  'reservada_with' 		     =>  /\Awith\b/                     ,
  'reservada_from'  	     =>  /\Afrom\b/                     ,
  'reservada_to'  		     =>  /\Ato\b/                       ,
  'reservada_program'      =>  /\Aprogram\b/              	  ,
  'reservada_true'         =>  /\Atrue\b/	                	  ,
  'reservada_false'        =>  /\Afalse\b/                    ,
  'reservada_if'           =>  /\Aif\b/                       ,
  'reservada_else'         =>  /\Aelse\b/                     ,
  'reservada_do'           =>  /\Ado\b/                    	  ,
  'reservada_for'          =>  /\Afor\b/                      ,
  'reservada_then'         =>  /\Athen\b/                     ,
  'reservada_begin'        =>  /\Abegin\b/                    ,
  


}


$tokens = {

  'Caracteres'       =>  /\A{[+-<>.,]*}/               ,      
  'Constructor'		   =>  /\A\[[_]*[0-9a-zA-Z_]+\]/     ,
  'Coma'           	 =>  /\A\,/                        ,      
  'Punto'            =>  /\A\./                        ,       
  'Punto y coma'     =>  /\A\;/                        ,       
  'Parentesis abre'  =>  /\A\(/                        ,       
  'Parentesis cierra'=>  /\A\)/                        ,       
  'Corchete abre'    =>  /\A\[/                        ,       
  'Corchete cierra'  =>  /\A\]/                        ,       
  'Llave abre'       =>  /\A\{/                        ,       
  'Llave cierra'     =>  /\A\}/                        ,       
  'Type'           	 =>  /\A\:\:/                      ,       
  'Menos'          	 =>  /\A\-/                        ,      
  'Mas'            	 =>  /\A\+/                        ,      
  'Multiplicacion' 	 =>  /\A\*/                        ,       
  'Division'       	 =>  /\A\/(?![\\=])/               ,       
  'Modulo'         	 =>  /\A\%/                        ,       
  'Conjuncion'     	 =>  /\A\/\\/                      ,       
  'Disyuncion'       =>  /\A\\\//                      ,       
  'Negacion'         =>  /\A\~/                        ,       
  'Menor'            =>  /\A\<(?!=)/                   ,       
  'Menor igual'      =>  /\A\<=/                       ,       
  'Mayor'            =>  /\A\>(?!=)/                   ,       
  'Mayor igual'      =>  /\A\>=/                       , 
  'Desigual'         =>  /\A\!=/              ,       
  'Igual'            =>  /\A\=/                        ,             
  'Concatenacion'    =>  /\A\&/                        ,       
  'Comentario'       =>  /\A\#/                        ,      
  'Asignacion'       =>  /\A\:=/                       ,     
  'Identificador'    =>  /\A[a-zA-Z_][0-9a-zA-Z_]*/    ,   
  'Literal numerico' =>  /\A\d+/                       ,
  'String' 			     =>  /\A"[a-zA-Z_][0-9a-zA-Z_]*"/  ,
}

#Clase en la cual dependiendo del token obtenido
#se tendra su ID a traves del lenguaje regular
class Search
	attr_reader :tokens
	attr_reader :reservadas

  def initialize input
    @input = input
  end

	def lexeme
			#Se busca en las palabras reservadas
	      	$reservadas.each do |x,y|
	      		if @input =~ y
	          		return "Palabra reservada"
	            end
	        end
	        #Se busca en la lista de Tk
	        $tokens.each do |k,v|
		        if @input=~ v
		        	return k
		        end 
	     	end

	       #Si no esta en ninguna lista
	     return "Caracter inesperado"
	 end

  #contador de columnas
  #Ver el indice donde se encuentra la palabra
  #en la linea, sustituir la primera ocurrencia 
  #por tantos espacios como tienen la palabra
  # para no perder columnas
  def columns string
      if string==" "
        return nil," "
      else 
        col= string.index(@input);
        long= @input.length
        spc= " "*long
        new_string=string.sub(@input,spc)
        return col,new_string
      end
  end
end
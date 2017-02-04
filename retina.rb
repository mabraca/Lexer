#! /usr/bin/ruby
# encoding: utf-8
#Nombre: Maria Bracamonte
#Carnet: 10-11147
#Traductores Enero-Marzo 2017
#compilar: ruby retina.rb prueba.rtn

require_relative 'lexer'
require_relative 'search'
def main()
  fila=1
  #Leo cada linea del archivo
  linea = File.foreach(ARGV[0]) do |line|
  #Llamo a la clase en que encontrara los tokens
  @t = Tokenizer::Tokenizer.new(:de)
  entrada = @t.tokenize(line)
  string_line=line
  for i in 0..entrada.length-1
      #Llamo a la clase que clasificara los tokens
      @d = Search.new(entrada[i])
      lexer = @d.lexeme
      columna, string = @d.columns string_line
      if columna==nil
        break 
      end
      columna= columna+1
      string_line= string
      print " linea #{fila}, columna #{columna}: #{lexer} '#{entrada[i]}'\n" 
  end
     fila+=1            #Contador fila
  end  
end

main()
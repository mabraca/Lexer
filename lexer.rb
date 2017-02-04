#! /usr/bin/ruby
# encoding: utf-8
  # Clase principal para el analisis lexicografico
class EliminarEspaciosParaToken
    # separador de espacios por default.
    WHITESPACE_BREAK = Regexp.new('[[:blank:]]+')

    # Se forma una tabla de Pre Post y entre N posicion 
    # en la cual se permite ver en que lugar se hara un
    # split
    PRE_SIGNO1 = ['/','¿','¡']
    POST_SIGNO1 = ['?', ',', ':', ';']
    PRE_SIGNO2 = ['(', '{', '[', '«', '„']
    POST_SIGNO2 = [')', '}', ']', '»', '“']
    PRE_N_POST = [ "'", " "]

    private_constant :WHITESPACE_BREAK

    # Se mergen todos lod datos anteriores de la tabla 
    # que se quiere formar dependiendo de la direccion
    # del signo o lo que puede ser un signo que puede
    # estar como prefijo o sufijo en una palabra
    def initialize(lang = :de, options = {})
      
      @lang = lang
      @options = {
        pre: PRE_SIGNO1 + PRE_SIGNO2,
        post: POST_SIGNO1 + POST_SIGNO2,
        pre_n_post: PRE_N_POST
      }.merge(options)
    end

    # Devuelve un array de tokens
    # Tiene como parametro el string a tokenizar
    def tokenize(str)
      #Se hace split para eliminar todos los espacios en blanco
      tokens = sanitize_input(str).split(WHITESPACE_BREAK) #Tokenizo algunos strings, los basicos
      return [''] if tokens.empty?
      #Se realiza la tabla de los separadores de caracteres
      splittables = PRE_SIGNO1 + POST_SIGNO1 + PRE_SIGNO2 + POST_SIGNO2 + PRE_N_POST #creo una tabla
      #Se indica cuales son las expresiones regulares a separar
      pattern = Regexp.new("[^#{Regexp.escape(splittables.join)}]+") #Simbolos
      output = []
      #Para cada palabra sin espacio en blanco obtenida
      #se hace split si tiene los elementos de la tabla
      #splittables y se anade al array. 
      tokens.each do |token|
        prefix, stem, suffix = token.partition(pattern)
        output << prefix.split('') unless prefix.empty?
        output << stem unless stem.empty?
        output << suffix.split('') unless suffix.empty?
      end
      output.flatten
    end

    alias process tokenize

    private
    
    # Retorna un nuevo string 
    def sanitize_input(str)
      str.chomp.strip 
      # remueve al final del string los \n,\t,\r(chomp) 
      #y remueve los espacios en blanco (strip)
    end
end # class

#Hace llamado a la clase principal con los 
#parametros de entrada
class Tokenizer < EliminarEspaciosParaToken
    def initialize(*args)
      super(*args)
    end
end
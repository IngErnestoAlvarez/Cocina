module Cocina
  VERSION = "1.0.0"

  pasaplato = Channel(String).new
  
  spawn do
    puts "Calentamos el aceite"
  end

  spawn do
    puts "Cortamos las papas"
  end


  puts "Estamos por hacer fibonacci"
  Fiber.yield
  fib(4)
  puts "Hicimos fibonacci"


  spawn do 
    puts "Hacemos las papas"
    while true
      if rand(5)!=4
        pasaplato.send("Papas buenas")
      else
        pasaplato.send("Papas quemadas")
      end
    end
  end
  
  puts "El cliente quiere sus papas"
  papas = pasaplato.receive
  
  begin
    controlar_papas(papas)
  rescue ex : Problema
    puts ex
  ensure
    puts "Hasta luego"
  end
    
end

def controlar_papas(papas : String)
  case papas
  when "Papas buenas"
    puts "Ganamos una estrella Michelin"
  else
    raise Problema.new("Nos quieren cerrar el lugar")
  end
end

def fib(n : Int32)
  case n
  when 2,1
    1
  else
    fib(n-1) + fib(n-2)
  end
end

class Problema < Exception
end
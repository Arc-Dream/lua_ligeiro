
-- LUA LIGEIRO V1.0

-- LUA WEB SERVER CORE CODE BLOCK
    -- BUILD SERVER AND CONNECTION
    -- SERVER PROSEDURE
        -- REQUEST LISTEN SECTION
        -- ROUTER SECTION
        -- VIEWS SECTION



-- BUILD THE SERVER AND CONNECTION

local socket = require "socket"

require "socket.http"
require 'io'

local server = socket.bind('127.0.0.1', 3000)


print("Please telnet to localhost on port 3000")
print("After connecting, you have 10s to enter a line to be echoed")




-- SERVER PROSEDURE

while 1 do

  -- REQUEST LISTEN SECTION
  local client = server:accept()
  client:settimeout(5)
  local line, err = client:receive()

  if line == nil then
    line = 'GET'
  end

  print(line,err)




  -- ROUTER SECTION
  route = "blank"


  if line:sub(1,3) == 'GET' then

    if line:sub(5,6) == '/ ' then
      route = "index"
      print (route)
    elseif line:sub(5,9) == '/home' then
      route = "home"
      print (route)
    elseif line:sub(5,8) == '/css' then
      route = "css"
      print (route)
    elseif line:sub(5,11) == '/script' then
      route = "script"
      print (route)
    elseif line:sub(5,10) == '/image' then
      route = "image"
      print (route)
    else
      route = "index"
      print(route)

  end


  elseif line:sub(1,1) == '' then

    route = "index"
    print(route)

  else

    route = "index"
    print(route)

  end





  -- VIEWS SECTION
  if route == "index" then

    client:send('HTTP/1.1 200 OK \n')
    client:send('Content-Type: text/html\n')
    client:send('Connection: Close\n')
    client:send('Accept: */*\n')
    
    client:send('\n<html><body>')
    client:send('<h1>Buyuk Basarilar Soz Konusu</h1><h3>Lua WEB SERVER</h3>')
    client:send('<h3>Core Lua tabanli web server projesi</h3>')
    
    client:send('<body><html>\n')
    client:close()
    
  end 



  if route == 'home' then
    filename = 'C:\\Users\\ahmet\\Desktop\\try_out\\TRYOUTS\\1_CORE_SERVER\\LUA_CORE_LIGHT\\static\\home.html'
    
    f = assert(io.open(filename, "r"))
    t = f:read("*all")

    t = string.gsub(t, "$var1", "Hola Mundo")
    t = string.gsub(t, "$var2", "Asi es la vida")

    client:send('HTTP/1.1 200 OK \n')
    client:send('Content-Type: text/html\n')
    client:send('Connection: Close\n')
    client:send('Accept: */*\n\n')

    client:send(t)
    client:close()

    f:close()
  
  end

  if route == 'css' then
    filename = 'C:\\Users\\ahmet\\Desktop\\try_out\\TRYOUTS\\1_CORE_SERVER\\LUA_CORE_LIGHT\\static\\style.css'
    
    local f = assert(io.open(filename, "r"))
    local t = f:read("*all")

    client:send('HTTP/1.1 200 OK \n')
    client:send('Content-Type: text/css\n')
    client:send('Connection: Close\n')
    client:send('Accept: */*\n\n')

    client:send(t)
    client:close()

    f:close()
  
  end

  if route == 'script' then
    filename = 'C:\\Users\\ahmet\\Desktop\\try_out\\TRYOUTS\\1_CORE_SERVER\\LUA_CORE_LIGHT\\static\\script.js'
    
    local f = assert(io.open(filename, "r"))
    local t = f:read("*all")

    client:send('HTTP/1.1 200 OK \n')
    client:send('Content-Type: text/javascript\n')
    client:send('Connection: Close\n')
    client:send('Accept: */*\n\n')

    client:send(t)
    client:close()

    f:close()
  
  end
  
  if route == 'image' then
    filename = 'C:\\Users\\ahmet\\Desktop\\try_out\\TRYOUTS\\1_CORE_SERVER\\LUA_CORE_LIGHT\\images\\mutsuzluk.png'
    
    local f = assert(io.open(filename, "rb"))
    local t = f:read("*all")

    client:send('HTTP/1.1 200 OK \n')
    client:send('Content-Type: image/png\n')
    client:send('Connection: Close\n')
    client:send('Accept: */*\n\n')

    client:send(t)
    client:close()

    f:close()
  
  end

end
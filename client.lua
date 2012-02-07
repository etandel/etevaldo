local irc = require "socket"

local etevaldo = require'etevaldo'

local function parse_args()
        local server = arg[1] and arg[1]:match('(.-):') or 'irc.freenode.org'
        local port = arg[1] and tonumber(arg[1]:match(':(.+)')) or 6667
        return server, port
end
local server, port = parse_args()

local function log(msg)
    io.stderr:write(msg .. '\n')
end

local client = (function ()
    local err = 'Could not connect to ' .. server .. ' at port ' .. port
    local c = assert(irc.connect(server, port), err) 
    log('Connected to ' .. server .. ' at port ' .. port)
    return c
end)()
client:setoption('keepalive', true)

function send_cmd(cmd)
    local ok, err = client:send(cmd .. '\r\n')
    if ok then
        log('Successfully sent: <' .. cmd .. '>')
    else
        err = 'Connection ' .. err
        log('Could not send <' .. cmd .. '>. Error: ' .. err)
    end
end

function say(msg)
    send_cmd('PRIVMSG ' .. etevaldo.channel .. ' :' .. msg)
end

-- client greetings to server
send_cmd('USER ' .. etevaldo.nick .. etevaldo.initmodes .. ':' .. etevaldo.realname)
send_cmd('NICK ' .. etevaldo.nick)
send_cmd('JOIN ' .. etevaldo.channel)

local function is_ping(str)
    return string.sub(str, 1, 6) == 'PING :'
end

local function kicked(input)
    return input:match('KICK #.- ' .. etevaldo.nick)
end

while true do
    local input = client:receive()
    if input then
        log('Received: <' .. input .. '>')

        if kicked(input) then
            log"Was kicked. Exiting..."
            client:close()
            break
        end
        
        if is_ping(input) then
            send_cmd('PONG : ' .. input:sub(7, -1)) -- gotta also return the info sent with the ping
        end

        local output = etevaldo.exec(input)
        if output then
            say(output)
        end
    end
end


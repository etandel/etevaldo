local client = require "client"
local etevaldo = require'bot'

local function parse_args()
        local server = arg[1] and arg[1]:match('(.-):') or 'irc.freenode.org'
        local port = arg[1] and tonumber(arg[1]:match(':(.+)')) or 6667
        return server, port
end
local server, port = parse_args()

local function log(msg)
    io.stderr:write(msg .. '\n')
end

client:connect(parse_args())

-- client greetings to server
client:send_cmd('USER ' .. etevaldo.nick .. etevaldo.initmodes .. ':' .. etevaldo.realname)
client:send_cmd('NICK ' .. etevaldo.nick)
client:send_cmd('JOIN ' .. etevaldo.channel)

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
            client:send_cmd('PONG : ' .. input:sub(7, -1)) -- gotta also return the info sent with the ping
        end

        etevaldo.exec(client, input)
    end
end


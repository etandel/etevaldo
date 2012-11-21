local irc = require "socket"

local etevaldo = require'bot'

local function log(msg)
    io.stderr:write(msg .. '\n')
end

local client = {}

function client:connect(server, port)
    local err = 'Could not connect to ' .. server .. ' at port ' .. port
    self._connection = assert(irc.connect(server, port), err) 
    self._connection:setoption('keepalive', true)
    log('Connected to ' .. server .. ' at port ' .. port)
end

function client:close()
    self._connection:close()
end

function client:receive()
    return self._connection:receive()
end

function client:send_cmd(cmd)
    local ok, err = self._connection:send(cmd .. '\r\n')
    if ok then
        log('Successfully sent: <'.. cmd..'>')
    else
        err = 'Connection '..err
        log('Could not send <'..cmd..'>. Error: '..err)
    end
end

function client:privmsg(channel, msg)
    self:send_cmd('PRIVMSG ' .. channel .. ' :' .. msg)
end


function client:say(msg)
    self:privmsg(etevaldo.channel, msg)
end

return client

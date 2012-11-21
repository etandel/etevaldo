local etevaldo = {
    nick = 'etevaldo' ,
    realname = 'Etevaldo - A Lua Bot by Elias Barrionovo' ,
    initmodes = ' 0 * ' , --the spaces matter, or else greeting server will fail!
    channel = '#etevaldotst',
    source = 'github.com/etandel/etevaldo' ,
}


scripts = require 'scripts.init'

local function parse_input(str)
    -- Ex: nick!~usr@host PRIVMSG #channel :message
    local sndr, event, rec, msg = str:match'^:([_%a]+)!~[_%a]+@[%d%.]+ (%a-) ([#%a]-) :(.*)'
    local command
    if msg and msg:match('^%s*'..etevaldo.nick..' ') then
        command = msg:match(etevaldo.nick..'%s*(.*)')
    end
    return {
        sender = sndr,
        event = event,
        receiver = rec,
        content = msg,
        command = command,
    }
end

local function dispatch(client, script, in_table)
    local channel
    if in_table.receiver == etevaldo.nick then
        channel = in_table.sender
    else
        channel = in_table.receiver
    end
    client:privmsg(channel, script(etevaldo, in_table))
end

function etevaldo.exec(client, input)
    local in_table = parse_input(input)
    if in_table.event then 
        local script = scripts[in_table.command]
        if script then
            dispatch(client, script, in_table)
        end
    end
end

return etevaldo

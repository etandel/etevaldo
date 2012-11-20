local etevaldo = {
    nick = 'Etevaldo' ,
    realname = 'Etevaldo - A Lua Bot by Elias Barrionovo' ,
    initmodes = ' 0 * ' , --the spaces matter, or else greeting server will fail!
    channel = '#etevaldotst',
    source = 'github.com/etandel/etevaldo' ,
}


etevaldo.scripts = require 'scripts.init'   

local function parse_input(str)
    -- captures: sender, event, receiver, message
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

local function dispatch(script, in_table)
    say(script(etevaldo, in_table))
end

function etevaldo.exec(input)
    local in_table = parse_input(input)
    if in_table.event then 
        local script = etevaldo.scripts[in_table.command]
        if script then
            dispatch(script, in_table)
        end
    end
end

return etevaldo

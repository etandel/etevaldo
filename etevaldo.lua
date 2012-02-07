--[[
    TODO: 
        - Make etevaldo.exec use parse_input
--]]


local etevaldo = {
    nick = 'Etevaldo' ,
    realname = 'Etevaldo - A Lua Bot by Elias Barrionovo' ,
    initmodes = ' 0 * ' , --the spaces matter, or else greeting server will fail!
    channel = '#etevaldotst',
    source = 'github.com/etandel/etevaldo' ,
}

-- the following tables consist of pairs of command names and functions that
    -- execute the commands
local privmsg = {
    etevaldo = function(in_table)
        local msg = in_table.content or ''
        if msg:match'^%s*!etevaldo' then
            local et_defs = {
                'uma visita espacial',
                'um sujeito agradável',
                'um tanto quanto brincalhão',
                'um turista universal' ,
                'o céu é a terra natal ',
                'uma espécie original',
                'um cara legal' ,
            }

            return in_table.sender .. ': Etevaldo, ' .. et_defs[math.random(#et_defs)] .. '.'
        end
    end ,

    source = function(in_table)
        local msg = in_table.content or ''
        if msg:match'^%s*!source' then
            return in_table.sender .. ': My source is located at ' .. etevaldo.source .. ' .'
        end
    end ,

    license = function(in_table)
        local msg = in_table.content or ''
        if msg:match'^%s*!license' then
            return in_table.sender .. ': My license is GPL. For more info, check my source at ' .. etevaldo.source .. ' .'
        end
    end
}

etevaldo.actions = {
    -- Each entry consists of an array of functions that execute the command
    PRIVMSG = privmsg ,
}
   

local function parse_input(str)
    -- captures: sender, event, receiver, message
    local sndr, event, rec, msg = str:match'^:([_%a]+)!~[_%a]+@[%d%.]+ (%a-) ([#%a]-) :(.*)'
    return {
        sender = sndr ,
        event = event ,
        receiver = rec ,
        content = msg ,
    }
end


function etevaldo.exec(input)
    local in_table = parse_input(input)
    if in_table.event then 
        local actions = etevaldo.actions[in_table.event]
        for _, act in pairs(actions) do
            local r = act(in_table)
            if r then
                return r
            end
        end
    end
end

return etevaldo

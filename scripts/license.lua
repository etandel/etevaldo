return function(etevaldo, in_table)
    local command = in_table.command or ''
    if command:match'license' then
        return in_table.sender .. ': My license is GPL. For more info, check my source at ' .. etevaldo.source .. ' .'
    end
end

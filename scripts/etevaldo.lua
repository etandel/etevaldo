local et_defs = {
    'uma visita espacial',
    'um sujeito agradável',
    'um tanto quanto brincalhão',
    'um turista universal' ,
    'o céu é a terra natal ',
    'uma espécie original',
    'um cara legal' ,
}

return function(etevaldo, in_table)
    local command = in_table.command or ''
    if command:match'etevaldo' then
        return in_table.sender .. ': Etevaldo, ' .. et_defs[math.random(#et_defs)] .. '.'
    end
end 

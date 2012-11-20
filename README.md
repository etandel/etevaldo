Etevaldo is an IRC bot written in Lua by Elias Tandel Barrionovo.

1) Instalation
---

Etevaldo runs on [Lua](www.lua.org) version 5.1, though it should probably run on 5.2
(not tested yet). Apart from the interpreter, Etevaldo has only one dependecy: [LuaSocket](http://w3.impa.br/~diego/software/luasocket/),
which is avaliable through [LuaRocks](http://luarocks.org/).  

It means that installing Etevaldo is simply installing Lua 5.1 and LuaSocket. Then, to
run, just do 'lua client.lua' and it should run smoothly.

2) Customization
---

Etevaldo's commands are implemented through scripts located at the 'scripts' directory.
The scripts are single functions that return the message that will be sent to the channel
and  must be registered at the table in scripts/init.lua along with its name (that will be
used to call the script).

For more info, see the existing scripts.

3) Author and License
---

Bugs and comments should be sent to elias.tandel@gmail.com.

>"Copyright (C) 2011 Elias Tandel Barrionovo (elias.tandel@gmail.com)

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA."

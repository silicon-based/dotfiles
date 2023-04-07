local chunkSize = 70
local author = 'aaaaaaaaaaaaaaaaa'
local a = string.rep('ㅤ', (chunkSize - #author - 3) / 2) .. "—— " .. author
print(a)


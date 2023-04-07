local function printTable(t, f)

    local function printTableHelper(obj, cnt)

        local cnt = cnt or 0

        if type(obj) == "table" then

            io.write("\n", string.rep("    ", cnt), "{\n")
            cnt = cnt + 1

            for k,v in pairs(obj) do

                if type(k) == "string" then
                io.write(string.rep("    ",cnt), '["'..k..'"]', ' = ')
                end

                if type(k) == "number" then
                io.write(string.rep("    ",cnt), "["..k.."]", " = ")
                end

                printTableHelper(v, cnt)
                io.write(",\n")
            end

            cnt = cnt-1
            io.write(string.rep("    ", cnt), "}")

        elseif type(obj) == "string" then
            io.write(string.format("%q", obj))

        else
            io.write(tostring(obj))
        end
    end

    if f == nil then
        printTableHelper(t)
    else
        local file = io.open(f, 'w')
        assert(file ~= nil)
        file:close()
        io.output(f)
        io.write("return")
        printTableHelper(t)
        io.output(io.stdout)
    end
end

local quotes = {}
for line in io.lines(os.getenv("HOME") .. "/.config/nvim/data/quotes.csv") do
        local _, quote, author = line:match("^(.-),'?(“.*”)'?,'?(.-)'?\r$")
        quotes[#quotes+1] = {quote = quote, author = author}
end
printTable(quotes, os.getenv("HOME") .. '/.config/nvim/lua/plugin-config/quotes.lua')

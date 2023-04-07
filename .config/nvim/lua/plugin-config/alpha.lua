local lfs = require'lfs'

local if_nil = vim.F.if_nil

local default_header = {
    type = "text",
    val = {
[[]],
[[]],
[[███▄▄▄▄      ▄████████  ▄██████▄   ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄   ]],
[[███▀▀▀██▄   ███    ███ ███    ███ ███    ███ ███  ▄██▀▀▀███▀▀▀██▄ ]],
[[███   ███   ███    █▀  ███    ███ ███    ███ ███▌ ███   ███   ███ ]],
[[███   ███  ▄███▄▄▄     ███    ███ ███    ███ ███▌ ███   ███   ███ ]],
[[███   ███ ▀▀███▀▀▀     ███    ███ ███    ███ ███▌ ███   ███   ███ ]],
[[███   ███   ███    █▄  ███    ███ ███    ███ ███  ███   ███   ███ ]],
[[███   ███   ███    ███ ███    ███ ███    ███ ███  ███   ███   ███ ]],
[[ ▀█   █▀    ██████████  ▀██████▀   ▀██████▀  █▀    ▀█   ███   █▀  ]],

    },
    opts = {
        position = "center",
        hl = "Type",
        wrap = "overflow";
    },
}

local function get_quote()
    local status, _ = pcall(require, "plugin-config.quotes")
    if not (status) then
        require("utils.generate_lua_database")
    end
    local quotes = require"plugin-config.quotes"
    local index = math.random(#quotes)
    return quotes[index]
end

local function manipulate_quote(qt)
    qt['quote'] = qt['quote']:gsub("^\'*(.-)\'*$", "%1"):gsub("\\n", "\n")
    qt['author'] = qt['author']:gsub("^\'*(.-)\'*$", "%1")
    local s = qt['quote']
    local author = qt['author']:gsub("[\n\r]", "")
    local chunkSize = 66
    local t = {}

    local buffer = ""
    for w in s:gmatch("%S+") do
        buffer = buffer .. w .. " "
        if #buffer >= chunkSize then
            t[#t+1] = buffer
            buffer = ""
        end
    end
    if buffer == "" then
        t[#t+1] = buffer
    else
        t[#t+1] = buffer
        t[#t+1] = ""
    end

    local a = string.rep('ㅤ', (chunkSize - #author) / 2) .. "—— " .. author
    t[#t+1] = a
    return t
end

local footer = {
    type = "text",
    val = manipulate_quote(get_quote()),
    opts = {
        position = "center",
        hl = "Exception",
        wrap = "overflow";
    },
}

local function count_plugins()
    local count = 0
    for _ in lfs.dir(os.getenv('HOME') .. '/.local/share/nvim/site/pack/packer/start') do
        count = count + 1
    end
    return count
end

local function get_version()
    local version_table = vim.version()
    local dev = version_table.prerelease
    local result = tostring(version_table.major) .. "." .. tostring(version_table.minor) .. "." .. tostring(version_table.patch)
    if dev then
        result = result .. "-dev"
    end
    return result
end


local info = {
    type = "text",
    val = " Version " .. get_version() .. "   " .. " Installed " .. tostring(count_plugins()) .. " plugins",
    opts = {
        position = "center",
        hl = "Special",
        wrap = "overflow"
    },
}

local leader = "SPC"

--- @param sc string
--- @param txt string
--- @param keybind string? optional
--- @param keybind_opts table? optional
local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

    local opts = {
        position = "center",
        shortcut = sc,
        cursor = 5,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "Keyword",
    }
    if keybind then
        keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "t", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local buttons = {
    type = "group",
    val = {
        button("e", "  New file", "<cmd>ene <CR>"),
        button("F", "  Find file"),
        button("T", "  Recently opened files"),
        -- button("SPC f r", "  Frecency/MRU"),
        button("Y", "  Find word"),
        button("q", "ﰌ  Exit Neovim", ":qa <CR>"),
        -- button("SPC f m", "  Jump to bookmarks"),
        -- button("SPC s l", "  Open last session"),
    },
    opts = {
        spacing = 1,
    },
}

local section = {
    info = info,
    header = default_header,
    buttons = buttons,
    footer = footer,
}

local config = {
    layout = {
        { type = "padding", val = 3 },
        section.header,
        { type = "padding", val = 3 },
        section.info,
        { type = "padding", val = 2 },
        section.buttons,
        { type = "padding", val = 2 },
        section.footer,
    },
    opts = {
        margin = 5,
    },
}

return {
    button = button,
    section = section,
    config = config,
    -- theme config
    leader = leader,
    -- deprecated
    opts = config,
}

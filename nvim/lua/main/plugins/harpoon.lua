return {
    "ThePrimeagen/harpoon",
    lazy = false,
    branch = "harpoon2",
    init = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<leader>d", function() harpoon:list():remove() end)

        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                local file_path = item.value
                if not vim.fn.fnamemodify(file_path, ':p'):find('^/') then
                    file_path = vim.fn.fnamemodify(file_path, ':p')
                end

                local entry = {
                    path = file_path,
                    lnum = item.context and item.context.row or 1,
                }
                table.insert(file_paths, entry)
            end

            local telescope_theme = require("telescope.themes").get_dropdown({})

            require("telescope.pickers").new(telescope_theme, {
                prompt_title = "Harpoon",
                finder = require("telescope.finders").new_table({
                    results = file_paths,
                    entry_maker = function(entry)
                        local filename = vim.fn.fnamemodify(entry.path, ':t')
                        local icon, icon_hl = require("nvim-web-devicons").get_icon(filename,
                            vim.fn.fnamemodify(entry.path, ':e'), { default = true })

                        return {
                            value = entry.path,
                            display = function(entry_table)
                                local display_text = string.format("%s %s:%d",
                                    icon, filename, entry.lnum)
                                return display_text, { { { 0, #icon }, icon_hl } }
                            end,
                            ordinal = entry.path,
                            filename = entry.path,
                            lnum = entry.lnum,
                        }
                    end
                }),
                previewer = conf.grep_previewer({}),
                sorter = conf.generic_sorter({}),
            }):find()
        end

        vim.keymap.set("n", "<leader>fh", function() toggle_telescope(harpoon:list()) end,
            { noremap = true, desc = "Open harpoon window" })
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
}

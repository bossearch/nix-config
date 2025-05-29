# Image paste handler
# Inspired by: https://github.com/linkarzu/dotfiles-latest
# Author of reference: @linkarzu
# Adapted and customized by me.
{
  programs.nixvim.extraConfigLua = ''
    local format = "avif" -- avif,webp,png,jpg
    local quality = 75
    -- Determine Git-aware image storage path
    local function get_image_storage_path()
      local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
      if vim.v.shell_error ~= 0 or not root or root == "" then
        return vim.fn.expand("~/Pictures")
      end

      local repo_name = vim.fn.fnamemodify(root, ":t")

      local repo_paths = {
        [".dotfiles"] = root .. "/configs/nvim/lua/core/img",
        ["test2"] = root .. "/assets/img",
      }

      return repo_paths[repo_name] or vim.fn.expand("~/Pictures")
    end

    local function paste_image(opts)
      return require("img-clip").paste_image(vim.tbl_extend("force", {
        use_absolute_path = false,
        relative_to_current_file = false,
        extension = format,
        process_cmd = string.format("convert - -quality %d %s:-", quality, format),
        filetypes = {
          markdown = {
            url_encode_path = true,
            template = "![$FILE_NAME]($FILE_PATH)",
          },
        },
        prompt_for_file_name = false,
      }, opts or {}))
    end

    local function handle_image_paste(img_dir)
      -- Use a scratch buffer to prevent output from paste_image
      local original_buf = vim.api.nvim_get_current_buf()
      local scratch_buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_set_current_buf(scratch_buf)

      local temp_path = vim.fn.tempname() .. "." .. format

      local image_pasted = paste_image({
        dir_path = vim.fn.fnamemodify(temp_path, ":h"),
        file_name = vim.fn.fnamemodify(temp_path, ":t:r"),
      })

      vim.fn.delete(temp_path)
      vim.api.nvim_set_current_buf(original_buf)
      vim.api.nvim_buf_delete(scratch_buf, { force = true })
      vim.defer_fn(function()
        if image_pasted then
          -- Prompt for real filename and paste into correct dir
          local prefix = vim.fn.strftime("%y%m%d-")
          vim.ui.input({ prompt = "Enter image name (no spaces). Added prefix: " .. prefix }, function(input)
            if not input or input:match("%s") then
              print("Invalid image name or canceled.")
              return
            end

            local full_name = prefix .. input
            local full_path = img_dir .. "/" .. full_name .. "." .. format

            if vim.fn.filereadable(full_path) == 1 then
              print("Image already exists. Try again.")
              handle_image_paste(img_dir)
              return
            end

            if paste_image({ dir_path = img_dir, file_name = full_name }) then
              vim.cmd("normal! kddo")
              vim.cmd("stopinsert")
            else
              print("Image paste failed.")
            end
          end)
        else
          -- Not an image: fallback markdown snippet
          vim.api.nvim_put({ "![Image](" .. img_dir .. "/)" }, "c", true, true)
          vim.api.nvim_feedkeys("i", "n", true)
        end
      end, 100)
    end

    local function process_image()
      local img_dir = get_image_storage_path()

      if vim.fn.isdirectory(img_dir) == 0 then
        vim.ui.select({ "yes", "no" }, {
          prompt = img_dir .. " does not exist. Create it?",
          default = "yes",
        }, function(choice)
          if choice == "yes" then
            vim.fn.mkdir(img_dir, "p")
            vim.defer_vim.fn(function()
              handle_image_paste(img_dir)
            end, 100)
          else
            print("Operation cancelled - directory not created")
          end
        end)
      else
        handle_image_paste(img_dir)
      end
    end

    -- Keybinding to trigger
    vim.keymap.set("n", "<leader>mi", process_image, { desc = "Insert Image" })
    -- add markdown toc macro
    vim.keymap.set("n", "<leader>mt", function()
      vim.api.nvim_put({ "<!-- toc -->" }, "l", true, true)
    end, { desc = "Insert Markdown TOC" })
    -- remove image file undercursor
    vim.keymap.set("n", "<leader>id", function()
      local function get_image_path()
        local line = vim.api.nvim_get_current_line()
        local image_pattern = "%[.-%]%((.-)%)"
        local _, _, image_path = string.find(line, image_pattern)
        return image_path
      end

      local image_path = get_image_path()
      if not image_path then
        vim.notify("No image found under the cursor", vim.log.levels.WARN)
        return
      end

      if vim.fn.filereadable(image_path) == 0 then
        vim.notify("Image file does not exist:\n" .. image_path, vim.log.levels.ERROR)
        return
      end

      local success, _ = pcall(function()
        vim.fn.system({ "rm", vim.fn.fnameescape(image_path) })
      end)

      if success and vim.fn.filereadable(image_path) == 0 then
        vim.notify("Image file deleted:\n" .. image_path, vim.log.levels.INFO)
        vim.cmd("edit!")          -- Reload buffer to reflect deletion
        vim.cmd("normal! dd")     -- Delete the current line (Markdown image reference)
      else
        vim.notify("Failed to delete image file:\n" .. image_path, vim.log.levels.ERROR)
      end
    end, { desc = "Delete Image" })
  '';
}

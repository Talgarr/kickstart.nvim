local model_names = {
  'claude-3.5-sonnet',
  'claude-3.7-sonnet',
  'claude-3.7-sonnet-thought',
  'claude-sonnet-4',
  'gemini-2.0-flash-001',
  'gemini-2.5-pro',
  'gpt-4.1',
  'gpt-4o-2024-11-20',
  'o1',
  'o3-mini',
  'o4-mini',
}

return {
  'yetone/avante.nvim',
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = function()
    -- conditionally use the correct build system for the current OS
    if vim.fn.has 'win32' == 1 then
      return 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
    else
      return 'make'
    end
  end,
  event = 'VeryLazy',
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- add any opts here
    -- for example
    mode = 'agentic',
    provider = 'copilot-gemini-2.0-flash-001',
    providers = (function()
      local providers_table = {
        copilot = {
          endpoint = 'https://api.githubcopilot.com',
          allow_insecure = false,
          timeout = 10 * 60 * 1000,
          extra_request_body = {
            temperature = 0,
            max_completion_tokens = 1000000,
            reasoning_effort = 'high',
          },
        },
      }
      for _, model_name in ipairs(model_names) do
        local provider_key = 'copilot-' .. model_name
        providers_table[provider_key] = {
          __inherited_from = 'copilot',
          model = model_name,
          display_name = provider_key,
        }
      end

      return providers_table
    end)(),
    --
    -- system_prompt as function ensures LLM always has latest MCP server state
    -- This is evaluated for every message, even in existing chats
    system_prompt = function()
      local hub = require('mcphub').get_hub_instance()
      return hub and hub:get_active_servers_prompt() or ''
    end,
    -- Using function prevents requiring mcphub before it's loaded
    custom_tools = function()
      return {
        require('mcphub.extensions.avante').mcp_tool(),
      }
    end,
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    --- The below dependencies are optional,
    'echasnovski/mini.pick', -- for file_selector provider mini.pick
    'nvim-telescope/telescope.nvim', -- for file_selector provider telescope
    'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
    'ibhagwan/fzf-lua', -- for file_selector provider fzf
    'stevearc/dressing.nvim', -- for input provider dressing
    'folke/snacks.nvim', -- for input provider snacks
    'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
    'zbirenbaum/copilot.lua', -- for providers='copilot'
    {
      -- support for image pasting
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}

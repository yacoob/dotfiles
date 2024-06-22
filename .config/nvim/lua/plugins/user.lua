if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder

return {
  -- not sure yet whether I want to keep using gruvbox or go with Astro's default...
  {
    'ellisonleao/gruvbox.nvim',
    opts = {
      invert_intend_guides = false,
      contrast = 'hard',
    }
  },
}

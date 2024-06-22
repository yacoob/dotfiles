return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      autocmds = {
        yacoob = {
          {
            event = {'BufWritePre'},
            desc = 'Strip trailing whitespace on save',
            command = ':%s/\\s\\+$//e',
          },
        },
      },
      options = {
        opt = {
          -- -- whitespace
          list = true,                        -- highlight some special characters
          listchars = {tab= '| ', trail='·', extends='»', precedes='«'},
          -- searching
          gdefault = true,                    -- g flag by default for :s
          matchpairs = '[:],(:),{:},<:>',     -- add < and > to list of matching brackets
          showmatch = true,                   -- flash matching bracket
          -- ui
          guifont = 'FiraCode Nerd Font:h14',
          scrolloff = 14,                     -- leave this amount of lines while scrolling up/down
          -- behavioral
          autowrite = true,                   -- auto-write file before certain operations
          keymodel = 'startsel',              -- shift+special key = selection
        },
        g = {
          loaded_perl_provider = 0,
          loaded_python3_provider = 0,
          loaded_ruby_provider = 0,
          loaded_node_provider = 0,
        },
      },
      mappings = {
        c = {
          -- forgot your sudo?
          ['w!!'] = {'w !sudo tee % >/dev/null', desc='sudo write :3'}
        },
        i = {
          -- disable arrows
          ['<up>'] = {'<nop>'},
          ['<down>'] = {'<nop>'},
          ['<left>'] = {'<nop>'},
          ['<right>'] = {'<nop>'},
        },
        ia = {
          -- abbreviations
          ['---'] = {'—'},
          ['dts'] = {'strftime("%Y-%m-%d")', expr=true},
        },
        n = {
          -- disable arrows
          ['<up>'] = {'<nop>'},
          ['<down>'] = {'<nop>'},
          ['<left>'] = {'<nop>'},
          ['<right>'] = {'<nop>'},
          -- disable couple of AstroNvim's default keybindings
          ['<Leader>c'] = {'<nop>'},
          ['<Leader>C'] = {'<nop>'},
          ['<Leader>q'] = {'<nop>'},
          ['<Leader>Q'] = {'<nop>'},
          -- move by screen lines
          ['j'] = {'gj'},
          ['k'] = {'gk'},
          -- moving whole lines
          ['<C-k>'] = {'ddkP'},
          ['<C-j>'] = {'ddp'},
          -- better tab
          ['<tab>'] = {'v>'},
          ['<s-tab>'] = {'v<'},
          -- keep search matches in the middle of the window
          ['n'] = {'nzzzv'},
          ['N'] = {'Nzzzv'},
          -- my convenience shortcuts
          ['<Leader>Y'] = {name = 'yacoob shortcuts'},
          ['<Leader>Yc'] = {':cd %:p:h<CR>:pwd<CR>', desc='cd to current file\'s path'},
          ['<Leader>Yr'] = {':n $MYVIMRC<CR>:cd %:p:h<CR>', desc='edit main rc file'},
        },
        s = {
          -- no yank on paste
          ['p'] = {'pgvy'},
        },
        v = {
          -- moving whole lines
          ['<C-k>'] = {'xkP`[V`'},
          ['<C-j>'] = {'xp`[V`]'},
          -- better tab
          ['<tab>'] = {'>gv'},
          ['<s-tab>'] = {'<gv'},
          -- no yank on paste
          ['p'] = {'pgvy'},
        }
      },
    },
  },
}

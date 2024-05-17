# `nmux` => `neovim` + `tmux` its awesome

> Just an enthusiast trying to become a better "_vimmer_"

## Index
* [Pre-requisites](#prerequisites)
* [:warning:](#fyi)
* [Fuzzy finder](#ripgrep)
* [vim-dad-bod](#db)
* [tmux](#terminal-multipFLEXer)

### Prerequisites

For you to use `neovim` you need [this](https://github.com/neovim/neovim), now I
always suggest installing from `source` rather than opting `package-manager` to do for ourself.

```bash
$ nvim --version
```

Once `neovim` is installed we require [`Packer`](https://github.com/wbthomason/packer.nvim) which helps
us handle all the external plugins at ease

Install it will help you proceed further with `config` & setup

Once `packer` is installed we are now ready and we can start `neovim`, _but_ before that we
need to _configure_ `neovim` and then
> _wooooopaaahhhhhhhhhhh! we are ready_
![chandler-woopahhh](https://tenor.com/bVOnw.gif)

Now `clone` [repo](https://github.com/VigneshwaranJheyaraman/nmux)

```bash
$ cd ~
$ git clone git@github.com/VigneshwaranJheyaraman:nmux ./config 
```

Once the repository is cloned. The `config` is already in place kindly start `nvim`

```bash
$ nvim $WORK_DIRECTORY
```

### FYI
I have disabled all the `arrow` keys and only making use of
1. `H <-`
2. `L ->`
3. `K ↑`
4. `J ↓`

### Ripgrep

`neovim` is supported by `telescope` which is an awesome [plugin](https://github.com/nvim-telescope/telescope.nvim) which
helps us `fuzzy-finding` at faster rate but lot of helpful `commands`

I believe `vim` is the way of each and every individual trying to do the same task with different
approach [_motions_] which gives us `PDE` _personalized development environment_. So better start with [`vim motion`](https://neovim.io/doc/user/motion.html)

So I have personally found `grep` really useful apart for `file-finder`. So since `grep` is quite slower for larger `directory-tree`.
I tried out `git-grep` which acutally responds fine but we need to make sure `.git` is available for it. So found [ripgrep](https://github.com/BurntSushi/ripgrep)
which is really awesome with finding given the `phrase`

Every command inside `~/.config/nvim/lua/vickysuraj/mapper.lua` follows a specific standard in naming the `key-mapping`
I always consider the first `character` of the task which I intend to achieve. For instance `<leader>ff` helps us to **F**ind **F**iles using `telescope`.

### DB
:warning: **Requires `postgresql` install on your machine**
Added support to viewing `db` related querying from `neovim`. For security purpose, DB setup supports exporting DB related information as `env`
variable
```bash
$ export DB_<name>=<DB_TYPE>://<USER>:<PASSWORD>@<HOST>:<PORT>/<DB_NAME>
```

### Terminal Multi_FLEX_er

[tmux](https://github.com/tmux/tmux/wiki) this is really awesome and helpful in handling all different projects
working at the same time with _Blazingly fast_ jumps and DX. I personally made some `mapping` for myself and accumulated inside `.tmux.conf`
which can be stored inside `~/.tmux.conf` or `symbolic link` to use the same

> Live long and prosper :vulcan_salute:

# `nmux` => `neovim` + `tmux` its awesome

> Just an enthusiast trying to become a better "_vimmer_"

## Index
* [Easy setup](#easy-setup)
* [Pre-requisites](#prerequisites)
  * [What is `lazy.nvim`](#lazy-nvim)
  * [Out of the box features](#features)
* [:warning:](#fyi)
* [Fuzzy finder](#ripgrep)
* [vim-dad-bod](#db)
* [clojure + repl](#clojure-and-repl)
* [tmux](#terminal-multipFLEXer)

### Prerequisites

For you to use `neovim` you need [this](https://github.com/neovim/neovim), now I
always suggest installing from `source` rather than opting `package-manager` to do for ourself.

```shell
$ nvim --version
```

Once `neovim` is installed we require [`Lazy.nvim`](https://github.com/folke/lazy.nvim) which helps
us handle all the external plugins at ease and also lazy

Make sure your `terminal` supports `Nerdfont` for nice devX [check here](https://www.nerdfonts.com/)

```shell
make install-fonts 
```

#### Lazynvim

`lazy.nvim` is a `neo-vim`'s plugin manager which handles the plugins and supports lazy requiring thereby
not loading all stuff on `nvim-open`. Also unlike `packer` which stores the `plugins` inside the `nvim-directory` and uses them
`lazy.nvim` will add the `plugins` to the `vim.standardPath` (_like classpath for java_)
which has the plugins loaded we configured. Also `lazy.nvim` will allow isolation of
plugins given their `install-configuration`. its awesome check it out!!!!

#### Features
* markdown-rendered
* Language-Server for set of `programming-languages`. You can find the [here](https://github.com/VigneshwaranJheyaraman/nmux/blob/master/lua/vickysuraj/utils/)
* Oil tree better than `NerdTree` and behaves more `neovimyyyyy`
* added logic for `floating` terminal
* more mapping + statusline

Install it will help you proceed further with `config` & setup

Once `packer` is installed we are now ready and we can start `neovim`, _but_ before that we
need to _configure_ `neovim` and then
> _wooooopaaahhhhhhhhhhh! we are ready_
![chandler-woopahhh](https://tenor.com/bVOnw.gif)

Now `clone` [repo](https://github.com/VigneshwaranJheyaraman/nmux)

```shell
$ cd ~
$ git clone git@github.com/VigneshwaranJheyaraman:nmux ./config 
```

Once the repository is cloned. The `config` is already in place kindly start `nvim`

```shell
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
 
```shell
$ export DB_<name>=<DB_TYPE>://<USER>:<PASSWORD>@<HOST>:<PORT>/<DB_NAME>
```

### Terminal Multi_FLEX_er

[tmux](https://github.com/tmux/tmux/wiki) this is really awesome and helpful in handling all different projects
working at the same time with _Blazingly fast_ jumps and DX. I personally made some `mapping` for myself and accumulated inside `.tmux.conf`
which can be stored inside `~/.tmux.conf` or `symbolic link` to use the same

> Live long and prosper :vulcan_salute:

### Easy setup

To ease out the setup process, introduced `makefile` and for

#### Macintosh

Kindly change the variable called `package_manager` in `Makefile` to `brew` from `apt`, then run

```shell
make setup
```

#### Linux

Just run

```shell
make setup
```

### Clojure and REPL

REPL (Read Eval Print Loop), personally I am big of fan of it and given the immutable nature
of `clojure` which I currently program with. the support for the same has been added here

```shell
make setup-clojure-config
```

alias sed=gsed

####### ZGEN

source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/gitignore
    zgen oh-my-zsh plugins/brew
    zgen oh-my-zsh plugins/compleat
    zgen oh-my-zsh plugins/osx
    zgen oh-my-zsh plugins/vi-mode
    zgen load Tarrasch/zsh-autoenv
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load bhilburn/powerlevel9k powerlevel9k
    zgen save
fi

how_colours() {
  for code ({000..255}) print -P -- "$code: %F{$code} First this %K{black} And this %K{white} And this %k%f%K{$code}%F{black} And this %F{white} And this %f%k"
}

POWERLEVEL9K_PROMPT_ON_NEWLINE=false
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context vcs status)
POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="\n"
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX=""
POWERLEVEL9K_STATUS_VERBOSE=true
export DEFAULT_USER="$USER"

######## iTerm2 Cursor Shape (Part 1)

function print_dcs
{
  print -n -- "\EP$1;\E$2\E\\"
}

function set_cursor_shape
{
  if [ -n "$TMUX" ]; then
    # tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
    print_dcs tmux "\E]50;CursorShape=$1\C-G"
  else
    print -n -- "\E]50;CursorShape=$1\C-G"
  fi
}

function set_cursor_shape_for_keymap
{
  case $KEYMAP in
    vicmd)
      set_cursor_shape 0 # block cursor
      ;;
    viins|main)
      set_cursor_shape 1 # line cursor
      ;;
  esac
  zle reset-prompt
  zle -R
}

######## TMUX

if [ -n "$TMUX_PANE" ]; then

    TMUX_STATUS_PREFIX="TMUX_STATUS_$(echo $TMUX_PANE | tr -d %)"

    function tmux_set_status {
      tmux set-env -g "${TMUX_STATUS_PREFIX}_$1" "$2"
    }

    function tmux_status_nvm_version {
      [[ ! $(type nvm) =~ 'nvm is a shell function'* ]] && tmux_set_status "nvm" "" && return
      local node_version=$(nvm current)
      [[ -z "${node_version}" ]] || [[ ${node_version} = "none" ]] && tmux_set_status "nvm" "" && return
      local nvm_default=$(cat $NVM_DIR/alias/default)
      [[ "$node_version" =~ "$nvm_default" ]] && tmux_set_status "nvm" "" && return

      tmux_set_status "nvm" " ${node_version:1} "
    }

    function tmux_status_pwd {
      trunc_symbol="…"
      dir=${PWD##*/}
      local max_len=40
      max_len=$(( ( max_len < ${#dir} ) ? ${#dir} : max_len ))
      ttcwd=${PWD/#$HOME/\~}
      pwdoffset=$(( ${#ttcwd} - max_len ))
      if [ ${pwdoffset} -gt "0" ]; then
        ttcwd=${ttcwd:$pwdoffset:$max_len}
        ttcwd=${trunc_symbol}/${ttcwd#*/}
      fi
      tmux_set_status "pwd" "$ttcwd"
    }

    function tmux_status_vi_mode {
      case $KEYMAP in
        (vicmd) tmux_set_status "vi_normal" " CMD " && tmux_set_status "vi_insert" ""      ;; 
        (*)     tmux_set_status "vi_normal" ""      && tmux_set_status "vi_insert" " INS " ;; 
      esac  
    }

    function tmux_status_desk {
      if [[ -n "$DESK_ENV" ]]; then
        tmux_set_status "desk" " ${${DESK_ENV##*/}%.sh} "
      else
        tmux_set_status "desk" ""
      fi
    }

    function zle-keymap-select {
      set_cursor_shape_for_keymap
      tmux_status_vi_mode
      tmux refresh-client -S
    }

    function zle-line-init {
      set_cursor_shape_for_keymap
      tmux_status_vi_mode
      tmux_status_pwd
      tmux_status_nvm_version
      tmux_status_desk
      tmux refresh-client -S
    }

else

    function zle-keymap-select zle-line-init
    {
        set_cursor_shape_for_keymap
    }

fi

######## iTerm2 Cursor Shape (Part 2)

zle -N zle-line-init
zle -N zle-keymap-select

function zle-line-finish
{
    set_cursor_shape 0 # block cursor
}

zle -N zle-line-finish

######## OS Paths

eval $(/usr/libexec/path_helper -s)

######## Homebrew

[ -f ~/.homebrew-github-token.txt ] && export HOMEBREW_GITHUB_API_TOKEN=$(cat ~/.homebrew-github-token.txt)

######## Node Version Manager

export NVM_DIR="/Users/antony/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

######## Vagrant

export VAGRANT_HOME=/Volumes/Debussy/vagrant.d

######## Java

export JAVA_HOME=$(/usr/libexec/java_home)
path=( $JAVA_HOME/bin $path )

######## VIM

export EDITOR="vim"

######## Emacs

alias ec="emacsclient --no-wait"
alias ecw="emacsclient"
alias ecn="emacsclient --no-wait --create-frame --frame-parameters='((width . 150) (height . 80))'"

######## Cincom

#export VW_CLI_ROOT=/Volumes/Debussy/Offloaded/Users/antony/Development/Cincom/VisualWorks
#alias cincom='cd $VW_CLI_ROOT'

######## Local Applications

path=( ~/.local/sbin ~/.local/bin $path )
path=( ~/local/sbin  ~/local/bin  $path )

######## iTerm2

[ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh

######## Jump Integration

eval "$(jump shell zsh)"

######## OPAM

. ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

####### Fuzzy Finder

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

######## Hook for desk activation

[ -n "$DESK_ENV" ] && source "$DESK_ENV" || true

eval $(thefuck --alias)

[[ $OS = "Linux" ]] && alias gsed=sed
[[ $OS = "OSX" ]] && alias sed=gsed

####### ZGEN

#POWERLEVEL9K_MODE='awesome-fontconfig'
#POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_MODE='nerdfont-complete'

source "${HOME}/.zgen/zgen.zsh"

how_colours() {
  for code ({000..255}) print -P -- "$code: %F{$code} First this %K{black} And this %K{white} And this %k%f%K{$code}%F{black} And this %F{white} And this %f%k"
}

if ! zgen saved; then
    zgen oh-my-zsh
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/command-not-found
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load bhilburn/powerlevel9k powerlevel9k
    zgen load zlsun/solarized-man
    zgen save
fi

#POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
#POWERLEVEL9K_SHORTEN_DELIMITER=""
#POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=''
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=''
#POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500\u2500%F{white}"
#POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}\u2570\u2500\u2524%F{white} "
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{yellow}>>%F{white} "
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status context dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs nvm pyenv rvm time os_icon_joined)
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="clear"
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="clear"
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="yellow"
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="yellow"
POWERLEVEL9K_OS_ICON_BACKGROUND="clear"
POWERLEVEL9K_OS_ICON_FOREGROUND="yellow"
POWERLEVEL9K_DIR_HOME_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_FOREGROUND="cyan"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="cyan"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="clear"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="black"
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="red"
POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="white"
POWERLEVEL9K_CONTEXT_BACKGROUND="clear"
POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="clear"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
POWERLEVEL9K_TIME_BACKGROUND="clear"
POWERLEVEL9K_TIME_FOREGROUND="cyan"
POWERLEVEL9K_APPLE_ICON=$'\uF8FF'
DEFAULT_USER=$USER

######## OS Paths

[[ $OS = "OSX" ]] && eval $(/usr/libexec/path_helper -s)

######## Homebrew

[ -f ~/.homebrew-github-token.txt ] && export HOMEBREW_GITHUB_API_TOKEN=$(cat ~/.homebrew-github-token.txt)

######## Neovim

export NVIM_TUI_ENABLE_TRUE_COLOR=1
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
	export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
	alias vi=nvr
	alias vim=nvr
	alias nvim=nvr
else
	export VISUAL=nvim
	alias vi=nvim
	alias vim=nvim
fi

######## Local Applications

path=( ~/.local/sbin ~/.local/bin $path )
path=( ~/local/sbin  ~/local/bin  $path )

######## iTerm2

[[ $OS = "OSX" ]] && [ -f ~/.iterm2_shell_integration.zsh ] && source ~/.iterm2_shell_integration.zsh

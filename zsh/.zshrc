# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZDOTDIR="$HOME/.config/zsh"
export ZSH="$ZDOTDIR/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions git extract web-search github history battery python git-extras vim-interaction)
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# functions

 function killByPort {
        local port=$1
        echo "killing port ${port}"
        lsof -i tcp:${port} | awk 'FNR == 2{print $2}' | xargs kill -9
        echo "done . . . "
}

function disk_space {
    local partition=$1
    local disk_space=$(df -h $partition | awk 'NR==2 {print $4}')
    echo "Available disk space on $partition: $disk_space"
}

function extract {
    # check all tools are installed
    local tools = "tar unzip unrar uncompress 7z bunzip2 gunzip"
    for tool in tools; do
        if ! command -v $tool &> /dev/null; then
            echo "$tool command not found"
            return 1
        fi
    done

    local file=$1
    if [ -f "$file" ]; then
        case $file in
            *.tar.bz2)   tar xvjf $file     ;;
            *.tar.gz)    tar xvzf $file     ;;
            *.bz2)       bunzip2 $file      ;;
            *.rar)       unrar x $file      ;;
            *.gz)        gunzip $file       ;;
            *.tar)       tar xvf $file      ;;
            *.tbz2)      tar xvjf $file     ;;
            *.tgz)       tar xvzf $file     ;;
            *.zip)       unzip $file        ;;
            *.Z)         uncompress $file   ;;
            *.7z)        7z x $file         ;;
            *)           echo "'$file' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$file' is not a valid file"
    fi
}

function clean_old_files {
    local directory=$1
    local days_old=$2

    find "$directory" -type f -mtime +$days_old -exec rm {} \;
    echo "Old files deleted."
}

function search_and_replace {
    local search_string="$1"
    local replace_string="$2"
    local directory="$3"

    grep -rl "$search_string" "$directory" | xargs sed -i "s/$search_string/$replace_string/g"
    echo "String '$search_string' replaced with '$replace_string' in files under '$directory'."
}

function create_dir_and_go {
    local directory="$1"
    mkdir -p "$directory" && cd "$directory"
}


auto_commit() {
    ## Function to auto commit changes to git,
    ## takes folder path as an argument, if no argument is passed,
    local folder_path=${1:-$(pwd)}
    local current_path=$(pwd)
    local current_datetime=$(date +"%Y-%m-%d %H:%M:%S")
    local git_commit_message=${2} # optional argument

    # Check if the folder path exists
    if [ ! -d "$folder_path" ]; then
        echo "Folder path '$folder_path' does not exist."
        return 1
    fi

    if [ folder_path != current_path ]; then
        echo "Changing directory to '$folder_path'"
        cd "$folder_path" || return 1
    fi
    # Change to the specified folder path
    git add .
    git commit -m "Auto commit on $current_datetime : $git_commit_message"
    git push --all

    if [ folder_path != current_path ]; then
        echo "Changing directory back to '$current_path'"
        cd "$current_path" || return 1
    fi

    echo "Changes committed successfully."
}


function add_link {
    local text="$1"
    local link="$2"
    local file=~/DevNotesAndCode/link.md
    if [ -f "$file" ]; then
        echo "[$text]($link)" >> "$file"
    else
        echo "File $file does not exist"
    fi
}

function ram_clean {
    su -c "echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'" root
}

# enable color support of ls and also add handy aliases
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'


# aliases
alias reload="source ~/.zshrc"
alias c="clear"
alias e="exit"
alias ls="exa"
alias ll="exa -l"
alias la="exa -la"
alias l.="exa -la | grep '^\.'"
alias ..="cd .."
alias ...="cd ../.."
alias hf="history | fzf"
alias pip="pip3"
alias python="python3"
alias rm="rm -fvr"
alias mkdir="mkdir -pv"
alias say="fortune | xcowsay"
alias note="nvim ~/DevNotesAndCode/notes.md && auto_commit ~/DevNotesAndCode"
alias fzfbat="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias fzftree="tzfgrep="rgrep -r . | fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias openree -afR | fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias f_repo="git remote get-url origin | xargs open"
alias kill_all_tmux="tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill"
alias tmux="tmux -f ~/.config/tmux/.tmux.conf a -t default || tmux -f ~/.config/tmux/.tmux.conf new -s default"
alias show_ports="sudo lsof -i -P -n | grep LISTEN"
alias ram_usage="ps aux | awk '{print \$4 "\t" \$11}' | sort | uniq -c | sort -nr | head -n 10"
alias dfh="df -h"
alias duh="du -h"


# lazy tools
alias lg="lazygit"
alias ld="lazydocker"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh


# -- the fuck : https://github.com/nvbn/thefuck
eval $(thefuck --alias fuck)

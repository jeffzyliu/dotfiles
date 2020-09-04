if status --is-login
	thefuck --alias | source
end

set -gx FZF_DEFAULT_COMMAND  'rg --files --no-ignore-vcs --hidden -g "!.git"'

if status --is-interactive
    starship init fish | source
    fnm env --multi | source
    source $HOME/.cargo/env
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval $HOME/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

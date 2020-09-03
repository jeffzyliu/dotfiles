if status --is-login
	thefuck --alias | source
end


# aliases!
abbr --add --global ssh-flume ssh jeffzyliu@flume.cs.dartmouth.edu
abbr --add --global ssh-moose ssh jeffzyliu@moose.cs.dartmouth.edu
abbr --add --global ssh-discovery ssh -K f0044rv@discovery
abbr --add --global mongo-start brew services start mongodb-community
abbr --add --global mongo-stop brew services stop mongodb-community
abbr --add --global mygcc gcc -Wall -pedantic -std=c11
abbr --add --global myclangpp clang++ -Wall -std=c++11
abbr --add --global myclangpp-openmp myclangpp -Xpreprocessor -fopenmp -lomp
abbr --add --global rm rm -i
abbr --add --global cp cp -i
abbr --add --global mv mv -i
abbr --add --global mkdir mkdir -p

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


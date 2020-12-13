if status --is-login
	thefuck --alias | source
end

set -gx FZF_DEFAULT_COMMAND  'rg --files --no-ignore-vcs --hidden -g "!.git"'

set -x PATH /Users/JeffLiu/perl5/bin $PATH ^/dev/null;
set -x PATH /usr/local/sbin $PATH;
set -q PERL5LIB; and set -x PERL5LIB /Users/JeffLiu/perl5/lib/perl5:$PERL5LIB;
set -q PERL5LIB; or set -x PERL5LIB /Users/JeffLiu/perl5/lib/perl5;
set -q PERL_LOCAL_LIB_ROOT; and set -x PERL_LOCAL_LIB_ROOT /Users/JeffLiu/perl5:$PERL_LOCAL_LIB_ROOT;
set -q PERL_LOCAL_LIB_ROOT; or set -x PERL_LOCAL_LIB_ROOT /Users/JeffLiu/perl5:;
set -x PERL_MB_OPT --install_base\ \"/Users/JeffLiu/perl5\";
set -x PERL_MM_OPT INSTALL_BASE=/Users/JeffLiu/perl5;

if status --is-interactive
    starship init fish | source
    fnm env --multi | source
    source $HOME/.cargo/env
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval $HOME/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

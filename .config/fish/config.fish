if status --is-login
	thefuck --alias | source
end

fish_vi_key_bindings

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

starship init fish | source

#set SPACEFISH_PROMPT_ORDER vi_mode user dir host git package node docker ruby aws haskell conda pyenv venv line_sep char
#set SPACEFISH_RPROMPT_ORDER exit_code exec_time time jobs battery

set SPACEFISH_USER_SHOW always
set SPACEFISH_USER_COLOR ff8700
set SPACEFISH_USER_PREFIX ' ' 
set SPACEFISH_VI_MODE_SUFFIX
set SPACEFISH_VI_MODE_COLOR brred
set SPACEFISH_TIME_SHOW true
set SPACEFISH_DIR_TRUNC 4
set SPACEFISH_DIR_TRUNC_REPO false
set SPACEFISH_DIR_COLOR brgreen
set SPACEFISH_GIT_BRANCH_COLOR cyan
set SPACEFISH_HOST_SHOW_FULL true
set SPACEFISH_EXIT_CODE_SHOW true

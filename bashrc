# ----------------------My Bashrc-------------------------
# --------------------------------------------------------

# --------------------Bashrc Commands---------------------
# --------------------------------------------------------
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=500
HISTFILESIZE=10000
# Add time and date to history
HISTTIMEFORMAT="%F %T "
# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace
# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize
# append to the history file, don't overwrite it
shopt -s histappend
PROMPT_COMMAND='history -a'
# Disable the bell
iatest=$(expr index "$-" i)
if [[ $iatest > 0 ]]; then bind "set bell-style visible"; fi
# Allow ctrl-S for history navigation (with ctrl-R)
stty -ixon
# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest > 0 ]]; then bind "set completion-ignore-case on"; fi
# Show auto-completion list automatically, without double tab
if [[ $iatest > 0 ]]; then bind "set show-all-if-ambiguous On"; fi
# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS=`echo "
no=00:
di=4;40;33:
ow=4;40;33:
ln=05;40;94:
or=05;40;91:
so=01;35:
ex=01;91:
*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.jar=01;31:
*.md=01;40;95:
*.xlsx=04;40;32:*.csv=04;40;32:
*Makefile=04;40;91:
*.txt=01;40;96:
" | tr -d '\n'`;
alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS
# Color for manpages, makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
# ------------------End Bashrc Commands-------------------
# --------------------------------------------------------

# -----------------------Bash Colors-----------------------
# ---------------------------------------------------------
blk='\[\033[01;30m\]'   # Black
red='\[\033[01;31m\]'   # Red
grn='\[\033[01;32m\]'   # Green
ylw='\[\033[01;33m\]'   # Yellow
blu='\[\033[01;34m\]'   # Blue
pur='\[\033[01;35m\]'   # Purple
cyn='\[\033[01;36m\]'   # Cyan
wht='\[\033[01;37m\]'   # White
clr='\[\033[00m\]'      # Reset
# ---------------------End Bash Colors---------------------
# ---------------------------------------------------------

# ----------------------Calendar---------------------------
# ---------------------------------------------------------
alias jan='cal -m 01'
alias feb='cal -m 02'
alias mar='cal -m 03'
alias apr='cal -m 04'
alias may='cal -m 05'
alias jun='cal -m 06'
alias jul='cal -m 07'
alias aug='cal -m 08'
alias sep='cal -m 09'
alias oct='cal -m 10'
alias nov='cal -m 11'
alias dec='cal -m 12'
# -------------------End Calendar--------------------------
# ---------------------------------------------------------

# ------------------Needed Git Functions------------------
# --------------------------------------------------------
# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}
# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}
# ----------------End Needed Git Functions ---------------
# --------------------------------------------------------

# ---------------Shell Prompt---------------
# ------------------------------------------
# Username
export username='\[\e[31m\]\u\[\e[m\]\[\e[33m\]@'
# Full Path
export fp='\[\e[m\]\[\e[32m\]\w\[\e[m\]'
# Only Current Path
export cp='\[\e[m\]\[\e[32m\]\W\[\e[m\]'
# Time in 24hour format.
export time24h="\[\e[36m\]\A\[\e[m\]"
# Time in 24hour format with seconds.
export time24hwS="\[\e[36m\]\t\[\e[m\]"
# Symbols at the end
export arr=" \[\e[36m\]>\[\e[m\]\[\e[36m\]>\[\e[m\] ";
export doll=" \[\e[36m\]$\[\e[m\] ";
export pointer=" \[\e[36m\]->\[\e[m\] ";
export laptop=" 💻 ";
export floppy=" 💾 ";
export bomb=" 💣 "
export money=" 💵 "
export retro=" 👾 "
export alien=" 👽 "
export clown=" 🤡 "
export beer=" 🍺 "
# Git
export gitp="\[\e[31m\]\`parse_git_branch\`\[\e[m\]"
# Python Environment
# export pythonEnv=""
# Initialization of prompt
initPrompt() {
	export isGactive="false";
	export isNactive="false";
	export isNSactive="false";
	export isTactive="false";
	export isTSactive="false";
	export isUactive="false";
	export isBactive="false"
	export activePath="";
}
# Reset prompt
resetPrompt() {
	export newLineStart="";
	export timePath="";
	export promptPath="";
	export gitPath="";
	export newLine="";
	export usernamePath="";
	export symbolPath="$arr";
	export leftBrack="";
	export rightBrack="";
	initPrompt
}
# Finalize prompt
finalizePrompt() {
	export PS1="$newLineStart$timePath$leftBrack$usernamePath$optionalSpace$promptPath$gitPath$rightBrack$newLine$pythonEnv$symbolPath";
}
# Changes the prompt of the shell
prompt() {
	if [ "$1" = "fp" ]; then
		activePath="fp";
		export promptPath="$fp";
		finalizePrompt;
	elif [ "$1" = "cp" ]; then
		activePath="cp";
		export promptPath="$cp";
		finalizePrompt;
	elif [ "$1" = "g" ]; then
		if [ "$isGactive" = "true" ]; then
			export isGactive="false";
			export gitPath="";
		else
			export gitPath=" \[\e[31m\]\`parse_git_branch\`\[\e[m\]";
			export isGactive="true";
		fi
		finalizePrompt;
	elif [ "$1" = "t" ]; then
		if [ "$isTactive" = "true" ]; then
			export isTactive="false";
			export timePath="";
			export optionalSpace=" ";
		else
			export timePath="$time24h ";
			export isTactive="true";
			export isTSactive="false";
			export optionalSpace="";
		fi
		finalizePrompt;
	elif [ "$1" = "ts" ]; then
		if [ "$isTSactive" = "true" ]; then
			export isTSactive="false";
			export timePath="";
		else
			export timePath="$time24hwS ";
			export isTSactive="true";
			export isTactive="false";
		fi
		finalizePrompt;
	elif [ "$1" = "n" ]; then
		if [ "$isNactive" = "true" ]; then
			export isNactive="false";
			export newLine="";
		else
			export newLine="\n";
			export isNactive="true";
		fi
		finalizePrompt
	elif [ "$1" = "ns" ]; then
		if [ "$isNSactive" = "true" ]; then
			export isNSactive="false";
			export newLineStart="";
		else
			export newLineStart="\n";
			export isNSactive="true";
		fi
		finalizePrompt
	elif [ "$1" = "u" ]; then
		if [ "$isUactive" = "true" ]; then
			export isUactive="false";
			export usernamePath="";
		else
			export usernamePath="$username";
			export isUactive="true";
		fi
		finalizePrompt
	elif [ "$1" = "b" ]; then
		if [ "$isBactive" = "true" ]; then
			export isBactive="false";
			export leftBrack="";
			export rightBrack="";
		else
			export leftBrack="\[\e[33m\][\[\e[m\]";
			export rightBrack="\[\e[33m\]]\[\e[m\]";
			export isBactive="true";
		fi
		finalizePrompt
	elif [ "$1" = "s" ]; then
		if [ "$2" = "0" ]; then
			export symbolPath=" ";
		fi
		if [ "$2" = "1" ]; then
			export symbolPath="$arr";
		fi
		if [ "$2" = "2" ]; then
			export symbolPath="$doll";
		fi
		if [ "$2" = "3" ]; then
			export symbolPath="$pointer";
		fi
		if [ "$2" = "4" ]; then
			export symbolPath="$laptop";
		fi
		if [ "$2" = "5" ]; then
			export symbolPath="$floppy";
		fi
		if [ "$2" = "6" ]; then
			export symbolPath="$bomb";
		fi
		if [ "$2" = "7" ]; then
			export symbolPath="$money";
		fi
		if [ "$2" = "8" ]; then
			export symbolPath="$retro";
		fi
		if [ "$2" = "9" ]; then
			export symbolPath="$alien";
		fi
		if [ "$2" = "10" ]; then
			export symbolPath="$clown";
		fi
		if [ "$2" = "11" ]; then
			export symbolPath="$beer";
		fi
		finalizePrompt
	elif [ "$1" = "r" ]; then
		initPrompt
		resetPrompt
		finalizePrompt
	elif [ "$1" = "save" ]; then
		mkdir -p ~/.promptcfg;
		echo $isGactive > ~/.promptcfg/isGactive;
		echo $isNactive > ~/.promptcfg/isNactive;
		echo $isNSactive > ~/.promptcfg/isNSactive;
		echo $isTactive > ~/.promptcfg/isTactive;
		echo $isTSactive > ~/.promptcfg/isTSactive;
		echo $isUactive > ~/.promptcfg/isUactive;
		echo $isBactive > ~/.promptcfg/isBactive;
		echo $symbolPath > ~/.promptcfg/symbolPath;
		echo $activePath > ~/.promptcfg/activePath;
	elif [ "$1" = "load" ]; then
		if [[ ! -d ~/.promptcfg ]]; then
			# If it's the first time
			resetPrompt;
			prompt g;
			prompt n;
			prompt ns;
			prompt t;
			prompt fp;
			prompt s 1;
			prompt save;
		fi

		resetPrompt;
		export activateG=$(head -n 1 ~/.promptcfg/isGactive);
		export activateN=$(head -n 1 ~/.promptcfg/isNactive);
		export activateNS=$(head -n 1 ~/.promptcfg/isNSactive);
		export activateT=$(head -n 1 ~/.promptcfg/isTactive);
		export activateTS=$(head -n 1 ~/.promptcfg/isTSactive);
		export activateU=$(head -n 1 ~/.promptcfg/isUactive);
		export activateB=$(head -n 1 ~/.promptcfg/isBactive);
		export activateSymbol=$(head -n 1 ~/.promptcfg/symbolPath);
		export activePath=$(head -n 1 ~/.promptcfg/activePath);

		if [ "$activateG" = "true" ]; then
			prompt g;
		fi
		if [ "$activateN" = "true" ]; then
			prompt n;
		fi
		if [ "$activateNS" = "true" ]; then
			prompt ns;
		fi
		if [ "$activateT" = "true" ]; then
			prompt t;
		fi
		if [ "$activateTS" = "true" ]; then
			prompt ts;
		fi
		if [ "$activateB" = "true" ]; then
			prompt b;
		fi
		if [ "$activateU" = "true" ]; then
			prompt u;
		fi
		if [ "$activePath" = "fp" ]; then
			prompt fp;
		else
			prompt cp;
		fi
		export symbolPath=" $activateSymbol ";
		finalizePrompt;
	elif [ "$1" = "hide" ]; then
		echo Set custom path: 
		read customPath;
		export promptPath="$grn$customPath$clr";
		finalizePrompt;
	elif [ "$1" = "h" ]; then
		echo "Options for the prompt:"
		echo "	n  -> Toggle newline at the end of prompt."
		echo "	ns -> Toggle newline at the start of prompt."
		echo "	t  -> Toggle time in format hh:mm"
		echo "	ts -> Toggle time in format hh:mm:ss"
		echo "	g  -> Toggle git."
		echo "	u  -> Toggle username."
		echo "	b  -> Toggle brackets."
		echo "	fp -> Show the full path to the current folder."
		echo "	cp -> Show the current folder only."
		echo "	r  -> Removes every option of the prompt."
		echo "	s  -> Changes the prompt symbol: "
		echo "        	0 == "
		echo "        	1 == >>"
		echo "        	2 == $"
		echo "        	3 == ->"
		echo "        	4 == 💻"
		echo "        	5 == 💾"
		echo "        	6 == 💣"
		echo "        	7 == 💵"
		echo "        	8 == 👾"
		echo "        	9 == 👽"
		echo "        	10 == 🤡"
		echo "        	11 == 🍺"
		echo "	save -> Saves your current prompt and makes it your default."
		echo "	load -> Loads your default prompt."
		echo "	hide -> Let's you change the path of your prompt."
	else
		echo "The option you are trying to use does not exist. Try prompt h to see all prompt functionalities.";
	fi
}
prompt load;
# -------------End Shell Prompt-------------
# ------------------------------------------


# ------------Common Aliases------------
# --------------------------------------
# Update shell
alias update='sudo apt-get update && sudo apt-get upgrade'
# Internal IP address
alias ipi="hostname -I | awk '{print $1}'"
# External IP address
alias ipe='curl ipinfo.io/ip'
# Reloads shell with new bashrc
alias reload='source ~/.bashrc';
alias r='source ~/.bashrc';
# Opens bashrc
alias bashrc='code ~/.bashrc;'
# Opens current dir with nautilus
alias startn='nautilus . &'
# Opens current dir with linux-file explorer
alias startl='xdg-open .'
# Opens current dir with windows-file explorer
alias startw='explorer.exe .'
## A quick way to get out of current directory
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
## Get rid of command not found
alias cd..='cd ..'
# cd into previous directory
alias bd='popd &>/dev/null; ls -CF'
# Better ls aliases
alias la='ls -A'
alias l='ls -CF'
alias lt='du -sh * | sort -h'
alias lx='ls -lXBh' # sort by extension
alias lk='ls -lSrh' # sort by size
alias lc='ls -lcrh' # sort by change time
alias lu='ls -lurh' # sort by access time
alias lr='ls -lRh' # recursive ls
alias lt='ls -ltrh' # sort by date
alias lm='ls -alh |more' # pipe through 'more'
alias lw='ls -xAh' # wide listing format
alias ll='ls -Fls' # long listing format
alias labc='ls -lap' #alphabetical sort
alias lf="ls -l | egrep -v '^d'" # files only
alias ldir="ls -l | egrep '^d'" # directories only
## Colorize the ls output
alias ls='ls --color=auto'
## Show hidden files
alias l.='ls -d .* --color=auto'
# Write cls instead of clear
alias cls="clear"
# Clear screen and ls
alias cl="cls;echo Current Directory:;echo;ls -CF;"
# Count files in a folder
alias count='find . -type f | wc -l'
# Remove directory
alias rmd='/bin/rm --recursive --force --verbose '
# ------------------------------------------
# ------------End Common Aliases------------


# -------------Common Functions-------------
# ------------------------------------------
# When you cd you ls
cd() {
	pushd $1 &>/dev/null;
	ls -CF;
}
# Make directory and enter it.
take() {
	mkdir $1;
	cd $1;
}
# Extracts any archive(s) (if unp isn't installed)
extract () {
	for archive in $*; do
		if [ -f $archive ] ; then
			case $archive in
				*.tar.bz2)   tar xvjf $archive    ;;
				*.tar.gz)    tar xvzf $archive    ;;
				*.bz2)       bunzip2 $archive     ;;
				*.rar)       rar x $archive       ;;
				*.gz)        gunzip $archive      ;;
				*.tar)       tar xvf $archive     ;;
				*.tbz2)      tar xvjf $archive    ;;
				*.tgz)       tar xvzf $archive    ;;
				*.zip)       unzip $archive       ;;
				*.Z)         uncompress $archive  ;;
				*.7z)        7z x $archive        ;;
				*)           echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}
# Searches text in current directory.
ftext ()
{
	# -i case-insensitive
	# -I ignore binary files
	# -H causes filename to be printed
	# -r recursive search
	# -n causes line number to be printed
	# optional: -F treat search term as a literal, not a regular expression
	# optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
	grep -iIHrn --color=always "$1" . | less -r
}
# Goes up a specified number of directories  (i.e. up 4)
up ()
{
	local d=""
	limit=$1
	for ((i=1 ; i <= limit ; i++))
		do
			d=$d/..
		done
	d=$(echo $d | sed 's/^\///')
	if [ -z "$d" ]; then
		d=..
	fi
	cd $d
}
# Install all needed support files for this bashrc
init_bashrc () {
	cd ~;
	git clone git@github.com:tehmike6/my-bashrc.git;
	mv my-bashrc .my-bashrc;
	cd .my-bashrc;
	sj my-bash
	cd ~;
	echo "Don't forget to update your bashrc using: ./.my-bashrc/update.sh";
}
# Output in all subdirectory files that have git changes
gitChanges() {
	find . -type d -name '.git' | while read dir ; do sh -c "cd $dir/../ && echo \"\nGIT STATUS IN ${dir//\.git/}\" && git status -s" ; done | tee gitStatus.txt
}
# Git add all, commit and push
gitall() {
	echo Write commit message: 
	read commitMSG
	git add .
	git commit -m "$commitMSG"
	git push
}
# Create directory and go to it
take() {
	mkdir $1;
	cd $1;
}
# Create a venv
venv() {
	mkdir -p ~/.virtualenvs
	
	python3 -m venv ~/.virtualenvs/$1
}
# Activate python environment
activate() {
	source ~/.virtualenvs/$1/bin/activate
	export env=`basename $VIRTUAL_ENV`
	export pythonEnv='\[\e[93m\]($env)\[\e[m\]'
	finalizePrompt
}
deact() {
	deactivate;
	export pythonEnv=''
	finalizePrompt
}
venvlist() {
	ls ~/.virtualenvs/
}
venvremove() {
	sudo rm -rf ~/.virtualenvs/$1
}
# ------------------------------------------
# -----------End Common Functions-----------


# ---------------Set Home---------------
# --------------------------------------
# Initialization
homedir=$'~'
rootdir=$''
# Sets to home the dir you are currently in
alias sethome='homedir=$(pwd);'
# Jumps to the dir
alias home='cd $homedir;'
# -------------End Set Home-------------
# --------------------------------------


# ------------Jump to any dir------------
# ---------------------------------------
# Check if jumpcfg exists and if it doesn't creates it.
mkdir -p ~/.jumpcfg
# Set a variable named as the first argument you give to this command
# that maps the variable name you gave with the path you are.
sj () {
    export currentPath=`pwd`;
    touch ~/.jumpcfg/$1;
    echo $currentPath > ~/.jumpcfg/$1;
}
# Jump to path that is maped with the variable name of your first argument.
j () {
    jumpPath=$(< ~/.jumpcfg/$1);
    if [ -z "$jumpPath" ]
    then
        echo "File not found";
    else
        echo "Jumping to" $jumpPath;
        cd $jumpPath;
    fi
}
# Delete the variable name that matches a path.
rj () {
    export tmpPath=`pwd`;
    cd ~/.jumpcfg > /dev/null;
    rm $1;
    cd $tmpPath > /dev/null;
}
# Lists all the alliases that have been created.
lj () {
    export currentPath=`pwd`;
    cd ~/.jumpcfg > /dev/null;
    ls -CF;
    cd $currentPath > /dev/null;
}
# -------------------------------------------
# ------------End Jump to any dir------------

# --------------------End My Bashrc-----------------------
# --------------------------------------------------------
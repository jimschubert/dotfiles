# --- Functions --- #
# Notice title
function notice { echo -e "\033[1;32m=> $1\033[0m"; }

# Error title
function error { echo -e "\033[1;31m=> Error: $1\033[0m"; }

# List item
function c_list { echo -e "  \033[1;32m✔\033[0m $1"; }

# Error list item
function e_list { echo -e "  \033[1;31m✖\033[0m $1"; }

# Check for dependency
function dep {
  # Check installed
  local i=true
  type -p $1 &> /dev/null || i=false

  # Check version
  if $i ; then
    local version=$($1 --version | grep -oE -m 1 "[[:digit:]]+\.[[:digit:]]+\.?[[:digit:]]*")
    [[ $version < $2 ]] && local msg="Version $1 ($version) needed: $2" 
    [ -n "$msg" ] && missing+=("$msg")
  else
    local msg="Missing $1"
    missing+=("$msg")
  fi
}

# --- INIT --- #
current_pwd=$(pwd)
missing=()

# --- Check deps --- #
notice "Checking dependencies"
dep "git"  "1.7"
dep "ruby" "1.8"
dep "vim" "7.3"
dep "tree" "1.5"
dep "rake" "0.8.7"
dep "gem" "1.7.2"
dep "bundle" "1.0.15"
dep "trash" "0.1.1"

if [ "${#missing[@]}" -gt "0" ]; then
  error "Missing dependencies"
  for need in "${missing[@]}"; do
    e_list "$need."
  done
  exit 1
fi

# Copy original .bashrc to .bashrc.local
if [ -f ~/.bashrc ] && [ ! -f ~/.bashrc.local ]; then
    cp ~/.bashrc ~/.bashrc.local
fi

# Assumes ~/.dotfiles is *ours*
if [ -d ~/.dotfiles ]; then
  # --- Update Repo --- #
  notice "Updating"
  cd ~/.dotfiles
  git pull origin master
  git submodule init
  git submodule update

  # --- Install --- #
  notice "Installing"
  rake backup
  rake install
else
  # --- Clone Repo --- #
  notice "Downloading"
  git clone --recursive git@github.com:jimschubert/dotfiles.git ~/.dotfiles

  # --- Install --- #
  notice "Installing"
  cd ~/.dotfiles
  rake backup
  rake install
fi

# --- Finished --- #
cd $current_pwd
notice "Done"

if [ -f ~/.bashrc ] ; then
    source ~/.bashrc
fi

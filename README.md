# dotfiles

Yeah, I joined the club.

These are my dotfiles so I can have my favorite configuration when I move to another environment.

I've pulled a lot from other places and mixed with my own configuration. You're welcome to use any of it.

Places I've pulled from:  

 * [@ryanb](https://github.com/ryanb/dotfiles)
 * [@mathiasbynens](https://github.com/mathiasbynens/dotfiles)
 * [@gf3](https://github.com/gf3/dotfiles)

I think I've got a pretty good setup.  Be sure to check out the three above.

# Installation

Caveat: if you're installing this to a non-new environment, be sure to run a backup and make sure it works.

    git clone git@github.com:jimschubert/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    rake backup
    cd ~/.dotfiles-backup/[TAB TAB]

If your files are not backed up, please either manually backup or edit the script. This script is _*destructive*_.


Run `bootstrapper.sh` and it will complain about missing dependencies or favorite programs.

The quick `apt-get`:

`sudo apt-get install ruby trash-cli git mercurial vim vim-doc vim-common vim-gui-common tree rake rubygems ruby-bundler curl`

This will get everything installed and ready for the configuration.

After the default ruby is installed, install rvm to manage different versions:

```
\curl -#L https://get.rvm.io | bash -s stable --autolibs=3 --ruby
echo "source $HOME/.rvm/scripts/rvm" >> ~/.bash_profile
```

After installing rvm, in gnome-terminal you will need to go to your profile preferences, select the *Title and Command* tab and check *Run command as a login shell*

If you're not interested in all of the ruby gems, do a `mv Gemfile Gemfile.bak` before this block:

```
source ~/.bash_profile
rvm install 1.9.3 && rvm use 1.9.3
gem install bundler
./bootstrap.sh
source ~/.bashrc
```

_Dance_

## Cygwin

To install in cygwin, you'll need the most recent ruby package. Manually install rubygems using curl/wget/other method:

    mkdir -p ~/Downloads && cd ~/Downloads
    curl http://rubyforge.org/frs/download.php/76073/rubygems-1.8.24.tgz
    tar zxf rubygems-1.8.24.tgz && cd rubygems-1.8.24
    ruby setup.rb install
    gem install rake

Afterward, you may need to remove the dependency checks for trash/tree which are not currently in the cygwin repo.  To do this, 
comment out the lines in `bootstrapper.sh` (lines 40 and 42):

    # dep "tree" "1.5"
    dep "rake" "0.8.7"
    dep "gem" "1.7.2"
    dep "bundle" "1.0.15"
    # dep "trash" "0.1.1"

After running `bootstrapper.sh`, be sure to execute `source ~/.bashrc` and the dotfiles should be loaded.  Also be sure to check 
the bash aliases to be sure trash/tree are not referenced if you have commented the lines above.

# Bash

    $ tree ~/.bash
    /home/jim/.bash
    ├── aliases
    ├── completions
    ├── completion_scripts
    │   └── git_completion
    ├── config
    ├── functions
    ├── paths
    └── prompt

The above files are loaded by `.bashrc`. The files are pretty self-explanatory, other than `prompt` which colorizes the bash prompt with tweaks for git.

## Cool Aliases

 * cd : pushd
 * bd : popd
 * cd..  | ..   : back one directory
 * cd... | ...  : back two directories
 * ^ up to five directories
 * rm : trash
 * undopush
 * ip
 * GET | HEAD | POST | PUT | DELETE | TRACE | OPTIONS

## Config

 * sets editor to vim
 * sets English/UTF-8
 * sets manpager
 * sets commands to ignore in history
 * sets noclobber (e.g. prevents `cat > IMPORTANT_FILE` mistakes )
 * sets nocaseglob (e.g. `ls ~/.B*` will list contents of `~/.bash`)

## Functions

The two functions, `md` and `c` may not seem like much, but they simplify some commands. For example:
    
    $ md projects; git clone git@github.com:jimschubert/dotfiles.git && cd dotfiles

In the above line, `md` will create the projects directory and `cd` into it.

`c` stands for 'code' and  works like this:

    jim at computer in ~
    $ pwd
    /home/jim
    jim at computer in ~
    $ c dotfiles
    ~/projects/dotfiles ~
    jim at computer in ~/projects/dotfiles on master
    $

You can change it to whatever shortcut and issue `reload`, which is also an alias from this setup.

### HTTP Functions

`curl` provides some weird output when you try to pipe the output.  For instance, when working with a couchdb install, and the `json` function in *.bash/functions*, you would receive statistics:

	jim at schubert in ~/temp
	$ curl -X GET $HOST
	{"couchdb":"Welcome","version":"1.0.1"}
	jim at schubert in ~/temp
	$ curl -X GET $HOST | json
	  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
		                         Dload  Upload   Total   Spent    Left  Speed
	100    40  100    40    0     0   9789      0 --:--:-- --:--:-- --:--:-- 13333
	{
	    "couchdb": "Welcome", 
	    "version": "1.0.1"
	}

Using the tip from [Dennis Williamson's answer on superuser.com](http://superuser.com/questions/173209/curl-how-to-suppress-strange-output-when-redirecting), the couch-x functions can easily be piped through the `json` function.  For instance, here's the output similar to the previous commands:

	jim at schubert in ~/.bash
	$ couch-get $HOST
	{"couchdb":"Welcome","version":"1.0.1"}
	jim at schubert in ~/.bash
	$ couch-get $HOST | json
	{
	    "couchdb": "Welcome", 
	    "version": "1.0.1"
	}






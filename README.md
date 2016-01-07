# i made this

Find a project with a free re-licensable license, and repurpose to your own.

Great for padding your past accomplishments!

![i made this](http://weknowmemes.com/wp-content/uploads/2013/11/i-made-this-comic.jpg)

http://weknowmemes.com/2013/11/i-made-this-meme/

# Usage

Only tested under GNU/Linux, requires:

- bash
- sed
- find


```sh

Point to a free to re-license project (MIT/BSD) and make it your own.

WARNING: This is extremely alpha quality, and should be used at your own risk!

DISCLAIMER: This is intended as a joke, and not a serious effort to
undermine anyone else's work.

At this time, do *NOT* use anything but alphanumerics (and dashes) for
any of the option parameters other than '-g'.

  -g  The git remote/clone URL
  -o  Original project name
  -n  New project name
  -a  Original author name
  -y  Your name

Sample call:

./i-made-this.sh -g 'https://github.com/ahungry/i-made-this.git' \
  -o 'i made this' \
  -d 'my-project-clone-dir' \
  -n 'my project' \
  -a 'Matthew Carter' \
  -g 'Fake Name'
```

# License

AGPLv3

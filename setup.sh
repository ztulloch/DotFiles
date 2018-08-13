#!/bin/bash
# setup emacs
cp dot.emacs.lin ~/.emacs 
if [ ! -d ~/.emacs.d ]; then
    mkdir ~/.emacs.d
fi
mkdir ~/.emacs.d/site-lisp
mkdir ~/.emacs.d/lisp
cp universal-init.el ~/.emacs.d/site-lisp

# setup bash
cat bashrc >> ~/.bashrc
cp bash_machine ~/.bash_machine
sed -i -- 's/username/ztulloch/g' pinerc
sed -i -- 's/mailserver/tulltech/g' pinerc

cp pinerc ~/.pinerc
cp pine_passfule ~/.pine_passfile


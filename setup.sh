#!/bin/bash
# setup emacs
cp dot.emacs.lin ~/.emacs 
if [ ! -d ~/.emacs.d ]; then
    mkdir ~/EmacsRoot
fi
mkdir ~/.emacs.d/site-lisp
mkdir ~/.emacs.d/lisp
cp universal-init.el ~/.emacs.d/site-lisp

# setup bash
cat bashrc >> ~/.bashrc
cp bash_machine ~/.bash_machine

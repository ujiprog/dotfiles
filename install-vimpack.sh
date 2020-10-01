#!/bin/sh
vim -c 'call minpac#clean()' \
    -c 'call minpac#update("", {"do": "quit"})' \
    -c 'call fzf#install()' \
    -c ':q'

#!/bin/sh

targets=".emacs .emacs.d"

for file in $targets; do
    overwrite=false
    backup=false
    overwrite_all=false
    backup_all=false
    
    target="$HOME/$file"

    if [ -e "$target" ] || [ -h "$target" ]; then
        if ! $overwrite_all && ! $backup_all; then
            while true; do
                echo "$target already exists"
                echo "[s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all "
                read answer
                case $answer in
                    "s" ) continue 2;;  # continue the outer for loop
                    "S" ) break 2;;     # break out of the outer for loop
                    "o" ) overwrite=true; break;;
                    "O" ) overwrite_all=true; break;;
                    "b" ) backup=true; break;;
                    "B" ) backup_all=true; break;;
                    *   ) continue ;;
                esac
            done
        fi

        if $overwrite || $overwrite_all; then
            rm -fr $target
        fi

        if $backup || $backup_all; then
            mv $target "$target.backup"
        fi
    fi

    echo "Installing $target"
    ln -s "$PWD/$file" "$target"
done

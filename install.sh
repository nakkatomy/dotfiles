#!/bin/bash

for f in .??*
do
    [ "$f" == ".git" ] && continue
    [ "$f" == ".DS_Store" ] && continue

    ln -svfn "$HOME"/dotfiles/"$f" "$HOME"/"$f"
done
echo "Deploy dotfiles complete!"

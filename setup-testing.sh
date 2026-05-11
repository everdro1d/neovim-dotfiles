#!/usr/bin/env bash

rm -rf ~/.config/nvim

ln -sf ~/project/neovim-dotfiles ~/.config/nvim

notify-send "Created Links" "nvim config now shows live changes"

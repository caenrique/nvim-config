# Bootstrap

    git clone git@github.com:caenrique/nvim-config.git ~/.config/nvim/ && \
    git clone git@github.com:wbthomason/packer.nvim.git ~/.local/share/nvim/site/pack/packer/start/packer.nvim && \
    nvim --headless -u ~/.config/nvim/lua/plugins.lua -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

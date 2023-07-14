# Path
contains /Users/skagan/.local/bin $fish_user_paths; or set -Ua fish_user_paths /Users/skagan/.local/bin
contains /usr/local/opt/ruby/bin $fish_user_paths; or set -Ua fish_user_paths /usr/local/opt/ruby/bin

fish_vi_key_bindings

# Nix
# Needs to come before aliases
if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
    source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish
end

# Aliases
source ~/.important/aliases/aliases_common
source ~/.important/aliases/aliases_sensitive
if test -e $HOME/.important/aliases/aliases_sensitive
    source $HOME/.important/aliases/aliases_sensitive
end
source ~/.important/aliases/aliases_misc.fish

# App-specific settings
if test -d ~/.nix-profile/share/asdf-vm
    set -g ASDF_DIR ~/.nix-profile/share/asdf-vm
    source ~/.nix-profile/share/asdf-vm/asdf.fish
end
if which -s zoxide
    zoxide init fish | source
end
if which -s docker
    if test -d /Applications/Docker.app
        source /Applications/Docker.app/Contents/Resources/etc/docker-compose.fish-completion
        source /Applications/Docker.app/Contents/Resources/etc/docker.fish-completion
    end
end
if test -e ~/.config/fish/functions/fzf_configure_bindings.fish 
    fzf_configure_bindings
end
set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; test -f /Users/skagan/.ghcup/env ; and set -gx PATH $HOME/.cabal/bin /Users/skagan/.ghcup/bin $PATH # ghcup-env
if test -d /Users/skagan/.opam
    source /Users/skagan/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true
end
if which -s direnv
    direnv hook fish | source
end

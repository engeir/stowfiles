if status is-interactive

    # ── PATH ──────────────────────────────────────────────────────────────────
    fish_add_path ~/bin ~/.local/bin ~/.cargo/bin ~/.pixi/bin

    # ── GPG / SSH ─────────────────────────────────────────────────────────────
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket 2>/dev/null)
    gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1

    # ── TOOL INTEGRATIONS (cached) ────────────────────────────────────────────
    set -q XDG_CACHE_HOME; or set -l XDG_CACHE_HOME $HOME/.cache
    set -l _zi_dir $XDG_CACHE_HOME/fish
    mkdir -p $_zi_dir

    function _zi --no-scope-shadowing
        set -l cache $_zi_dir/$argv[1].fish
        set -l bin (command -v $argv[2] 2>/dev/null)
        set -l cmd $argv[3..]
        set -l stale 0
        if not test -f $cache
            set stale 1
        else if test -n "$bin"; and test $bin -nt $cache
            set stale 1
        end
        if test $stale -eq 1
            $cmd > $cache 2>/dev/null
        end
        source $cache 2>/dev/null
    end

    _zi mise     mise     mise activate fish
    _zi fzf      fzf      fzf --fish
    _zi zoxide   zoxide   zoxide init --cmd cd fish
    _zi atuin    atuin    atuin init fish
    _zi starship starship starship init fish
    command -q navi; and _zi navi navi navi widget fish

    functions -e _zi

    set -gx ATUIN_SESSION (cat /proc/sys/kernel/random/uuid)

    # ── VI KEY BINDINGS ───────────────────────────────────────────────────────
    set -g fish_key_bindings fish_vi_key_bindings
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_visual line

    # ── COMPLETIONS (cached) ──────────────────────────────────────────────────
    set -l _gc_dir $_zi_dir/completions
    mkdir -p $_gc_dir

    function _gc --no-scope-shadowing
        set -l out $_gc_dir/$argv[1].fish
        set -l bin (command -v $argv[2] 2>/dev/null)
        set -l cmd $argv[3..]
        test -z "$bin"; and return
        if not test -f $out; or test $bin -nt $out
            $cmd > $out 2>/dev/null
        end
        source $out 2>/dev/null
    end

    _gc mise  mise  mise completion fish
    _gc aqua  aqua  aqua completion fish
    _gc just  just  just --completions fish
    _gc uv    uv    uv generate-shell-completion fish
    _gc pixi  pixi  pixi completion --shell fish
    _gc jj    jj    jj util completion fish
    _gc atuin atuin atuin gen-completions --shell fish

    functions -e _gc

    # ── ALIASES ───────────────────────────────────────────────────────────────
    alias ls 'ls --color=auto'
    alias grep 'grep --color=auto'

end

# ── PATH (login) ───────────────────────────────────────────────────────────────
set -gx BUN_INSTALL ~/.bun
fish_add_path $BUN_INSTALL/bin

# dotfiles

Minimal Chezmoi-managed dotfiles.

## Bootstrap

```bash
brew install chezmoi
chezmoi init https://github.com/bradurani/dotfiles.git
chezmoi apply
```

## Layout

- `dot_*` becomes hidden files in `$HOME`
- `dot_config/` becomes `~/.config/`
- `private_*` holds machine-local or sensitive files
- `.chezmoiscripts/` holds setup scripts

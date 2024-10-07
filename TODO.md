# Issues

## Auto session
- [?] Session manager doesn't delete session when using a session per git branch. [issue](https://github.com/rmagatti/auto-session/issues/245)
- Session corrupted on start up a lot of times
- Add auto-completion for commands that expect a session name

## Neovim Core
- [!] Files open with folds closed

# Improvements

- Add code snippets for scala
- Srink paths based on package name and common patters:
    - `src`
    - `scala/com/siriusxm/playback`
    - `scala/com/siriusxm/playbackservices`

# Windowline

- [ ] better color to see active buffer
- [ ] fix diagnostics color
- [ ] fix filetype icon color
- [ ] add navic after filename
- [ ] show only file name
- [x] remove rounded corners and effects

# Cursorline

- Better contrast with background

# Statusline

- Better contrast with background

# Git

- Git Worktrees better integration (there is a plugin)

- Pull main while on other branch
- Rebase current branch on top of origin/main
- Change branch and directory at the same time (switch between worktrees)
- Create worktree
- Delete worktree

# Sbt integration

- Run sbt server on fist command
- Run commands agains sbt server and provide a notification with result status
- Open the log window for sbt
- Needs to react to cwd changes

`Sbt` command
`:Sbt formatAll`
`:Sbt! formatAll`
`:Sbt`

- configurable hook to shutdown the server on nvim exit

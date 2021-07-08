# Projectline
[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs)

A program to set the environment for a project

## Dependencies
- [fd](https://github.com/sharkdp/fd)
- [fzf](https://github.com/junegunn/fzf)
- [tmux](https://github.com/tmux/tmux)
- git

The git dependencie is because it reads inside your projects folder looking for folders with .git inside

## Installation

To install projectline you can use this command:
```bash
make install
```

And if you want to install the default config file, you can use this
```bash
make config
```

## Demo
For this demo I'm using this config file in `~/.config/projectline/config.sh`:
```bash
projects_path=~/projects

function before(){ 
    tmux new -d -s $project_name -n editor
    tmux send-keys -t "$project_name:0.0" 'nvim' Enter
    tmux new-window -t $project_name -n terminal
    tmux splitw -h
    tmux select-window -t $session:0
}

function after(){
    tmux a -t $project_name
}
```
![projectline demo](assets/tty.gif "projectline demo")

## TODO
- [ ] Add Hooks for specific languages and tools (Rust, Node, React, Python, Go, etc.)
- [ ] Add a `projectsfile.json` to store project paths, custom hooks for each project
- [ ] Migration to Rust to make faster searchs and parse json easily
- [ ] Add a way to switch between `projectsfile.json` and standard search

## Authors

- [@jmvalenciz](https://www.github.com/jmvalenciz)

<h1 align=center>Dotfiles</h1>

These are my dotfiles for my university setup. I want to warn everyone that I'm *not a developer*, so a lot of my code is *very bad*. I will also not be writing an install script for my dotfiles, since it will probably break and I don't want to maintain it. I'm posting my dots simply as a reference for anyone who's interested in how I did stuff.

- **Window Manager: [Hyprland](hyprland.org)**
- **Bar: [Hyprpanel](https://hyprpanel.com/)**
- **Widgets: [AGS/Astral](https://aylur.github.io/astal/)**
- **Applauncher and dmenu: [Rofi, Wayland Fork](https://github.com/lbonn/rofi)**
- **Terminal: [Kitty](https://sw.kovidgoyal.net/kitty/)**
- **Wallpaper Daemon: [swww](https://github.com/LGFae/swww)**
- **Lock Screen: [Hyprlock](https://github.com/hyprwm/hyprlock)**
- **Distro: [Arch (btw)](https://archlinux.org/)**

Currently still working on:

- Theme Switcher; I am working on a frontend written in AGS, but this is not complete yet.
- More Themes; I have a lot more themes I want to write and I want to further customize some of the ones I have (especially nvim)
- Nvim; my neovim config is written horribly and needs a full rewrite. I want to do it completely in Lua.
- The Bar; I don't like the lack of customizability in hyprpanel, and want to write my own bar in ags, or possibly just fork hyprpanel to add functionality that I want. I have not had the time to complete this yet.
- University Files Management;
    - I need to add functionality for figure management.
    - I want to write scripts for reference management for both internal and external references.
    - I want to write scripts for project management, since I do lots of university-related projects and would like more robust management of those.

The theme switcher works by symlinking a theme to `~/theme`, which the standard config files should read from. In the case of hyprpanel, it runs `hyprpanel st` to set the theme.

Special thanks go out to the following people:

- **Gilles Castel (RIP)**, for his [blog posts](https://castel.dev/) on LaTeX workflow. Most of the scripts I use for managing LaTeX files are slightly modified versions of his scripts.
- The [r/unixporn](https://www.reddit.com/r/unixporn/) community, for having a ton of awesome dots to reference. I've looked at too many people's dots to thank them all, but I'll try to mention as many as I can.
    - idk
    - lol
- [~~Chatgpt~~](https://chatgpt.com/)
- [Windows 11](https://www.microsoft.com/en-us/software-download/windows11), for being so horrible as to get me to switch to linux after using windows for my entire life.

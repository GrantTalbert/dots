#!/bin/python3

from pathlib import Path
import json
import argparse
import subprocess
import random

CONFIG_FILE = Path("~/scripts/theme_switcher/config.json").expanduser()

class Theme():
    def __init__(self, name):
        self.name = name
        self.path = Path(f"~/scripts/theme_switcher/themes/{self.name}").expanduser()
        self.config_files = {
                "hyprland": self.path / f"hypr.conf",
                "rofi": self.path / f"rofi.rasi",
                "nvim": self.path / f"nvim.vim",
                "hyprpanel": self.path / f"hyprpanel.json",
                "kitty": self.path / f"kitty.conf",
                "zathura": self.path / f"zathurarc"
        }
        self.backgrounds = self.path / "backgrounds"


    def touch(self):
        self.path.mkdir(parents=True, exist_ok=True)
        self.backgrounds.mkdir(parents=False, exist_ok=True)

        for key, path in self.config_files.items():
            path.touch(exist_ok=True)


class Themes():
    def __init__(self):
        self.init_json()
        with open(CONFIG_FILE, 'r') as f:
            data = json.load(f)

        self.list = [Theme(name) for name in data['themes']]
        self.active = self.get_theme(data['active'])

    def init_json(self):
        if CONFIG_FILE.exists():
            return
        else:
            CONFIG_FILE.touch()
            initial_data = {"themes": {}}
            with open(CONFIG_FILE, 'w') as f:
                f.write(json.dumps(initial_data, indent=4))

    def update(self):
        data = {
                "themes": [theme.name for theme in self.list],
                "active": self.active.name
                }
        with open(CONFIG_FILE, 'w') as f:
            f.write(json.dumps(data, indent=4))

    def new_theme(self, name):
        theme = Theme(name)
        theme.touch()
        self.list.append(theme)
        self.update()
        subprocess.run(['notify-send', 'Theme Created', f'New theme \"{name}\" successfully created'])

    def activate_theme(self, name):
        symlink_path = Path("~/theme").expanduser()
        theme = self.get_theme(name)

        if symlink_path.exists() or symlink_path.is_symlink():
            symlink_path.unlink()

        symlink_path.symlink_to(theme.path)
        backgrounds = [file for file in theme.backgrounds.iterdir() if file.is_file()]
        background = random.choice(backgrounds)
        
        subprocess.run(['swww', 'img', str(Path(f"~/theme/backgrounds/{background.name}").expanduser())], check=True)
        subprocess.run(['hyprpanel', 'ut', str(Path('~/theme/hyprpanel.json').expanduser())])
        subprocess.run(['notify-send', 'Theme Switched', f'Active theme: {name}'])
        self.active = theme
        self.update()


    def get_theme(self, name):
        for theme in self.list:
            if theme.name == name:
                return theme

    def randomize_background(self):
        backgrounds = [file for file in self.active.backgrounds.iterdir() if file.is_file]
        background = random.choice(backgrounds)
        subprocess.run(['swww', 'img', str(Path(f"~/theme/backgrounds/{background.name}").expanduser())], check=True)

def main():
    themes = Themes()
    parser = argparse.ArgumentParser(description="CLI tool for managing themes")
    parser.add_argument('--new', action='store', type=str, help='Adds a new theme of the given name')
    parser.add_argument('--activate', action='store', type=str, help='Activates the given theme')
    parser.add_argument('--rand', action='store_true', help='Randomizes the current background')
    args = parser.parse_args()

    if args.new:
        themes.new_theme(args.new)
    elif args.activate:
        themes.activate_theme(args.activate)
    elif args.rand:
        themes.randomize_background()

main()

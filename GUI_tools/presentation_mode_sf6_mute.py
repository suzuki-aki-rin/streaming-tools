#!/usr/bin/python3

import tkinter as tk
from tkinter import font
import subprocess
import shlex


APPNAME_SF6 = "Street Fighter 6"

cmd_get_state = "xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode 2>/dev/null"
cmd_presentation_on = "xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -s true"
cmd_presentation_off = "xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/presentation-mode -s false"
cmd_mute_sf6 = f"mute_hide_app.sh {shlex.quote(APPNAME_SF6)} mute shade"
cmd_unmute_sf6 = f"mute_hide_app.sh {shlex.quote(APPNAME_SF6)} unmute unshade"
icon_file = "p.png"


def get_state():
    try:
        args = shlex.split(cmd_get_state)
        ret = subprocess.check_output(
            args,
            text=True,
        )
        return ret.rstrip() == "true"

    except subprocess.CalledProcessError as e:
        print(f"Command failed with return code {e.returncode}")
        raise Exception


def change_state():
    # checkbox on
    if bool_check.get():
        args = shlex.split(cmd_presentation_on)

    # checkbox off
    else:
        args = shlex.split(cmd_presentation_off)

    subprocess.run(args)


def mute_sf6():
    args = shlex.split(cmd_mute_sf6)
    subprocess.run(args)


def unmute_sf6():
    args = shlex.split(cmd_unmute_sf6)
    subprocess.run(args)


root = tk.Tk()
root.title("Broadcast tools")
icon = tk.PhotoImage(file=icon_file)
root.iconphoto(False, icon)
# root.geometry("400x200")

default_font = font.nametofont("TkDefaultFont")
default_font.configure(size=30, family="Cica")


# tk.Label(root, text="presentation-mode")

bool_check = tk.BooleanVar()
bool_check.set(get_state())
check_btn_presentation = tk.Checkbutton(
    root,
    text="presentation-mode",
    variable=bool_check,
    command=change_state,
    indicatoron=False,
    width=20,
    pady=10,
    bg="lightgray",
    selectcolor="lightgreen",
    activebackground="lightgray",
)
check_btn_presentation.pack()

btn_mute = tk.Button(root, text="mute sf6", command=mute_sf6)
btn_mute.pack()

btn_unmute = tk.Button(root, text="unmute sf6", command=unmute_sf6)
btn_unmute.pack()


root.mainloop()

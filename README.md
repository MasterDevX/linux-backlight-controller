# linux-backlight-controller
This is a simple shell script to easily control display backlight brightness at hardware level on linux systems. Script uses ```backlight``` kernel class, see <a href="https://www.kernel.org/doc/Documentation/ABI/stable/sysfs-class-backlight">this</a> for more info.
### Usage
To increase / decrease brightness:
```
sudo ./backlight.sh < + | - > < percentage >
```
Example:
```
sudo ./backlight.sh + 25 # will increase display brightness by 25%
sudo ./backlight.sh - 10 # will decrease display brightness by 10%
```
### Bind to brightness function keys
Most laptops have special function keys on keyboard to control brightness, so you can make something up to run script every time once these buttons are pressed.
For example, if you're using OpenBox window manager, simply open your OpenBox configuration file, find ```<keyboard>``` section and set up new keybind like this:
```
<keybind key="XF86MonBrightnessUp">
    <action name="Execute">
        <command>sudo /usr/bin/bash /path/to/script/backlight.sh + 5</command>
    </action>
</keybind>
<keybind key="XF86MonBrightnessDown">
    <action name="Execute">
        <command>sudo /usr/bin/bash /path/to/script/backlight.sh - 5</command>
    </action>
</keybind>
```
Then apply changes by running:
```
openbox --reconfigure
```
**Note 1:** Usually ```XF86MonBrightnessUp``` and ```XF86MonBrightnessDown``` key names should work, but if they don't, you can find out correct names by running ```xev``` and checking what appears in the console when you press brightness control keys.
For example, I can see the following:
```
# Brightness up key pressed:
state 0x0, keycode 233 (keysym 0x1008ff02, XF86MonBrightnessUp), same_screen YES,

# Brightness down key pressed
state 0x0, keycode 232 (keysym 0x1008ff03, XF86MonBrightnessDown), same_screen YES,
```
**Note 2:** Because this script writes to ```/sys``` directory to control brightness, you will need to run it as root in most cases. So it is a good idea to append the following to your ```/etc/sudoers``` file, so it will not ask for password and will execute script immediately when you run it:
```
your_user_name    ALL=(ALL:ALL) NOPASSWD: /usr/bin/bash /path/to/script/backlight.sh *
```

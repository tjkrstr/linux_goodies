# General Linux Backup

Under most circumstances you want to backup these directories:

- <em><strong>/home/</strong></em> for user data and configuration.
- <em><strong>/etc/</strong></em> for system wide configuration files.
- <em><strong>/var/</strong></em> contains a mix of directories you usually want to backup and those you don't want to backup. See below for a more detailed explanation. 


Directories to consider:

- <em><strong>/usr/local/</strong></em> hand-installed packages (i.e. not installed through apt) are installed here. If you have packages installed here, you may want to backup the whole directory, so you don't have to reinstall them. If the packages themselves aren't important to you, it should be enough to backup /usr/local/etc/ and /usr/local/src/.
- <em><strong>/opt/</strong></em> if you didn't store anything here, you don't need to back it up. If you stored something here, you are in the best position to decide, if you want to back it up.
- <em><strong>/srv/</strong></em> much like /opt/, but is by convention more likely to contain data you actually want to backup.
- <em><strong>/root/</strong></em> stores configuration for the root user. If that is important to you, you should back it up.

## /var/:
<em><strong>/var/</strong></em> contains many files you want to backup under most circumstances, but also some you don't want to backup.


Directories to probably backup:

- <em><strong>/var/lib/</strong></em> this directory contains variable state data for installed applications. Depending on the application you want to backup that state or you don't. If you want to be on the safe side, you can just back up everything. Otherwise you can look at each sub-directory and decide for yourself if the data contained is important enough to you to back it up.
- <em><strong>/var/mail/</strong></em> you normally want to backup local mails.
- <em><strong>/var/www/</strong></em> if your web root is located here and this is the only place where your web content is stored, you want to back it up.
- <em><strong>/var/games/</strong></em> you may want to backup these, if system wide game data is important enough for you (not many games use this storage though).
- <em><strong>/var/backups/</strong></em> usually contains files that are automatically generated from other data that you usually want on a backup, but that would take an unnecessary amount of space in the backup or is otherwise cumbersome to backup. For example dpkg dumps a list of installed packages here, so you can later know which packages to install after restoring the backup. You probably want to backup this.
- <em><strong>/var/spool/cron/crontabs/</strong></em> might contain many commands or a complex schedule, even with dependencies on other systems, that has taken considerable effort to put together.
- <em><strong>/var/local/</strong></em> you normally know if you stored something here and whether you want it on a backup or not.
- <em><strong>/var/opt/</strong></em> see <em><strong>/var/local/</strong></em> or better check if something important is stored here.
- <em><strong>/var/log/</strong></em> depends on whether your logs are important to you and if you have enough space to store them (they might take a lot of backup space over time).


Directories not to backup:
- <em><strong>/var/cache/</strong></em> contrary to the name, some contents of this directory are important, so check each subdirectory individually, as a rule of thumb, everything you put here yourself is important. You also might want to backup /var/cache/debconf/.
- <em><strong>/var/lock/</strong></em> locks usually (always) don't need to be backed up.
- <em><strong>/var/run/</strong></em> contains data that is only important for your running system, i.e. when you shutdown you system, it will not be needed any more.
/var/spool/ (other than /var/spool/cron/crontabs, see above) normally important data shouldn't be stored here, but you might want to check.


## Kubuntu 21.10 (KDE-PLASMA)

The folder contains dot-files from kubuntu. The following is a short description of the structure and role of each file and their location.

### File Overview (Keyboard shortcuts)

The following files store the keyboard shortcuts of KDE Plasma 5 and of some of its associated applications such as Konsole and KWrite.

- ~/.config/kdeglobals
- ~/.config/kglobalshortcutsrc
- ~/.config/khotkeysrc
- ~/.config/kwinrc
- ~/.config/plasma-org.kde.plasma.desktop-appletsrc
- ~/.local/share/kxmlgui5/katepart/katepart5ui.rc
- ~/.local/share/kxmlgui5/konsole/konsoleui.rc
- ~/.local/share/kxmlgui5/konsole/sessionui.rc
- ~/.local/share/kxmlgui5/kwrite/kwriteui.rc

Standard Shortcuts (System Settings > Shortcuts)
- ~/.config/kdeglobals

Global Shortcuts (System Settings > Shortcuts)
- ~/.config/kglobalshortcutsrc

"Custom Shortcuts" (System Settings > Shortcuts)
- ~/.config/khotkeysrc

Konsole
- ~/.local/share/kxmlgui5/konsole/konsoleui.rc
- ~/.local/share/kxmlgui5/konsole/sessionui.rc

KWrite > Settings > Configure Shortcuts... > KWrite
- ~/.local/share/kxmlgui5/kwrite/kwriteui.rc

KWrite > Settings > Configure Shortcuts... > Kate Part
- ~/.local/share/kxmlgui5/katepart/katepart5ui.rc


Among "Global Shortcuts", "Plasma > Activate Application Launcher Widget" is also stored in:

- ~/.config/plasma-org.kde.plasma.desktop-appletsrc

in addition to the common:

- ~/.config/kglobalshortcutsrc

This is because "Activate Application Launcher Widget" can be also set by
Right-click "Application Launcher" > Application Launcher Settings... > Keyboard Shortcuts

The dissociation of Meta key (a.k.a. Windows Key or Apple Command Key) from the Kickoff Application Launcher (a.k.a. Start Menu) is stored in ~/.config/kwinrc

Except "kglobalshortcutsrc" and "khotkeysrc", these files store only custom shortcuts but not default shortcuts, but also store other kinds of preferences. "kglobalshortcutsrc" stores both custom and default shortcuts, but does not store other kinds of preferences. "khotkeysrc" seems similar to "kglobalshortcutsrc".

### File the Preference Files of Keyboard Shortcuts

the following command searches to look for files that contain the keyword 'Meta+', 'Ctrl+' or 'Meta=', searching in the home directory ~.
```console
cd; find . -type f -print0 | xargs -0 grep -El '(Meta\+|Ctrl\+|Meta=)' | perl -pe 's|^\.|~|' | sort
```

~/.local/share/kxmlgui5, is the directory enclosing the files that store the custom keyboard shortcuts of individual applications. I found the other files on my own.
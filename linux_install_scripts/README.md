# INSTALL SCRIPT NOTES  

An install script mainly focused around installing software on debain based systems (may be extended to other distributions in the future). In regards to the installation two levels have been created. A ```minimal``` and a ```custom``` install. The minimal install will mainly consist of installing basic linux tools throught ```apt```. The ```custom``` install will consist of a variety of package types and a more extensive list. 

Tools installed throught ```apt``` have been collected in .list files containing the name of the tools to be installed.

A variety of strategies were considered when installing .deb packages:
<ol>
  <li>Install software like discord, zoom and brave through the snap (snap store). In doing so updating and maintaining the links to .deb package urls would be much easier. The snap store is however proprietary and creates a certain overhead.</li>
  <li>Create a .list file containing the .deb package urls. Use wget to download the different packages into a certain folder. Install the tools by running the <em>$ sudo apt install ./deb_file</em>
  command on all the .deb files in the folder. </li>
  <li>Use gpg keys to install the desired software. Some of the providers have however remove this option.</li>
</ol>

The current script utilizes both strategy 2 and 3. The snap store strategy can however be easily implemented by adding the aformentioned command and use the list of tool names as argument.

## Relevant commands
The following commands are capable of listing intalled packages on a linux (debian) system. Depending on the paramter <em>--installed</em> to display only the packages that are installed on the system. <em>--manual-installed</em> to list the packages that were explicitly installed by a command, either directly, or as dependencies.
```bash
# List apt installed packages 
$ apt list --manual-installed
# List number of installed apt packages
$ apt list --installed | wc -l
# List info about certain package
$ apt show [package_name]

# List snap installed packages
$ snap list
# List info about certain snap package
$ snap info [package_name]
```

The following command is however more relevant as it manages to make a more accurate listing compared to the prior commands excluding almost all default packages. The relevant manifest file may not be present. It can however be fetched from ubuntu releases. NOTE: <em>the commands are not perfect and may omit some packages!</em> ([SORUCE](https://askubuntu.com/questions/2389/how-to-list-manually-installed-packages))

```bash
# Get list of manually installed packages
$ comm -23 <(apt-mark showmanual | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u) > installed.list

# Same command but using aptitude
$ comm -23 <(aptitude search '~i !~M' -F '%p' | sed "s/ *$//" | sort -u) <(gzip -dc /var/log/installer/initial-status.gz | sed -n 's/^Package: //p' | sort -u) > installed.list
```
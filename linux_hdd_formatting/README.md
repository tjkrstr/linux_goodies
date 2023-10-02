# Linux - Handling storage:
The following is a simple description of how to format linux drives via the CLI. It should be noted that the following steps can be made easier using the `fdisk` alternative [cfdisk](https://www.geeksforgeeks.org/cfdisk-command-in-linux-with-examples/) which provides a better CLI interface and overview.


In order to determine what disks are actually present on a system and their paritions either the `lsblk` or the `fdisk -f` command can be used. Select the disk that you wish to format. `fdisk` will be used to list, remove and edit partitions on the specified drive which can be done using the following command:

```bash
$  sudo fdisk /dev/sdb
```

## Delete/Create Partition(s)
If you are connecting your drive for the first time to your Linux system, then you need to create a partition beforehand. To implement this, you can use `fdisk`. In `fdisk` you can type "m" to get a list of possible commands. Some relevant commands include "p" to check the partition table, "n" to create a new partition, "d" to delete the partition, and so on. 

<ol>
  <li>List paritions located on the disk using the "p" command.</li>
  <li>Remove parition(s) using the "d" command. If only one parition is present on the disk this is automatically selected when running the "d" command. Otherwise if multiple partitions are present, when running the "d" command, you will be asked to select the specific partition to delete. </li>
  <li>Reload the parition table ("p" command) to verify that the parition(s) has been deleted</li>
  <li>Run the "w" command to write and save changes made to the disk</li>
  <li>Re-enter fdisk and create a new parition using the "n" command. When running this command create a primary parition, select a partition number, and the size of the first and last sector. (if selecting the default values for the first and last sector the entire disk size will be utilized)</li>
</ol>

Once a partition has been created, you can use the `mkfs.<format>` command to format the disk. <strong>NOTE:</strong> for NTFS, you can add the -f or -Q flag to perform a quick format):

```bash
$  sudo mkfs.<format> /dev/sdb.
$  sudo mkfs.ntfs -f /dev/sdb.
```

Once the disk has been sucesfully formatted we can use the `file` command to actually check if the information we specified has been applied correctly (this command can also be used on a certain parition for instance /dev/sdb1):

```bash
#Disk
$  sudo file -sL /dev/sdb
#OUTPUT: 
#/dev/sdb: DOS/MBR boot sector; partition 1 : ID=0xee, start-CHS (0x0,0,2), end-CHS (0x3ff,255,63), startsector 1, 976773167 sectors, extended partition table (last)
```

## Mount disks
Use `lsblk` to get the necessary information regarding the drive and use that information to mount the desired drive.

Mount the drive to the system (usually /media but /mnt or other locations are possible). Make a directory that the media is going to be mounted to and then mount the drive to that directory:

```bash
$  (sudo) mkdir /media/hdd
$  sudo mount /dev/sdb /media/hdd
```

When the device is restarted the drive is unmounted. Hence if we with a more permanent solution we need to add the drive to fstab. First fetch the necessary information and then (using sudo permissions) add the following in /etc/fstab:

```bash
<file system> <mount point> <type> <options> <dump> <pass>

/dev/disk/by-uuid/9f504bc6-56e3-4ed9-96f8-7a215d7e2b67 /media/hdd ntfs defaults 0 0
```

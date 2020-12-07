## Ubuntu Prerequisites

```shell script
# list disks
sudo fdisk -l

# access target disk
sudo fdisk /dev/vda

# list all partitions
Command (m for help): p

# delete primary partition
Command (m for help): d

# new primary partition // may leave 20GB
Command (m for help): n

# new second partition for osd
Command (m for help): n

# save and sync disk
Command (m for help): w

# format to ext4
sudo mkfs.ext4 /dev/vda2
```

## Install Rook

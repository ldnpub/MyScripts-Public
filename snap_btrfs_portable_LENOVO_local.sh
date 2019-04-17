#!/bin/bash
# Creation de la première sauvegarde
#   btrfs subvolume snapshot -r /home /home/BACKUP-new
#   btrfs subvolume snapshot -r / /ROOT_SNAP/root_snap_ro => doit etre read-only
#   btrfs send ROOT_SNAP/root_snap_20171312_ro | btrfs receive /run/media/ldnpub/Snapshots/MC_SV_Snapshot/
sync
sudo mv -f /SNAPSHOTS/root_snap_root_ro/ /SNAPSHOTS/root_snap_root_ro_OLD
sudo mv -f /SNAPSHOTS/root_snap_etc_ro/ /SNAPSHOTS/root_snap_etc_ro_OLD

sudo sudo btrfs subvolume snapshot -r / /SNAPSHOTS/root_snap_root_ro
sudo sudo btrfs subvolume snapshot -r /etc/ /SNAPSHOTS/root_snap_etc_ro
sync
exit 0



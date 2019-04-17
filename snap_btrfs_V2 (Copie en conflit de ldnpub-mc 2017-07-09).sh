#!/bin/bash
# Creation de la première sauvegarde
#   btrfs subvolume snapshot -r /home /home/BACKUP-new
#   btrfs subvolume snapshot -r / /ROOT_SNAP/root_snap_ro => doit etre read-only
#   btrfs send ROOT_SNAP/root_snap_20171312_ro | btrfs receive /run/media/ldnpub/Snapshots/MC_SV_Snapshot/
btrfs subvolume delete /ROOT_SNAP/root_snap_ro_W3

mv -v /ROOT_SNAP/root_snap_ro_W2 /ROOT_SNAP/root_snap_ro_W3
mv -v /ROOT_SNAP/root_snap_ro_W1 /ROOT_SNAP/root_snap_ro_W2

sync
btrfs subvolume snapshot -r / /ROOT_SNAP/root_snap_ro_W1


exit 0



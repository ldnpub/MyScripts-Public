#!/bin/bash
# Creation de la première sauvegarde
#   btrfs subvolume snapshot -r /home /home/BACKUP-new
#   btrfs subvolume snapshot -r / /ROOT_SNAP/root_snap_ro => doit etre read-only
#   btrfs send ROOT_SNAP/root_snap_20171312_ro | btrfs receive /run/media/ldnpub/Snapshots/MC_SV_Snapshot/
timestamp="$(date +%Y-%m-%d_%H:%M)"
btrfs subvolume snapshot -r / /ROOT_SNAP/root_snap_ro_$timestamp
sync
btrfs subvolume delete /ROOT_SNAP/root_snap_ro_Week-3

# Envoi sur le disque dur de sauvegarde
mount="/run/media/ldnpub/Snapshots"
if grep -qs "$mount" /proc/mounts; then #on check si le DD de sauvegarde est monté
  # Premiere Backup
  #     btrfs send /ROOT_SNAP/root_snap_ro_Week-1 | btrfs receive /run/media/ldnpub/Snapshots/MC_SV_Snapshot/
  # Version update
  btrfs send -p /ROOT_SNAP/root_snap_ro_Week-1 /ROOT_SNAP/root_snap_ro_$timestamp | btrfs receive -v /run/media/ldnpub/Snapshots/MC_SV_Snapshot/ &&\
  echo "1"
  mv /ROOT_SNAP/root_snap_ro_Week-2 /ROOT_SNAP/root_snap_ro_Week-3
  mv /ROOT_SNAP/root_snap_ro_Week-1 /ROOT_SNAP/root_snap_ro_Week-2
  mv /ROOT_SNAP/root_snap_ro_$timestamp /ROOT_SNAP/root_snap_ro_Week-1
  exit 0
else
  exit 1
fi

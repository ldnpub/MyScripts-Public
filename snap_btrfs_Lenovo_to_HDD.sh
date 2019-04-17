#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
date=$(date +%Y-%m-%d)

# the path to the partition mount point that we are backing up
source_partition=/
etc_partition=/etc

# where backup snapshots will be stored on the local partition
# this is needed for incremental backups
source_snapshot_dir=/SNAPSHOTS

# where backups will be stored on the backup drive
target_snapshot_dir=/run/media/rodolphe/Snapshots/LENOVO_Snapshot

if [ ! -d $source_snapshot_dir ]; then
    echo 'Creating initial snapshot...'
    mkdir --parents $source_snapshot_dir $target_snapshot_dir

    # create a read-only snapshot on the local disk
    btrfs subvolume snapshot -r $source_partition $source_snapshot_dir/root_$date
    btrfs subvolume snapshot -r $etc_partition $source_snapshot_dir/etc_$date

    # clone the snapshot as a new subvolume on the backup drive
    # you could also pipe this through ssh to back up to a remote machine
    btrfs send $source_snapshot_dir/root_$date | pv | \
        btrfs receive $target_snapshot_dir
    btrfs send $source_snapshot_dir/etc_$date | pv | \
        btrfs receive $target_snapshot_dir

elif [ ! -d $source_snapshot_dir/root_$date ]; then
    echo 'Creating root volume snapshot...'

    # create a read-only snapshot on the local disk
    btrfs subvolume snapshot -r $source_partition $source_snapshot_dir/root_$date

    # get the most recent snapshot
    previous_root=$(ls --directory $source_snapshot_dir/root_* | tail -n 1)
    echo $previous_root

    # send (and store) only the changes since the last snapshot
    #btrfs send $source_snapshot_dir/root_$date | pv | \
    btrfs send -p $previous_root $source_snapshot_dir/root_$date | pv | \
            btrfs receive $target_snapshot_dir

elif [ ! -d $source_snapshot_dir/etc_$date ]; then
    echo 'Creating etc volume snapshot...'

    # create a read-only snapshot on the local disk
    btrfs subvolume snapshot -r $etc_partition $source_snapshot_dir/etc_$date

    # get the most recent snapshot
    previous_etc=$(ls --directory $source_snapshot_dir/etc_* | tail -n 1)

    # send (and store) only the changes since the last snapshot
    btrfs send -p $previous_etc $source_snapshot_dir/etc_$date | pv | \
    #btrfs send $source_snapshot_dir/etc_$date | pv | \
        btrfs receive $target_snapshot_dir
fi

echo 'Cleaning up...'

# keep the 3 most recent snapshots on the source partition
#ls --directory $source_snapshot_dir/* | \
#    head --lines=-3 | \
#    xargs --no-run-if-empty --verbose \
#    btrfs subvolume delete --commit-after

# keep the 28 most recent snapshots on the backup partition
#ls --directory $target_snapshot_dir/* | \
#    head --lines=-28 | \
#    xargs --no-run-if-empty --verbose \
#    btrfs subvolume delete --commit-after
#

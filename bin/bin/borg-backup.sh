#!/bin/sh
# See: https://jstaf.github.io/2018/03/12/backups-with-borg-rsync.html

# Setting this, so the repo does not need to be given on the commandline:
# export BORG_REPO=ssh://username@example.com:2022/~/backup/main
export BORG_REMOTE_PATH=/usr/local/bin/borg1/borg1
export BORG_REPO=zh1032@zh1032.rsync.net:work_backup
repo="zh1032@zh1032.rsync.net:backup"
prefix="$USER-hp-elitebook-"

# See the section "Passphrase notes" for more infos.
export BORG_PASSCOMMAND='pass Backup/rsync_passphrase'
export BORG_RSH="ssh -i ~/.ssh/borg-append-only"

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Starting backup"
/usr/bin/notify-send -i /home/een023/.config/borg/borg.png "Borg Backup" "Starting backup"

# Backup the most important directories into an archive named after
# the machine this script is currently running on:

borg create                                     \
    --verbose                                   \
    --filter AME                                \
    --list                                      \
    --stats                                     \
    --show-rc                                   \
    --compression lz4                           \
    --exclude-caches                            \
    --exclude '/home/*/.cache/*'                \
    --exclude '/home/een023/.config/nnn/mounts' \
    --exclude '/home/een023/OneDrive'           \
    --exclude '/home/een023/Dropbox'
    --exclude '/home/een023/BoxSync'            \
    --exclude '/home/een023/Insync'             \
    --exclude '/home/een023/miniconda3'         \
    --exclude '/home/een023/.mozilla'           \
    --exclude '/home/een023/.vscode-insiders'   \
    --exclude '/home/een023/.config/Code - Insiders'   \
    --exclude '/var/cache/*'                    \
    --exclude '/var/tmp/*'                      \
                                                \
    ::'{hostname}-{now}'                        \
    /home                                       \

backup_exit=$?

info "Pruning repository"
/usr/bin/notify-send -i /home/een023/.config/borg/borg.png "Borg Backup" "Pruning repository"

# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machines' archives also:

borg prune                          \
    --list                          \
    --prefix '{hostname}-'          \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  6               \

prune_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 0 ]; then
    info "Backup and Prune finished successfully"
    /usr/bin/notify-send -i /home/een023/.config/borg/borg.png "Borg Backup" "Backup and Prune finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    info "Backup and/or Prune finished with warnings"
    /usr/bin/notify-send -i /home/een023/.config/borg/borg.png "Borg Backup" "Backup and/or Prune finished with warnings"
else
    info "Backup and/or Prune finished with errors"
	/usr/bin/notify-send -i /home/een023/.config/borg/borg.png "Borg Backup" "Backup and/or Prune finished with errors"
fi

exit ${global_exit}

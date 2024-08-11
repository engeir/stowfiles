# #!/bin/bash
# # What OS are we running?
# if [[ $(uname) == "Darwin" ]]; then
#     export MACHINE="Darwin"
#
# elif command -v freebsd-version > /dev/null; then
#     export MACHINE="FreeBSD"
#
# elif [[ $(uname) == "Linux" ]]; then
#     export MACHINE="Ubuntu"
#
# else
#     echo 'Unknown OS!'
# fi

# # Do we have systemd on board?
# if command -v systemctl > /dev/null; then
#     source "$ZSH_CUSTOM"/os/systemd.zsh
# fi

# # Ditto Kubernetes?
# if command -v kubectl > /dev/null; then
#     source "$ZSH_CUSTOM"/os/kubernetes.zsh
# fi

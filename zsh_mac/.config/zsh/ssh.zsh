#!/bin/zsh
# Check if command returns 0 in if statement
if command -v "keychain -Q" &>/dev/null; then
    /home/een023/bin/start-keychain-expect
fi
# setup ssh-agent
SSH_ENV=$HOME/.ssh/environment

# start the ssh-agent
function start_agent {
    # Run expect script
    /home/een023/bin/start-agent-expect
}

if [ -f "$SSH_ENV" ]; then
    . "$SSH_ENV" >/dev/null
    ps -ef | grep "$SSH_AGENT_PID" | grep ssh-agent$ >/dev/null || {
        start_agent
    }
else
    start_agent
fi

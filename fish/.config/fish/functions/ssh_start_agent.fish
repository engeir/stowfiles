function ssh_start_agent --description 'Start ssh-agent if it does not have a PID'
    # Source SSH_ENV environment variable from the fish shell
    if test -f $SSH_ENV
        source $SSH_ENV >/dev/null
        command ps -ef | grep $SSH_AGENT_PID | grep 'ssh-agent$' >/dev/null || start_agent
    else
        start_agent
    end
end

-- config.ssh_domains
return {
    {
        -- This name identifies the domain
        name = "vultr",
        -- The hostname or address to connect to. Will be used to match settings
        -- from your ssh config file
        remote_address = "136.244.79.234",
        -- The username to use on the remote host
        username = "root",
    },
}

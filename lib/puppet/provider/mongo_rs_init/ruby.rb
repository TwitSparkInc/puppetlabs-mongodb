Puppet::Type.type(:mongo_rs_init).provide(:ruby) do
    desc "Ruby implementation for MongoDB replication initialization"

    # Initializes the replica set of MongoDB
    def create

        info("Initializing %s MongoDB replica set" % resource[:host])

        command = "echo 'rs.initiate()' | mongo #{resource[:host]} --quiet"
        result = `#{command}`

        info("Sleeping 90 seconds for the replica set to become active")
        sleep(90)

    end

    def destroy
        error("Destroying a MongoDB replica set init is not possible")
    end

    def exists?

        command = "echo 'rs.status()' | mongo #{resource[:host]} --quiet"
        notice(command)
        replicationStatus = `#{command}`

        if (replicationStatus.index('"ok" : 1') != nil)
            info("MongoDB %s replica set is initialized" % resource[:host])
            true
        else
            info("MongoDB %s replica needs to be initialized" % resource[:host])
            false
        end
    end

end

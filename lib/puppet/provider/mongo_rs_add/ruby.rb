Puppet::Type.type(:mongo_rs_add).provide(:ruby) do
    desc "Ruby implementation for adding MongoDB nodes to a replica set"

    # adding the node
    def create

        info("Adding node %s to replica set of host %s" % [resource[:member], resource[:host]])

        command = "echo 'rs.add(\"#{resource[:member]}\", {arbiterOnly: #{resource[:arbiteronly]}})' | mongo #{resource[:host]} --quiet"
        notice('constructing command')
        notice(command)
        replicationStatus = `#{command}`
        notice(replicationStatus)

    end

    def destroy
        error("Removing a node from a replica set is not yet possible")
    end

    def exists?

        command = "echo 'rs.status()' | mongo #{resource[:host]} --quiet"
        replicationStatus = `#{command}`

        if (replicationStatus.index( resource[:member]) != nil)
            info("Member %s is present in replica set for host %s" % [resource[:member], resource[:host]])
            true
        else
            info("Member %s is NOT present in replica set for host %s" % [resource[:member], resource[:host]])
            false
        end
    end

end

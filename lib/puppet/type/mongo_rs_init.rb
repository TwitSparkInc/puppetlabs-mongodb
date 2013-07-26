Puppet::Type.newtype(:mongo_rs_init) do
   @doc = "Initialize a replica set"
   ensurable

   newparam(:name) do
      desc "The name of the replication init"
   end

   newparam(:provider) do
       validate do |value|
           resource[:provider] = "ruby"
       end
   end

   newparam(:host)

end

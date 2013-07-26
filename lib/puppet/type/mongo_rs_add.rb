Puppet::Type.newtype(:mongo_rs_add) do
   @doc = "Add a server to the replica set"
   ensurable

   newparam(:name) do
      desc "The name"
   end

   newparam(:host)

   newparam(:arbiteronly)

   newparam(:provider) do
       validate do |value|
           resource[:provider] = "ruby"
       end
   end

   newparam(:member) do
       desc "Address of the member to add"
   end

end

# What?
Do meta stuff with containers

# Like What?
Want to react to docker containers coming up and down.  
With this we can provide some fake-dns, splunk forwarding, nginx reverse proxying, status pages, service discovery.

# Need to add a gateway into Boot2docker
Makes this range of ips accessible through the boot2docker gateway  

```
sudo route -n add 172.17.0.0/16 `boot2docker ip`
 ```
Now you should be able to ping the ips created by docker through boot2docker

# Customer Resolver (OSX)
Create a custom resolver for `*.jacob`

```
sudo echo 'nameserver `boot2docker ip`' > /etc/resolver/jacob
sudo echo 'port 5353' >> /etc/resolver/jacob
```

Now your osx should be trying to use something running on port 5353 inside the boot2docker vm to resolve the `*.jacob` domains

So what we should do is create a dnsmasq container running on 5353. This dnsmasq container should then listen to other containers joining, read some meta about them.
Then update its dns entry.

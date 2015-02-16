# What is this?
A Reverse Proxy and DNS resolver with containers. Its aim is to be like pow.cx.

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
```

Now your osx should be trying to use something running on port 53 inside the boot2docker vm to resolve the `*.jacob` domains

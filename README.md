# What is this?
A Reverse Proxy and DNS resolver with containers. Its aim is to be like pow.cx.

# Need to add a gateway into Boot2docker
Makes this range of ips accessible through the boot2docker gateway  

```
sudo route -n add 172.17.0.0/16 `boot2docker ip`
 ```
Now you should be able to ping the ips created by docker through boot2docker

# Customer Resolver (OSX)
Create a custom resolver for `*.web`

```
sudo echo 'nameserver `boot2docker ip`' > /etc/resolver/web
```

Now OSX will be trying to resolve `.web` through the resolver running on port 53 inside the boot2docker vm.

```yaml
app:
  build: app
  environment:
    DOCKER_HOST: unix:///var/run/docker.sock
    VIRTUAL_HOST: app
    VIRTUAL_HOST: 5050
  ports:
    - "5050"
```

You can now hit `app.web` in your browser. This will hit the Nginx reverse proxy and proxy_pass onto app on port 5050.


# Bifbam
Simplify local development with docker. Think of it as Pow on Docker.

## What is this?
Fiddling around with IP addresses and unknown ports in docker is confusing.

Bifbam makes it easy!

Here is what you're probably doing now:

```
> fig up
# Ok my containers didn't blow up, let's inspect the site in the browser
> docker ps
CONTAINER ID        IMAGE                    COMMAND             CREATED             STATUS PORTS NAMES
138cf74f5472        app:latest               "/start.sh"         13 minutes ago      Up 13 minutes        0.0.0.0:49155->5050/tcp   services_app_1
# Confusing ports and whats boot2dockers ip again?
> curl http://`boot2docker ip`:49155
Bif! Bam!
```

That sucked. What if it could be like this?

```
> fig up
> curl http://app.web
Bif! Bam!
```

A Reverse Proxy and DNS resolver with containers. It's like Pow.cx's younger brother who heard about docker once.

## Installation

1. Create a docker-compose/fig.yml:
2. `fig up`
3. Setup gateway for Boot2docker
4. Setup resolvers for Bifbam
5. Configure your app

Here is an example docker-compose/fig.yml:
```
dns:
  image: dekz/bifbam:dns
  environment:
    VIRTUAL_HOST: dns
  privileged: true
  volumes:
    - /var/run/docker.sock:/var/run/docker.sock
  ports:
    - "53:53/udp"
rp:
  image: dekz/bifbam:rp
  environment:
    VIRTUAL_HOST: rp
  privileged: true
  volumes:
    - /var/run/docker.sock:/var/run/docker.sock
  ports:
    - "80:80"
    - "443:443"
```

### Setup a gateway into Boot2docker
Makes the Boot2docker range of ips accessible.

```
> sudo route -n add 172.17.0.0/16 `boot2docker ip`
```
Now you should be able to ping the ips created by docker through boot2docker

Note: You will need to perform this every reboot.

### Setup Resolver for Bifbam (OSX)
Create a custom resolver for `*.web`

```
> sudo echo 'nameserver `boot2docker ip`' > /etc/resolver/web
```

Now OSX will be trying to resolve `.web` through the resolver running on port 53 inside the boot2docker vm.


### Configure your app

```yaml
app:
  build: app
  environment:
    VIRTUAL_HOST: app
    VIRTUAL_PORT: 5050
  ports:
    - "5050"
```

After a fig up you can now hit `app.web` in your browser.

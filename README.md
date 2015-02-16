# Bifbam
Simplify local development with docker

## What is this?
Once the containers are up and running, interacting with them from the browser or terminal is not super simple.

Let's try out an example:

```
> fig up
# Check Docker?
> docker ps
CONTAINER ID        IMAGE                    COMMAND             CREATED             STATUS PORTS NAMES
138cf74f5472        app:latest               "/start.sh"         13 minutes ago      Up 13 minutes        0.0.0.0:49155->5050/tcp   services_app_1
# ??
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

1. Clone this repo
2. `fig build`
3. `fig up`
4. Setup gateway for Boot2docker
5. Setup resolvers for Bifbam
6. Configure your app

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

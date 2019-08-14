# Tor in a Docker Jail

This is a Tor client (SOCKS proxy), it will open a SOCKS gate at `:9050`.

## Usage

Just spawn a container and forward a host's port into the container at `:9050`, eg.:

    docker run --rm -p 127.0.0.1:1234:9050 binfalse/tor

This binds the container's `:9050` to the localhost's `:1234`. You should now be able to access it, eg. using `curl`:

    curl --socks5 localhost:1234 https://ip.binfalse.de

## Modify Configuration

The default configuration is copied into the image at compile time, it can be found at [the GitHub repository binfalse/docker-tor:torrc](https://github.com/binfalse/docker-tor/blob/master/torrc).

However, you're free to override the settings with your preferences by providing some environment variables:

* `Log` specify the log level (`debug`, `info`, `notice`, `warn`, or `err`, default: `notice`)
* `SocksPort` change the SOCKS port (default: 9050)
* `CircuitBuildTimeout` max time to wait when building circuits (in seconds)
* `NumEntryGuards` number of entry guards to use (defaults to 8)
* `ControlPort` open a control port at the specified address
* `HashedControlPassword` allow connections on the control port if they present the hashed password
* `NewCircuitPeriod` consider to build a new circuit (seconds)
* `KeepalivePeriod` send a padding keepalive cell for firewalls (seconds)
* `ExcludeNodes` list of nodes to avoid when building a circuit
* `ExcludeExitNodes` list of nodes to never use as an exit node
* `ExitNodes` list of nodes to use as exit node
* `StrictNodes` is `ExcludeNodes` a strict list?

(consult [the torrc man page for more information](https://manpages.debian.org/stable/tor/torrc.5.en.html))

To for example start a Tor gate with a min log level of `err` and exits nodes preferably in either Sweden or France, you may call the following command line:

    docker run -it -e Log=err \
                   -e ExitNodes="{se},{fr}" \
                   --rm -p 127.0.0.1:1234:9050 \
                   binfalse/tor


This makes is for example possible to spawn a number of containers with exit nodes in different countries!
Here is an example using [DockerCompose](https://docs.docker.com/compose/):

    version: '3'
    services:
      tor-germany:
        image: binfalse/tor
        restart: unless-stopped
        environment:
          - ExitNodes={de}
      tor-france:
        image: binfalse/tor
        restart: unless-stopped
        environment:
          - ExitNodes={fr}
      tor-unitedkingdom:
        image: binfalse/tor
        restart: unless-stopped
        environment:
          - ExitNodes={gb}
      tor-russia:
        image: binfalse/tor
        restart: unless-stopped
        environment:
          - ExitNodes={ru}
      [...]

Thus, your application is then able dynamically and quickly swith the exit country :)


The number of environment variables is of course limited. If you need something else, feel free to create a pull request at [the GitHub repository binfalse/docker-tor](https://github.com/binfalse/docker-tor/).

You can of course also deploy your own `torrc`!
Just mount (`-v`) your own `torrc` (eg `/path/to/your/torrc`) on top of the shipped one:

    docker run --rm -v /path/to/your/torrc:/etc/tor/torrc -p 127.0.0.1:1234:9050 binfalse/tor



# Tor in a Docker Jail

This is a Tor client (SOCKS proxy), it will open a SOCKS gate at `:9050`.

## Usage

Just spawn a container and forward a host's port into the container at `:9050`, eg.:

    docker run --rm -p 127.0.0.1:1234:9050 binfalse/tor

This binds the container's `:9050` to the localhost's `:1234`. You should now be able to access it, eg. using `curl`:

    curl --socks5 localhost:1234 https://ip.binfalse.de

## Modify Tor Settings

The default configuration is copied into the image at compile time, it can be found at [the GitHub repository binfalse/docker-tor:torrc](https://github.com/binfalse/docker-tor/blob/master/torrc).

However, you're free to override the settings with your preferences.
Just mount (`-v`) your own `torrc` (eg `/path/to/your/torrc`) on top of the shipped one:

    docker run --rm -v /path/to/your/torrc:/etc/tor/torrc -p 127.0.0.1:1234:9050 binfalse/tor



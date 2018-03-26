# ctfs

Dockerized CTF challenges deployed in Docker Swarms.

[![demo](https://asciinema.org/a/vyvxNVS6bye3tmjvGfK9XmL3w.png)](https://asciinema.org/a/vyvxNVS6bye3tmjvGfK9XmL3w?autoplay=1)

## Setup (Infrastructure)

The service requires one or more 
[Docker Swarm](https://docs.docker.com/engine/swarm/) capable hosts.
Create and provision these servers using either 
[Docker Machine](https://docs.docker.com/machine/) or use
[Docker Cloud](https://docs.docker.com/docker-cloud/)'s
Bring-Your-Own-Server (BYOS) service to enroll existing hosts. If deploying
fresh servers for a BYOS deployment, the [BYOS setup script](./setup-byos.sh)
can automate part of the process for Ubuntu 16.04 LTS servers.

Any cloud firewalls must permit incoming connections to the ports exposed
for the various challenges.

## Setup (Challenges)

Build challenges in Docker containers. Docker Swarm requires that the images
must be published to a Docker registry. Add each service to the
[docker-compose.yml](./docker-compose.yml) configuration file with the proper
exposed ports, environment variables, secrets, etc.

### Challenge Templates

* [Crypto (Python)](https://github.com/glarsen/apex-crypto-chosen)
* [Misc (Python)](https://github.com/glarsen/apex-misc-hello)
* [Pwn (C)](https://github.com/glarsen/apex-pwn-ret2lost)

## Deployment

Start:
`docker stack deploy --with-registry-auth -c docker-compose.yml CTF_NAME`

Update:
`docker service update SERVICE_NAME`

Stop:
`docker stack rm CTF_NAME`

## Security Recommendations

To reduce Denial of Service pressure, set an upper limit on connections
from a single IP address to the docker services:

`iptables -I DOCKER-USER -p tcp --syn --match multiport --dports 8000:8999 -m connlimit --connlimit-above 3 --connlimit-mask 128 -j REJECT --reject-with tcp-reset`

As a precautionary measure, host these services on "empty" instances that
cannot communicate with any other peers.


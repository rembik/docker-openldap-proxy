# OpenLDAP Proxy Container

Runs [OpenLDAP proxy](https://www.openldap.org/software/man.cgi?query=slapd) on top of the [CentOS 7](https://store.docker.com/images/centos/) as base system.

## Dockerfile

[`rembik/docker-openldap-proxy` Dockerfile](https://github.com/rembik/docker-openldap-proxy/blob/master/Dockerfile)

## How to rebuild an extended image

After pulling this repository and changing the Dockerfile first build the new image locally to test it.
Optionally specify the repository and tag at which to save the new image if the build succeeds.
```shell
cd /path/to/Dockerfile
docker build -t rembik/openldap-proxy:0.1.0 -t rembik/openldap-proxy:latest
```

If this Git repository is pushing back to the server, DockerHub will automatically build this image.
For manually push the locally build to the DockerHub use the docker cli.

```shell
$ docker login
```

```shell
$ docker push rembik/openldap-proxy:0.1.0
```

## How to use this image

Create a docker-compose.yml file like example content below:

```yaml
my_openldap_proxy:
  image: rembik/openldap_proxy:latest
  container_name: openldap_proxy
  ports:
    - '389:389'
    - '636:636'
  volumes:
    - shared_data_volume:/root/openldap_proxy/data
    - shared_certs_volume:/root/openldap_proxy/certs
  command: bash -l -c "cd /root/openldap_proxy && /usr/sbin/slapd -h 'ldap:/// ldapi:/// ldaps:///' -g ldap -u ldap -d 2"
```
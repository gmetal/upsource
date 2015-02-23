Upsource image
=============

Brings the Upsource repository browser and code review
tool to Ubuntu using the phusion/baseimage image.

To use it: docker pull gmetal/upsource

The Upsource version is **1.0.12551**. It is installed
in /usr/local/upsource.

Because the normal upsource starting script is non-blocking,
a new script has been created, so that everything runs 
smoothly inside the docker container.

The script is /usr/local/upsource/bin/startme.sh, and accepts
one parameter, which is the base URL to use by upsource (e.g. the one
which you will use in your browser). You also configure this the
first time the image is initialised.

The data directory of upsource has been exposed as a volume:
/usr/local/upsource/conf/data

You can create a named container:
docker create -v /usr/local/upsource/conf/data --name upsource_data gmetal/upsource

Then use the named container for storing persistent data:
docker run -p 8081:8081 --volumes-from upsource_data   gmetal/upsource /usr/local/upsource/bin/startme.sh http://upsource.local/

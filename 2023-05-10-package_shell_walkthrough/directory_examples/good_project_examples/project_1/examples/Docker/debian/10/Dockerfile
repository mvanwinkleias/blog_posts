FROM debian:10

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y -y \
        build-essential \
        fakeroot

CMD /project_1/dist/Docker/debian/10/build-dist.sh

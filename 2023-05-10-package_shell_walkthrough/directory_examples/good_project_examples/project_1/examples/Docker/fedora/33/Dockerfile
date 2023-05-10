FROM fedora:33

RUN yum -y update && \
    yum -y install && \
        make \
        rpm-build \
        fakeroot

CMD /project_1/dist/Docker/fedora/33/build-dist.sh

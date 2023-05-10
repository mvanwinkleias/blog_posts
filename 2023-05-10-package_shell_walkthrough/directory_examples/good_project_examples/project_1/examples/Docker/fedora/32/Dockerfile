FROM fedora:32

RUN yum -y update && \
    yum -y install \
        make \
        rpm-build \
        fakeroot

CMD /project_1/dist/Docker/fedora/32/build-dist.sh

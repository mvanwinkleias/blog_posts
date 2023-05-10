FROM fedora:31

RUN yum -y update && \
    yum -y install \
        make \
        rpm-build \
        fakeroot

CMD /project_1/dist/Docker/fedora/31/build-dist.sh

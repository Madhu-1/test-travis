ARG ARCH
FROM ceph/ceph:v14.2
RUN yum install go -y
COPY main.go main.go
RUN CGO_ENABLED=0 GOOS=linux GOARCH=${ARCH} go build  main.go
COPY main /usr/bin/main

ENTRYPOINT [ "/usr/bin/main" ]

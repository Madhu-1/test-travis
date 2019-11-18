ARG arch
FROM ceph/ceph:v14.2
RUN yum install go -y
COPY main.go main.go
RUN CGO_ENABLED=0 GOOS=linux GOARCH=${arch} go build -o /usr/bin/main main.go

ENTRYPOINT [ "/usr/bin/main" ]

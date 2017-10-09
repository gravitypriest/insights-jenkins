FROM centos:7
MAINTAINER Lindani Phiri

RUN yum update -y && \
    yum install -y golang openscap-scanner && \
    yum clean all

WORKDIR /var/lib/image-inspector

COPY .  /go/src/github.com/openshift/image-inspector

RUN GOBIN=/usr/bin \
    GOPATH=/go \
    CGO_ENABLED=0 \
    go install -a -installsuffix cgo /go/src/github.com/openshift/image-inspector/cmd/image-inspector.go && \
    mkdir -p /var/lib/image-inspector

EXPOSE 8080

WORKDIR /var/lib/image-inspector

ENTRYPOINT ["/usr/bin/image-inspector"]

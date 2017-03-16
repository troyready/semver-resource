FROM concourse/static-golang

ADD scripts/local /go/local

RUN mkdir -p src/github.com/concourse && \
    cd src/github.com/concourse && \
    git clone https://github.com/troyready/semver-resource.git

CMD ["/bin/bash", "/go/local"]

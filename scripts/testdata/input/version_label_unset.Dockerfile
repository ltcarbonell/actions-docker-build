# FAIL: PRODUCT_VERSION is expected and is the name of the build arg, not VERSION
# This dockerfile should not set the version label
FROM alpine:latest AS default

ARG BIN_NAME
# Export BIN_NAME for the CMD below, it can't see ARGs directly.
ENV BIN_NAME=$BIN_NAME

ARG VERSION
ARG PRODUCT_REVISION
ARG PRODUCT_NAME=$BIN_NAME
# TARGETOS and TARGETARCH are set automatically when --platform is provided.
ARG TARGETOS TARGETARCH

LABEL maintainer="Team RelEng <team-rel-eng@hashicorp.com>"
LABEL version=$VERSION
LABEL revision=$PRODUCT_REVISION

COPY dist/$TARGETOS/$TARGETARCH/$BIN_NAME /bin/

USER 100
CMD ["/bin/$BIN_NAME", "default"]

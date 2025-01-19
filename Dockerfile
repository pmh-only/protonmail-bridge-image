FROM alpine AS build

WORKDIR /app

RUN apk add make git pkgconfig bash go libsecret-dev

ARG VERSION

RUN git clone --depth 1 --branch v${VERSION} https://github.com/ProtonMail/proton-bridge.git .

RUN sed -i -e 's/127\.0\.0\.1/0.0.0.0/' internal/constants/constants.go

RUN make build-nogui

FROM alpine AS runtime

WORKDIR /app

RUN apk add --no-cache libsecret && \
  addgroup -g 1000 proton && \
  adduser -D -h /data -H -G proton -u 1000 proton && \
  mkdir /data && chown 1000:1000 /data

USER 1000:1000

COPY --from=build --chown=1000:1000 /app/bridge /app/bridge

ENTRYPOINT [ "/app/bridge" ]

CMD [ "-n", "-l", "info" ]

FROM haskell:9.2.4

WORKDIR /build
COPY . .

RUN stack setup
RUN stack test


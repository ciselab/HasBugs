FROM haskell:9.0.2

WORKDIR /build
COPY . .

RUN stack setup
RUN stack test


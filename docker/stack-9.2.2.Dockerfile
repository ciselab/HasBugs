FROM haskell:9.2.2

WORKDIR /build
COPY . .

RUN stack setup
RUN stack test


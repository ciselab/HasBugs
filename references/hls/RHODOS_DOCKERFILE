FROM haskell:8.10.7

WORKDIR /build
COPY . .

RUN stack setup
RUN stack test


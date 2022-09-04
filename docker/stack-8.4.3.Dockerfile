FROM haskell:8.4.3

WORKDIR /build
COPY . .

RUN stack setup
RUN stack test


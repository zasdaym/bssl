FROM ubuntu:22.04 AS builder
WORKDIR /app
RUN apt-get update && apt-get install -y build-essential cmake git ninja-build && rm -rf /var/lib/apt/lists/*
RUN git clone --depth=1 https://boringssl.googlesource.com/boringssl.git && cd boringssl && cmake -GNinja -B build -DCMAKE_BUILD_TYPE=Release && ninja -C build

FROM ubuntu:22.04
COPY --from=builder /app/boringssl/build/bssl /usr/local/bin/bssl
ENTRYPOINT [ "/usr/local/bin/bssl" ]

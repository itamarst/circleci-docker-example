FROM ubuntu:20.04 AS build
RUN apt-get update && apt-get install -y gcc
COPY server.c .
RUN gcc server.c -o server

FROM ubuntu:20.04 AS runtime
# Install security updates:
RUN apt-get update && apt-get -y upgrade
# Copy executable from build stage:
COPY --from=build server .
ENTRYPOINT ["./server"]

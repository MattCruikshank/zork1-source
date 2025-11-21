# Build stage
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS builder

# Install build dependencies and clean up in same layer
RUN apt-get update && \
    apt-get install -y unzip wget git && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /build

# Download and build ZILF
RUN wget https://foss.heptapod.net/zilf/zilf/-/archive/branch/default/zilf-branch-default.zip?ref_type=heads -O zilf.zip && \
    unzip zilf.zip && \
    rm zilf.zip && \
    cd zilf-branch-default && \
    dotnet build Zilf.sln

# Clone and build Zork1
RUN git clone https://github.com/historicalsource/zork1.git && \
    cd zork1 && \
    /build/zilf-branch-default/bin/Debug/net10.0/zilf zork1.zil && \
    /build/zilf-branch-default/bin/Debug/net10.0/zapf zork1.zap zork1-ignite.z3

# Runtime stage
FROM debian:bookworm-slim

# Install only runtime dependency
RUN apt-get update && \
    apt-get install -y frotz && \
    rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m zork
USER zork
WORKDIR /home/zork

# Copy only the compiled game file
COPY --from=builder /build/zork1/zork1-ignite.z3 .

# Create save directory
RUN mkdir save

VOLUME [ "/home/zork/save" ]

# Set working directory to save folder so Frotz saves there
WORKDIR /home/zork/save

CMD [ "/usr/games/frotz", "/home/zork/zork1-ignite.z3" ]

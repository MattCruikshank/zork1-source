FROM mcr.microsoft.com/dotnet/sdk:10.0

# Install unzip
RUN apt-get update && apt-get install -y unzip wget frotz git

# Create non-root user
RUN useradd -m builder
USER builder
WORKDIR /home/builder

# Clone ZILF repository and build
RUN mkdir /home/builder/zilf
WORKDIR /home/builder/zilf
RUN wget https://foss.heptapod.net/zilf/zilf/-/archive/branch/default/zilf-branch-default.zip?ref_type=heads -O zilf-branch-default.zip
RUN unzip zilf-branch-default.zip
WORKDIR /home/builder/zilf/zilf-branch-default
# RUN echo "unzip $(date)"
# RUN find "$(pwd)" -name "*.sln"

RUN dotnet build Zilf.sln
# RUN echo "dotnet build $(date)"
# RUN find "$(pwd)" -name "zilf*"

# git clone https://github.com/historicalsource/zork1.git
WORKDIR /home/builder
RUN mkdir zork1
RUN git clone https://github.com/historicalsource/zork1.git

WORKDIR /home/builder/zork1

# Build zork1-ignite.z3
RUN /home/builder/zilf/zilf-branch-default/bin/Debug/net10.0/zilf zork1.zil
RUN /home/builder/zilf/zilf-branch-default/bin/Debug/net10.0/zapf zork1.zap zork1-ignite.z3

RUN mkdir save

WORKDIR /home/builder/zork1/save

VOLUME [ "/home/builder/zork1/save" ]

# RUN find "/" -name "frotz"

CMD [ "/usr/games/frotz", "/home/builder/zork1/zork1-ignite.z3" ]

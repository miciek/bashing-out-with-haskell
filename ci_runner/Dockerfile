FROM ubuntu:16.04

ENV GHC_VERSION=8.2.2
ENV PATH=$PATH:/opt/ghc/bin
ENV PATH=$PATH:/root/.local/bin

RUN apt-get update \
 && apt-get dist-upgrade -y \
 \
 && echo "Install common tools" \
 && apt-get install -y \
    software-properties-common \
    curl \
    maven \
    jq \
 \
 && echo "Install Stack and global GHC to be able to run Haskell scripts" \
 && mkdir -p /root/.local/bin \
 && add-apt-repository ppa:hvr/ghc \
 && apt-get update \
 && apt-get install -y ghc-$GHC_VERSION \
 && curl -sSL https://get.haskellstack.org/ | sh \
 && stack config set system-ghc --global true \
 && stack install turtle \
 && echo 'main = print "Stack and GHC installed correctly!"' | runghc

FROM buildpack-deps:bullseye-curl

ENV NVM_DIR /home/vscode/.nvm

ENV NVM_VERSION 0.39.3
ENV NODE_VERSION 19.6.0
ENV YARN_VERSION 3.5.0

RUN useradd -m -s /bin/bash vscode

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends git

USER vscode

RUN curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh | bash \
	&& . $NVM_DIR/nvm.sh \
	&& nvm install -s v$NODE_VERSION \
	&& nvm alias default v$NODE_VERSION \
	&& nvm use default \
	&& corepack enable \
	&& corepack prepare yarn@$YARN_VERSION --activate

FROM python:3.9-slim-bullseye

USER root

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
    postgresql-client \
    libpq-dev \
    git \
    lsof \
    curl \
    bash-completion \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV NODE_VERSION=20.12.2
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

# dbt-runner app
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENV PYTHONUNBUFFERED 1
ENV PYTHONPATH /dbt-runner
ENV DBT_PROFILES_DIR /dbt-runner/jaffle_shop
ENV DBT_MODULES_DIR /dbt_modules
WORKDIR /dbt-runner

# Conveniences
ENV PROMPT_COMMAND history -a
RUN echo 'source /usr/share/bash-completion/bash_completion' >> /etc/bash.bashrc
RUN echo 'export HISTFILE=/dbt-runner/.developer/history' >> $HOME/.bashrc
RUN echo 'mkdir -p /dbt-runner/.developer && touch /dbt-runner/.developer/bashrc && source /dbt-runner/.developer/bashrc' >> $HOME/.bashrc


COPY requirements.txt requirements.txt
# COPY pre-commit-config.yaml pre_commit-config.yaml
# COPY dbt-checkpoint.yaml dbt-checkpoint.yaml
RUN pip install --upgrade pip
RUN pip install --ignore-installed -r requirements.txt && rm -rf /root/.cache

WORKDIR /dbt-runner/jaffle_shop
#RUN npx degit evidence-dev/template reports
#RUN npm --prefix ./reports install
#RUN npm --prefix ./reports run sources
#RUN npm --prefix ./reports run dev
RUN mkdir -p /build_dbt_deps
COPY jaffle_shop/dbt_project.yml /build_dbt_deps/dbt_project.yml
COPY jaffle_shop/packages.yml /build_dbt_deps/packages.yml
RUN cd /build_dbt_deps \
    && dbt deps

# ENTRYPOINT ["/bin/bash", "-c"]
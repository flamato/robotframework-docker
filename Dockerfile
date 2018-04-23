FROM consol/centos-xfce-vnc:latest

MAINTAINER Wang Cheng (Ken) "463407426@qq.com"
ENV REFRESHED_AT 2018-04-22

# Set proxy if necessary
# ENV http_proxy 172.17.0.1:3128
# ENV https_proxy 172.17.0.1:3128

ARG CHROME=latest
ARG FIREFOX_VERSION=59.0.2
ARG GECKO_VERSION=0.20.1
ARG PHANTOMJS_VERSION=2.1.1
ARG CHROMEDRIV_VERSION=2.38
ARG USER=robot-framework

# Switch back to root user for extend the consol/centos-xfce-vnc:latest
# For more info, please refer to https://github.com/ConSol/docker-headless-vnc-container
USER 0
RUN id

# Install deltarpm in case slow network
RUN echo "Installing deltarpm..." \
    && yum install -y deltarpm

# Install PhantomJs
RUN echo "Installing phantomjs v${PHANTOMJS_VERSION}..." \
    && mkdir -p /opt/phantomjs \
    && curl -Lk https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS_VERSION}-linux-x86_64.tar.bz2 | tar -xj --strip-components 1 -C /opt/phantomjs \
    && ln -s /opt/phantomjs/bin/phantomjs /usr/bin/phantomjs

# Install Firefox
RUN echo "Installing firefox v${FIREFOX_VERSION}..." \
    && rm -rf /usr/lib/firefox \
    && rm -f /usr/bin/firefox \
    && rm -f ~/Desktop/firefox.desktop \
    && wget -qO- --no-check-certificate https://ftp.mozilla.org/pub/mozilla.org/firefox/releases/${FIREFOX_VERSION}/linux-x86_64/en-US/firefox-${FIREFOX_VERSION}.tar.bz2 | tar xj -C /usr/lib \
    && ln -s /usr/lib/firefox/firefox /usr/bin/firefox \
    && wget -qO- --no-check-certificate https://github.com/mozilla/geckodriver/releases/download/v${GECKO_VERSION}/geckodriver-v${GECKO_VERSION}-linux64.tar.gz | tar xz -C /usr/local/bin/

# Install Zip
RUN yum install -y unzip

# Install chrome
RUN echo "Installing chrome v${CHROME}..." \
    && yum remove -y chromium \
    && rm -f ~/Desktop/chromium-browser.desktop \
    && echo -e '[google-chrome]\nname=google-chrome\nbaseurl=http://dl.google.com/linux/chrome/rpm/stable/$basearch\nenabled=1\ngpgcheck=1\ngpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub' | tee /etc/yum.repos.d/google-chrome.repo \
    && wget --no-check-certificate https://dl-ssl.google.com/linux/linux_signing_key.pub \
    && rpm --import linux_signing_key.pub \
    && rm -f linux_signing_key.pub \
    && yum install -y google-chrome-stable \
    && yum clean all \
    && curl -Lk https://chromedriver.storage.googleapis.com/${CHROMEDRIV_VERSION}/chromedriver_linux64.zip > /tmp/chromedriver_linux64.zip \
    && unzip /tmp/chromedriver_linux64.zip -d /usr/bin/ \
    && rm /tmp/chromedriver_linux64.zip \
    && sed -i 's/\"$@\"/\"$@\" --no-sandbox/' /opt/google/chrome/google-chrome

# Create a user ${user} (uid=10000) in the group ${user} (gid=10000)
RUN adduser -m -u 10000 -U ${USER} \
    && usermod -aG wheel ${USER} \
    && sed -i "\$a${USER} ALL=(ALL) NOPASSWD: ALL" /etc/sudoers \
    && chmod u+s /usr/bin/sudo \
    && chown -R ${USER}:${USER} /home/${USER}

# Copy requirements.txt
COPY --chown=10000:10000 requirements.txt /home/${USER}

# Install python 3.x, pip3, requirements
RUN yum install -y yum-utils \
    && yum install -y https://centos7.iuscommunity.org/ius-release.rpm \
    && yum install -y python36u \
    && curl -Lk https://bootstrap.pypa.io/get-pip.py | python3.6 - \
    && yum install -y python36u-devel \
    && cd /home/${USER} \
    && pip3 install -r requirements.txt \
    # Rename pybot, rebot, robot, pabot
    && mv /usr/bin/pybot /usr/bin/pybot3 \
    && mv /usr/bin/robot /usr/bin/robot3 \
    && mv /usr/bin/rebot /usr/bin/rebot3 \
    && mv /usr/bin/pabot /usr/bin/pabot3

# Install pip2, requirements for python 2
RUN curl -Lk https://bootstrap.pypa.io/get-pip.py | python - \
    && yum install -y python-devel \
    && cd /home/${USER} \
    && pip install -r requirements.txt \
    # Rename pybot, rebot, robot, pabot
    && cp /usr/bin/pybot /usr/bin/pybot2 \
    && cp /usr/bin/robot /usr/bin/robot2 \
    && cp /usr/bin/rebot /usr/bin/rebot2 \
    && cp /usr/bin/pabot /usr/bin/pabot2

RUN echo "Installing Java..." \
    && yum install -y java

# Delete the cahce
RUN rm -rf /headless/.cache

# Change user from root -> ${user}
USER ${USER}
RUN id

RUN echo "Create Firefox profile" \
    mkdir -p /headless/ta.default/
COPY --chown=10000:10000 prefs.js /headless/ta.default/

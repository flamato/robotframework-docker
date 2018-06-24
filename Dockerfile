FROM consol/centos-xfce-vnc:latest

MAINTAINER Wang Cheng (Ken) "463407426@qq.com"
ENV REFRESHED_AT 2018-06-23

# Set proxy if necessary
# ENV http_proxy 172.17.0.1:3128
# ENV https_proxy 172.17.0.1:3128

ARG CHROME=65.0.3325.181-1
ARG FIREFOX_VERSION=59.0.3
ARG GECKO_VERSION=0.20.1
ARG PHANTOMJS_VERSION=2.1.1
ARG CHROMEDRIV_VERSION=2.36
ARG USER=robot-framework

# Switch back to root user for extend the consol/centos-xfce-vnc:latest
# For more info, please refer to https://github.com/ConSol/docker-headless-vnc-container
USER 0

# Create Work Dir
WORKDIR /RobotFramework

# Copy
ADD src/. /RobotFramework/
ADD requirements.txt /RobotFramework/

# Commbine all the RUN into one to decrease the image size
# The following RUN has the 4 main tasks
# 1. Remove the uncessary packages
# 2. Install Zip, Java, PhantomJS, Firefox, Chrome, requirement.txt for python2 & 3
# 3. Create User with sudo access
# 4. Clear Cache

RUN chmod +x *.sh \
    && ./remove.sh \
    && ./tools.sh \
    && ./phantomjs.sh "${PHANTOMJS_VERSION}" \
    && ./firefox.sh "${FIREFOX_VERSION}" "${GECKO_VERSION}" \
    && ./chrome.sh "${CHROME}" "${CHROMEDRIV_VERSION}" \
    && ./python3.sh \
    && ./python2.sh \
    && ./user.sh "${USER}" \
    && ./clear.sh

# Change user from root -> ${user}
USER ${USER}

COPY --chown=10000:10000 prefs.js /headless/ta.default/

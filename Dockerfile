FROM webswing/webswing-se:20.1_jre11
RUN mkdir /ideaIC-2020.2.1 && wget -qO- https://download.jetbrains.com/idea/ideaIC-2020.2.1.tar.gz | tar -zxv --strip-components=1 -C /ideaIC-2020.2.1 && \
    apt-get update && apt-get install -y git && \
    mkdir /intellij-config && \
    for f in "/opt/webswing" "/intellij-config" "/ideaIC-2020.2.1" "/etc/passwd"; do \
      echo "Changing permissions on ${f}" && chgrp -R 0 ${f} && \
      chmod -R g+rwX ${f}; \
    done
COPY webswing.config /opt/webswing/webswing.config
COPY --chown=0:0 webswing.run /etc/service/webswing/run

COPY --chown=0:0 entrypoint.sh /entrypoint.sh

# PAtch index.html by adding javascript to redirect from iframe to full window as webswing do not from within iframe
COPY index.html /tmp/index.html
RUN cp /tmp/index.html /opt/webswing/index.html && \
    apt-get update && apt-get install -y zip && \
    cd /opt/webswing/ && zip webswing-server.war index.html

# Set permissions on /etc/passwd and /home to allow arbitrary users to write
COPY entrypoint.sh /
RUN mkdir -p /home/user && chgrp -R 0 /home && chmod -R g=u /etc/passwd /etc/group /home && chmod +x /entrypoint.sh /etc/service/webswing/run

USER 10001
ENV HOME=/home/user
WORKDIR /projects
ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["tail", "-f", "/dev/null"]

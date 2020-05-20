ARG from
FROM $from

# build arguments
ARG p2_user
ARG p2_host
ARG p2_pass

# environment variables
ENV DEBUG false
ENV LOG false

# prepare resources
COPY resources/equinox_init_scripts.sh /opt/equinox/equinox_init_scripts.sh
COPY resources/add_geodb_repository.sh /opt/equinox/add_geodb_repository.sh
RUN chmod +x /opt/equinox/*.sh

# init scripts
RUN /opt/equinox/equinox_init_scripts.sh

# Generate start script
RUN \
printf '#!/bin/sh\n\
sshpass -p "%s" ssh -fN -L *:10000:localhost:10000 %s@%s \n\
\
l="no_log"\n\
if [ $LOG = true ]; then\n\
   l="log"\n\
fi\n\
\
d="no_debug"\n\
if [ $DEBUG = true ]; then\n\
   d="debug"\n\
fi\n\
\
cp /opt/equinox/equinox.ini."$l"_"$d" /opt/equinox/equinox.ini\n\
\
/opt/equinox/equinox -console 5000' "$p2_pass" "$p2_user" "$p2_host" > /opt/equinox/start.sh; \
chmod +x /opt/equinox/start.sh; \
mkdir /root/.ssh; \
ssh-keyscan "$p2_host" >> /root/.ssh/known_hosts

# Add repo
RUN /opt/equinox/add_geodb_repository.sh

# Clean
RUN \
rm /opt/equinox/equinox_init_scripts.sh; \
rm /opt/equinox/add_geodb_repository.sh

CMD /opt/equinox/start.sh

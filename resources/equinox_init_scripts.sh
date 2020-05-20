#!/bin/sh

cp /opt/equinox/equinox.ini /opt/equinox/equinox.ini.log_no_debug
cp /opt/equinox/equinox.ini /opt/equinox/equinox.ini.no_log_no_debug
cp /opt/equinox/equinox.ini /opt/equinox/equinox.ini.log_debug
cp /opt/equinox/equinox.ini /opt/equinox/equinox.ini.no_log_debug
sed -i '/console/d' /opt/equinox/equinox.ini.no_log_no_debug
sed -i '/console/d' /opt/equinox/equinox.ini.no_log_debug
echo "-Xdebug\n-Xnoagent\n-Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=*:5001" >> /opt/equinox/equinox.ini.no_log_debug
echo "-Xdebug\n-Xnoagent\n-Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=*:5001" >> /opt/equinox/equinox.ini.log_debug
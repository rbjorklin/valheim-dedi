# https://developer.valvesoftware.com/wiki/SteamCMD#Docker
FROM cm2network/steamcmd

ENV DATE ${date}
ENV PUBLIC ""
ENV PORT ""
ENV NAME ""
ENV WORLD ""
ENV PASSWORD ""
ENV HOMEDIR /home/steam
ENV INSTALLDIR $${HOMEDIR}/valheim
ENV SteamAppId 892970
ENV LD_LIBRARY_PATH $${INSTALLDIR}/linux64

RUN ./steamcmd.sh +login anonymous +force_install_dir $${INSTALLDIR} +app_update 896660 validate +quit

WORKDIR $${INSTALLDIR}
EXPOSE 2456/udp \
       2457/udp \
       2458/udp

CMD exec $${INSTALLDIR}/valheim_server.x86_64 -nographics -batchmode -name "$${NAME}" -port $${PORT} -world "$${WORLD}" -password "$${PASSWORD}" -public $${PUBLIC}

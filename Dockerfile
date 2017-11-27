FROM debian:stretch
ENV DEBIAN_FRONTEND noninteractive
ENV EXPORTED_FOLDER /mnt/storage_s3
RUN apt-get update -q && apt-get install -y python-pip fuse \
 && apt-get clean -y && rm -rf /var/lib/apt/lists/* \
 && pip install yas3fs \
 # uncomment user_allow_other
 && sed -i'' 's/^# *user_allow_other/user_allow_other/' /etc/fuse.conf \
 # make it readable by anybody, it is not the default on Ubuntu
 && chmod a+r /etc/fuse.conf \
 && mkdir -p "${EXPORTED_FOLDER}"

VOLUME ["${EXPORTED_FOLDER}"]
ADD run.sh /
CMD ["/run.sh"]

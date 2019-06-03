FROM bitnami/minideb:unstable

RUN apt-get update && \
	apt-get install -y  \
		git libtool-bin automake autoconf libexpat1-dev \
		python-matplotlib python-serial python-wxgtk3.0 \
		python-wxtools python-lxml python-scipy python-opencv \
		ccache gawk python-pip python-pexpect htop \
		iproute2 dnsutils && \
	rm -rf /var/lib/apt/lists/*

RUN pip install \
	future pymavlink MAVProxy simplejson pid \
	cherrypy jinja2 dronekit dronekit-sitl -UI

COPY files/ /files/

CMD /bin/bash /files/run.sh

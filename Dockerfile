#Since this is a Dev container, for enabling sharing volumes with host is required to build this way: 
#docker build --build-arg UID={YOUR HOST UID} -t mperhez/ns3-env .
FROM ubuntu:bionic as base-os

ENV NS3_URL=https://www.nsnam.org/release/
ENV NS3_PKG=ns-allinone-3.29.tar.bz2
#Default user
ARG UNAME=nsuser 
ARG UID=1001 

RUN apt-get update && apt-get install -y \
	#utils
	wget \
	# c++
	gcc g++ \
	# python
	python python-dev \
	# python visualizer
	python-pygraphviz python-kiwi \
	# GTK+ 3
	gir1.2-goocanvas-2.0 python-gi python-gi-cairo python-pygraphviz python3-gi python3-gi-cairo python3-pygraphviz gir1.2-gtk-3.0 ipython ipython3  \
	#database support to statistics framework
	sqlite sqlite3 libsqlite3-dev \
	#virtual machines
	vtun lxc \
        --no-install-recommends \
	&& apt-get clean \  
        && rm -rf /var/lib/apt/lists/* \
	#Add user for enabling sharing of volume with host	
	&& useradd -u $UID -s /bin/bash $UNAME \
	&& mkdir -p /home/$UNAME \
	&& chown -R $UNAME:$UNAME /home/$UNAME

USER $UNAME
WORKDIR /home/$UNAME

RUN wget --no-check-certificate "$NS3_URL$NS3_PKG" \
	&& tar -xjf $NS3_PKG \
	&& rm $NS3_PKG
WORKDIR /home/$UNAME/ns-allinone-3.29
RUN ./build.py
WORKDIR /home/$UNAME/ns-allinone-3.29/ns-3.29/
RUN  CXXFLAGS="-O3" ./waf configure --build-profile=debug --enable-tests --enable-examples \ 
	#&&./test.py
	&& mkdir -p /home/$UNAME/ns-allinone-3.29/ns-3.29/workspace
RUN echo $PWD

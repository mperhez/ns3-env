## ns3 Simulation Environment

This is a basic image with the [ns3 simulator](https://www.nsnam.org/) environment.  


### Tags

* `3.29` : current ns3 version

### Usage

Since this is an image for development, the workspace folder is shared from the host. 
Besides, for enabling writing permissions it requires the host user id (UID), by default 1000, but you can change it as required. 

If you need to rebuild the image, use the following command (with your host UID and UNAME):

    docker build --build-arg UID={YOUR HOST UID} --build-arg UNAME={YOUR HOST UNAME} -t mperhez/ns3-env .

For running:

    docker run --name ns3 -it -v {YOUR HOST WORKSPACE FOLDER}:/home/{YOUR UNAME}/ns-allinone-3.29/ns-3.29/workspace mperhez/ns3-env bash


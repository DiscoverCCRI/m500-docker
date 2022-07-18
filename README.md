# m500 ROS Noetic Docker Setup
Used for development on VOXL m500 Drones for DiscoverCCRI. Includes dockerfile and helper scripts.

## Build
Build the image from the docker file with:

```
voxl:~$ docker build -f ~/noetic_dockerfile -t noetic:1.0 .
```

## Run
Run the newly build docker image by running the provided script run_docker_image.sh and then typing your desired image tag:

```
voxl:~$ bash run_docker_file.sh
Input image name [ex) noetic:1.0]: noetic:1.0
root@apq8096:~/yoctohome# 
```
The above script is a much quicker way of executing the longer docker run command that, among other things, mounts the home directory and the SD card:
```
docker run -it --rm --privileged --net=host -v /home/root:/root/yoctohome/ -w /root/yoctohome -v /mnt/sdcard:/root/yoctohome/sdcard noetic:1.0
```
Note that you can add additional terminal sessions to the running docker container with the following (scroll right to see full text):

```
voxl:~$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
a2fd57363e8f        noetic:1.0          "/ros_entrypoint.sh /"   2 minutes ago       Up 2 minutes                            goofy_pasteur
voxl:~$ docker exec -it goofy_pasteur /bin/bash
root@apq8096:~/yoctohome# 
```
The above lines are convenient for having a second terminal running roscore in the container so that the main terminal can execute user ROS code.


## Environment
Before you can run any ROS code in your container, you first have to source the container's environment. This can be done by modifying the included noetic_env.sh script with the VOXL Flight's IP address and then sourcing the script:

```
root@apq8096:~/yoctohome# . noetic_env.sh
root@apq8096:~/yoctohome# 
```
Note that the above ROS environemnt sourcing must be completed for each terminal connected to the container.

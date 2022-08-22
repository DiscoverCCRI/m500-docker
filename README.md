# m500 ROS Noetic Docker Setup
## Purpose
Used for development on VOXL m500 Drones for DiscoverCCRI. Includes dockerfile and helper scripts.
Sets up a ROS Noetic (version 1.15.14) docker container that can be used to build ROS1 packages, test out scripts, and develop on a VOXL m500 drone.

## Prerequisites
- Docker on VOXL (see [ModalAI's guide](https://docs.modalai.com/install-voxl-docker))
- (not required) For additional mounted storage in docker container, needs a microSD card in VOXL slot.
  - We used a 128 GB MicroSD Sandisk Extreme V30 A2 (about $20 on Amazon), though we found that you can't run docker directly from this microSD card as described by ModalAI [here](https://docs.modalai.com/docker-on-voxl/#move-docker-image-from-data-to-mntsdcard)

## Known-working Versions/Conditions
- system-image:   ModalAI 3.6.0
- facotry-bundle: 1.0.1 (Yocto installation)
- voxl-suite:     0.5.0
- Docker Version: 1.9.0

## Build
Clone files to Voxl then build the image from the docker file with:

```
voxl:~$ docker build -f ~/noetic_dockerfile -t noetic:1.0 .
```
You can provide whatever tag:version# you want. the above line tags the docker image as noetic with version 1.0 (noetic:1.0).

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
If you are not using a  mciroSD card for additional storage, you can edit the run_docker_file.sh script and remove the "-v /mnt/sdcard:/root/yoctohome/sdcard" portion.

Note that you can add additional terminal sessions to the running docker container with the following (scroll right to see full text):

```
voxl:~$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
a2fd57363e8f        noetic:1.0          "/ros_entrypoint.sh /"   2 minutes ago       Up 2 minutes                            goofy_pasteur
voxl:~$ docker exec -it goofy_pasteur /bin/bash
root@apq8096:~/yoctohome# 
```
The above lines are convenient for having a second terminal running roscore in the container so that the main terminal can execute user ROS code. You can also run roscore in the background of a terminal while running any main code by using the following:
```
root@apq8096:~/yoctohome# roscore && YOUR COMMAND HERE
```
However, using the above method then requires additional commands to stop roscore as you cannot Ctrl+C to stop it when it is running in the background.

## Environment
Before you can run any ROS code in your container, you first have to source the container's environment. This can be done by modifying the included noetic_env.sh script with the VOXL Flight's IP address and then sourcing the script:

```
root@apq8096:~/yoctohome# . noetic_env.sh
root@apq8096:~/yoctohome# 
```
Note that the above ROS environemnt sourcing must be completed for each terminal connected to the container.

An easy way to test that your environment is properly configured is to simply run roscore:
```
root@apq8096:~/yoctohome# . noetic_env.sh 
root@apq8096:~/yoctohome# roscore
... logging to /root/.ros/log/9141e060-222b-11ed-84f5-18473db1bf79/roslaunch-apq8096-93.log
Checking log directory for disk usage. This may take a while.
Press Ctrl-C to interrupt
Done checking log file disk usage. Usage is <1GB.

started roslaunch server http://10.121.29.97:36085/
ros_comm version 1.15.14


SUMMARY
========

PARAMETERS
 * /rosdistro: noetic
 * /rosversion: 1.15.14

NODES

auto-starting new master
process[master]: started with pid [101]
ROS_MASTER_URI=http://10.121.29.97:11311/

setting /run_id to 9141e060-222b-11ed-84f5-18473db1bf79
process[rosout-1]: started with pid [113]
started core service [/rosout]

```

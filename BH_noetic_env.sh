#! usr/bin/bash

export ROS_ROOT=/opt/ros/noetic/share/ros
export ROS_PACKAGE_PATH=/opt/ros/noetic/share:/opt/ros/noetic/stacks
export PATH=$PATH:/opt/ros/noetic/bin
export PYTHONPATH=/opt/ros/noetic/lib/python3/dist-packages


# if a catkin workspace is setup then make sure the launch
# files and run files are available in the ROS PATH
if [ -f ~/yoctohome/noetic_catkin_ws/devel/setup.bash ]; then
    	source ~/yoctohome/noetic_catkin_ws/devel/setup.bash
fi

if [ -f ~/yoctohome/noetic_catkin_ws/install/setup.bash ]; then
	source ~/yoctohome/noetic_catkin_ws/install/setup.bash
fi


# Set ROS_IP & ROS_MASTER_URI appropriately for your configuration
# 192.168.8.1 is default for the robot in soft access point mode

# Bryce's testing on 6/1/22 -> changed commented ROS_IP line to revert
# 10.121.10.90 was resmedianet IP at the time

export ROS_IP=10.121.10.90
# export ROS_IP=10.121.5.254
# export ROS_IP=192.168.8.1

export ROS_MASTER_IP=${ROS_IP}
export ROS_MASTER_URI=http://${ROS_IP}:11311/
unset ROS_HOSTNAME


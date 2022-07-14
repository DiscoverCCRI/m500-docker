#!/bin/bash
read -p "Input image name [ex) noetic:1.0]: " image
docker run -it --rm --privileged --net=host -v /home/root:/root/yoctohome/ -w /root/yoctohome -v /mnt/sdcard:/root/yoctohome/sdcard $image

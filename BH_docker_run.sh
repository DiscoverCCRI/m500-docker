#!/bin/bash
read -p "Input image name [ex) noetic:0.5]: " image
docker run -it --rm --privileged --net=host -v /home/root:/root/yoctohome/ -w /root/yoctohome -v /mnt/sdcard:/root/yoctohome/sdcard $image

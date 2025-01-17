# soter

## Features

SOTER, the first host-based  malware infection detector tailored for IoT devices.

SOTER features both early and lightweight detections.


## Demos
### Set up virtual devices [https://youtu.be/3MI5ux2j_6k]

[![demo](https://github.com/soter-project/soter/blob/main/1_set_up_virtual_device.png)](https://youtu.be/3MI5ux2j_6k)


### Collect honeypot logs [https://youtu.be/5bp0RjTIi5g]

[![demo](https://github.com/soter-project/soter/blob/main/2_collect_log.png)](https://youtu.be/5bp0RjTIi5g)



## Dataset

Dataset includes follwing collections:

* BinaryDataset - includes 29,309 malicious binaries.
* ScriptDataset - includes 3,439 malicious Linux  shell  scripts and 9,337 benign firmware scripts.
* OpenWrtLogs - includes 352,016 successful OpenWrt infection logs. Collected from 180 high-fidelity software (virtual) IoT devices (as honeypots) on public clouds across the globe at 32 geographically different locations for one month.

The extracting password is: soter

## Source Code

This directory contains the source code of SOTER.


### Hook

Under the ./Source Code/fs directory/ is the hook.

Copy and past those files to your kernel source code under `linux/fs`

Note: This is for linux-4.4.194. 


### Classifier 

Under the ./Source Code/loadable_module/ directory is classifier.

This is the Loadable Kernel Module (LKM). 

Run make to compile it. 

Note: you need proper built system (such as Buildroot) to compile this LKM. 



### Build 

Under the ./Source Code/build/ includes an exmaple of how to build SOTER in Raspbian (Raspberry Pi OS).

# Adaptive CPU frequency controller

## Introduction

The presented project is an adaptive controller in the Linux kernel space for CPU performance optimisation based on dynamic voltage and frequency scaling.
The module continuously identifies the CPUs queues and synthesises the controller that keeps the load of the processor on the desired level.

Precise description of the controller design could be found in articles.


## User

### Installation

Select git branch based on desired kernel version.

If the desired kernels version is older than the current one, in order to be
able to select newly installed kernel, set *GRUB_TIMEOUT_STYLE* as *menu*.

In order to do this, open grub file:
```
sudo vim /etc/default/grub
```
modify *GRUB_TIMEOUT_STYLE* and *GRUB_TIMEOUT* entry:
```
GRUB_TIMEOUT_STYLE="menu"
GRUB_TIMEOUT=10
```
and update grub:
```
update-grub
```

Download, patch, compile and install the kernel with adaptive CPU controller:
```
/bin/bash install_all.sh
```

Reboot. If necessary, select the new kernel.

### Demos

#### Kernel data plots

In order to demonstrate how the controller works, the play.sh script was created.
It compiles all the necessary software and loads the module into the kernel.

Then it uses lstress application to stress the CPU in 3 phases:
* for the first 10 seconds it makes the CPU to use 100% of the resources
* for following 10 seconds it does not stress the processor at all
* for following 20 seconds it stresses the processor to make the CPU controller work in the controllability region

In order to start the demonstration script:
```
/bin/bash play.sh
```

After more or less a minute you should see plots of the processor load and frequency together with some of the parameters of the controller.

In the case of not having installed all of the required python tools, you can use *install_tools.sh* script:
```
/bin/bash install_tools.sh
```

#### Client-server application

In order to be able to compare the performance of the already available governors
with adaptive controller, client-server application was created.

On the server side adaptive controller should be loaded.
The client sends request to perform various tasks by the server in order to stress its CPU and reads the power consumption.
Based on the measured response times and the information about the power consumption it creates plots with comparison between
the governors and chosen parameters of the adaptive controller.

## Developer

When creating new branch, modify kernel version in config.sh and update submodules. You can use checkout_repos script.

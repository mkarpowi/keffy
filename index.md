## Keffy: adaptive CPU performance controller

**Keffy** is an adaptive CPU performance controller operating in the Linux kernel
space as an **acpi-cpufreq dynamic CPU governor**. The controller autonomously
adapts the rules of its operations to the currently observed CPU workload
profile while keeping the workload at the desired level.

The controller has been designed as the indirect self-tuning regulator with
robust recursive model estimation. For more details on the [project background](https://www.researchgate.net/publication/335110363_Fixed-point_self-tuning_CPU_performance_controller_for_Linux_kernel)
and the control theory applied in the controller design, see:

* Malczak, M. and Karpowicz, M.P. *Fixed-point matrix inversion for linear solver in Linux kerne.* in preparation, 2021.

* Getka, M., and Karpowicz, M.P. *Fixed-point self-tuning CPU performance controller for Linux kernel.* 2019 International Conference on High Performance Computing & Simulation (HPCS). IEEE, 2019.

* Arabas, P., and Karpowicz, M.P. *Server Power Consumption: Measurements and Modeling with MSRs.* Challenges in Automation, Robotics and Measurement Techniques, Springer International Publishing, 233–244, 2016

* Karpowicz, M.P. *Energy‐efficient CPU frequency control for the Linux system.* Concurrency and Computation: Practice and Experience 28.2 (2016): 420-437.

* Karpowicz, M.P., and Arabas, P. *Preliminary results on the Linux libpcap model identification.* 20th International Conference on Methods and Models in Automation and Robotics (MMAR). IEEE, 2015.



## User

### Installation

Select git branch based on desired kernel version.

Update grub settings to be able to select the newly installed kernel from the grub menu at boot-time. Open:
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

To download, patch, compile and install the selected kernel version with the adaptive CPU controller, run:
```
/bin/bash install_all.sh
```

Reboot. If necessary, select the new kernel. Have fun!


### Demos

#### Kernel data plots

In order to demonstrate how the controller works, the play.sh script was created.
It compiles all the necessary software and loads the module into the kernel.

Then it uses **lstress** program to generate the CPU load according to the following scenario:
* for the first 10 seconds, it makes the CPU use 100% of the resources
* for the following 10 seconds, it does not stress the processor at all
* for the following 20 seconds, it stresses the processor to make the CPU
	controller work in the controllability region

In order to start the demonstration, call:
```
/bin/bash play.sh
```

After more or less a minute, you should see plots of the processor load and
frequency together with some of the parameters of the controller.

In the case of not having installed all of the required python tools,
you can use *install_tools.sh* script:
```
/bin/bash install_tools.sh
```


## Developer

When creating new branch, modify the kernel version in **config.sh** and update
submodules. You can use **checkout_repos.sh** script. Bear in mind that
cpufreq_adaptive submodule has different branch for every kernel version.


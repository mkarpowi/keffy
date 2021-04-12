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

##

You can use the [editor on GitHub](https://github.com/mkarpowi/keffy/edit/gh-pages/index.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/mkarpowi/keffy/settings/pages). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://docs.github.com/categories/github-pages-basics/) or [contact support](https://support.github.com/contact) and we’ll help you sort it out.

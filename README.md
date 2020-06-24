# Adaptive CPU frequency controller

In config.sh file select linux kernel version (*LINUX_VERSION*) and top directory (*TOP_DIR*) of the project.
Currently available kernels:
- 5.3.1

If the desired kernels version is older than the current one, in order to be
able to select newly installed kernel, set *GRUB_TIMEOUT_STYLE* as *menu*.

In order to do this, open grub file:
```
sudo vim /etc/default/grub
```
and modify *GRUB_TIMEOUT_STYLE* entry:
```GRUB_TIMEOUT_STYLE="menu"```

Download, patch, compile and install the kernel with adaptive CPU controller:
```
/bin/bash install_all.sh
```

Reboot. If necessary, select the new kernel.

Check how the controller works:
```
/bin/bash play.sh
```

After more or less a minute you should see plots of the processor load and frequency.

In the case of not having installed all the required python tools, you can use *install_tools.sh* script:
```
/bin/bash install_tools.sh
```

> before install 
```shell
sudo nixos-generate-config --root /mnt --dir .
```

挂载efi分区，cd /mnt mkdir ./boot
unmount /dev/xxxx
mount ./boot /dev/xxxx

拷贝nixos-flake文件到/mnt

> 第一生成配置需要
需要你是root用户，如果你是从nixos livecd中安装。
```shell
nixos-install --no-root-passwd --flake .#laptop_no_nvidia

```
会生成hardware-configuration.nix到system/目录下

> 让配置生效并保存(switch)

```shell
sudo -E nixos-rebuild switch --flake .#laptop_no_nvidia
```

> 如果蓝牙耳机出问题, 就fd hci0 /
然后删除所有被找到的文件.然后bluetoothctl untrust remove ,pair connect

## 我使用了hy2,配置文件已经屏蔽了服务器地址.
## 默认创建了用户yly_no_nvidia, 密码是qwerty666。

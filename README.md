
# Ubuntu-PPA-Usage

- [Ubuntu-PPA-Usage](#ubuntu-ppa-usage)
  - [Overview](#overview)
  - [环境准备](#%E7%8E%AF%E5%A2%83%E5%87%86%E5%A4%87)
  - [OpenPGP key](#openpgp-key)
  - [打包](#%E6%89%93%E5%8C%85)
  - [本地编译测试](#%E6%9C%AC%E5%9C%B0%E7%BC%96%E8%AF%91%E6%B5%8B%E8%AF%95)
  - [上传](#%E4%B8%8A%E4%BC%A0)
  - [使用](#%E4%BD%BF%E7%94%A8)


## Overview

PPA, [Personal Package Archives](https://launchpad.net/). 

[PPA for Ubuntu](https://launchpad.net/ubuntu/+ppas).

The following operations are based on `Ubuntu 16.04 LTS`.


[官方文档](https://help.launchpad.net/Packaging/PPA).


PPA参考

https://launchpad.net/~platonnetwork/+archive/ubuntu/platon.


https://launchpad.net/~yyl123456/+archive/ubuntu/platon.

## 环境准备


sudo apt-get install dpkg-dev debhelper dh-make devscripts


## OpenPGP key

1. 在[launchpad](https://login.launchpad.net)注册一个帐号。

```
fullname的长度最好不要少于5个字符。
```

2. 将下面两行信息添加到`~/.bashrc`，然后刷新(source ~/.bashrc)。

```bash
export DEBEMAIL="your.email.address@example.org"
export DEBFULLNAME="Full name"
```

其中`邮箱`、`全名`是您注册账号时所使用的。


3. 创建密钥

ref: https://launchpad.net/+help-registry/openpgp-keys.html
ref: https://launchpad.net/+help-registry/import-pgp-key.html

在Dash Home中搜索key，打开Passwords and Keys程序。
依次点击菜单 File -> New -> PGP Key。然后根据导向填写相关信息。

4. 同步密钥

选中你创建好的密钥，点击菜单Remote -> Sync and Publish Keys，然后选择Key servers，在 Publish keys to 的下拉列表里选择 keyserver.ubuntu.com。下面的两个勾也打上，点击Close。然后点击同步，预计等待 10 分钟。 （可以在 http://keyserver.ubuntu.com 查看是否已经同步。）

***注意 Full name 和 Email Address 必须和你在 debian/changelog 中，也就是 .bashrc 的 DEBFULLNAME 和 DEBEMAIL 中留下的严格一致，不然无法签名。而且该邮箱是你以后接收来自 launchpad 的打包结果通知的唯一指定邮箱。***


5. 导入OpenPGP key

在 launchpad 的账户管理页面，点击 OpenPGP keys 这个分类右上角的编辑，会进入一个 Import an OpenPGP key 的页面，需要你创建的密钥的 fingerprint 指纹。该指纹可以在 Passwords and Keys 程序的 My personal keys，右键点你创建的密钥，Properties - Details 中找到。（也可以在 http://keyserver.ubuntu.com 查到。）

粘贴进去，点击 import key，过一会儿会密钥中指定的邮箱会收到一封来自 launchpd.net 的邮件。里面有一封加密信。

在解密之前，在 Passwords and Keys 程序的 My personal keys，导出私钥到`/path/to/secret.key`，然后使用gpg导入：

```bash
gpg --import --allow-secret-key-import /path/to/secret.key
```

列出所有公钥

```bash
gpg --list-keys
```

先把加密的内容，从 "-----BEGIN PGP MESSAGE-----" 到 "-----END PGP MESSAGE-----" 的内容复制到一个 email.txt 里，然后在虚拟机的终端中使用：

```bash
gpg -d email.txt
```

就能在终端里看到一个链接，复制那个链接在浏览器中打开，是一个 launchpad.net 的链接，跟随指示，OpenPGP 密钥就添加完成了。 


***可能会遇到的问题***



1. <font style="color:red"> xxxx is not in the sudoers file.  This incident will be reported.</font>

使用root打开/etc/sudoers，在`root    ALL=(ALL:ALL) ALL`下面添加一行`xxxx    ALL=(ALL)ALL`



## 打包

下面以`platon-mpc`为例，脚本参考[install_ppa_bin.sh](install_ppa_bin.sh)。


**创建一个 PPA**

- 在`launchpad`上点击右上角你的帐号，在帐号管理页面：`Personal package archives` - `Create a new PPA`。 

为PPA取一个好名字。


**创建一个 源码目录**


- 在本地创建一个`platon-mpc-0.1.0`的目录

    ```
    命名格式：名称-版本号。
    platon-mpc是包名称，0.1.0是版本号。
    ```

- 将源码或二进制文件拷入其中。

- 将目录打包压缩（tar.gz/tgz/bz2，不支持.xz，如果文件比较大，建议使用bz2）。

    ```
    tar -czf platon-mpc-0.1.0.tar.gz platon-mpc-0.1.0
    tar -cjf platon-mpc-0.1.0.tar.bz2 platon-mpc-0.1.0
    ```

**生成源码包**

- 进入`platon-mpc-0.1.0`，执行`dh_make`。

    ```bash
    cd platon-mpc-0.1.0
    dh_make -f ../platon-mpc-0.1.0.tar.bz2
    ```
    
    在执行过程中会输出一些选项，根据自己的需要选择或修改。

    ```
    Type of package: (single, indep, library, python)
    [s/i/l/p]?
    s
    ```

    ```
    Email-Address       : unlinunli@163.com
    License             : blank
    Package Name        : platon-mpc
    Maintainer Name     : yylyyl
    Version             : 0.1.0
    Package Type        : single
    Date                : Thu, 10 Jan 2019 10:01:20 +0800
    Are the details correct? [Y/n/q]
    Y
    ```

    执行完成后，会自动在`platon-mpc-0.1.0`目录的同级目录下创建一个名为` platon-mpc-0.1.0.orig.tar.bz2`的压缩文件，这个就是`deb`用的源代码包。同时还会在`当前`目录创建一个`debian`子目录，里面是一些打包的`标准命令文件`（见下文）。 


**修改打包命令文件**

<b><font size="3" style="color:red">这一步非常重要！！！</font></b>

进入`debian`（以下操作都在debian下）。

```
cd debian
```

- ***overview***

debian目录结构与说明如下：

```
> tree 
.
├── changelog                   # 变更日志
├── compat
├── control                     # 控制信息
├── copyright                   # 版权信息
├── init.d.ex                   # 软件需要开机自启动时，才需要。否则无用。
├── manpage.1.ex
├── manpage.sgml.ex
├── manpage.xml.ex
├── menu.ex
├── platon-mpc.cron.d.ex
├── platon-mpc.default.ex
├── platon-mpc.doc-base.EX
├── platon-mpc-docs.docs
├── postinst.ex                 # 安装后执行脚本
├── postrm.ex                   # 删除后执行脚本
├── preinst.ex                  # 安装前执行脚本
├── prerm.ex                    # 删除前执行脚本
├── README.Debian               # 类似于 RPM 的 changelog
├── README.source               # 描述源代码是否满足 Debian 策略的文件，非官方，不用管。
├── rules                       # 当你需要添加 ./configure --? 或 cmake -D? 中的参数时。
├── source
│   └── format
└── watch.ex                    # Debian 专有，关注某个 url，有变化就邮件通知升级。
```

- ***copyright***

版权信息

- ***control***

Homepage 就是上面 copyright 的 source 相同的 url。

Standards-version 标准版本。

Description 跟 changelog 的写法一样。需要注意的是，第一行相当于 RPM 的 spec 范式文件中的 Summary，下面的才相当于 %description。

Section 根据你是给 Debian 或 Ubuntu 打包，分别去 http://packages.debian.org/en/sid/ 或 http://packages.ubuntu.com/en/xenial/ 查找就可以（两者其实差不多），分类名就是 Section 名。

注意，Section 名的时候一定要用小写，即使网页上用的是大写，这个标签是大小写敏感的，用了大写就会告诉你：Unknown section 'XXX'

Build-Depends 依赖（构建时）

例如，gcc (>= 4.9.2), cmake (>= 2.8.11)。

注意，如果这是一个提供图形界面的程序，最好加上 libx11-dev; 如果是 kde 程序，最好加上 zlib1g-dev。因为这两个依赖你在本地装其他依赖时会自动选中，你可能注意不到，但 Launchpad 上不是自动选中的，于是就会出现不必要的错误。

Depends 依赖（运行时）

例如，libcurl4-openssl-dev。


实例如下：

```
Source: platon-mpc
Section: x11
Priority: optional
Maintainer: yylyyl <unlinunli@163.com>
Build-Depends: debhelper (>=9), gcc (>= 4.9.2), g++ (>= 4.9.2), cmake (>= 2.8), libcurl4-openssl-dev, libssl-dev, bzip2, libboost-all-dev, libgmp-dev, libdb++-dev, libexpat1-dev, zlib1g-dev
Standards-Version: 3.9.6
Homepage: https://github.com/PlatONnetwork
#Vcs-Git: git://anonscm.debian.org/collab-maint/platon-mpc.git
#Vcs-Browser: https://anonscm.debian.org/cgit/collab-maint/platon-mpc.git

Package: platon-mpc
Architecture: amd64
Depends: ${shlibs:Depends}, ${misc:Depends}, libcurl4-openssl-dev
Description: PlatON MPC virtual machine
    PlatON.
	More than a blockchain platform, PlatON introduces a trustless computing architecture to address scalability and privacy issues with advanced encryption algorithms including verifiable computing, homomorphic encryption, secure multiparty computing, and more. PlatON's technology allows the executing of more heavy, data-privacy smart contracts. For more information, please read the PlatON Technical White Paper.
    Github: https://github.com/PlatONnetwork
    Project: https://github.com/PlatONnetwork/privacy-contract-vm
```


- ***changelog***

对于Ubuntu，修改`unstable`为`xenial`(对应Ubuntu 16.04 LTS)，否则会收到邮件通知：`Unable to find distroseries: unstable`。


*注意*

1. 编辑具体的条目时，前面必须有一个空格，而且条目的上下行中间不能有空格。否则就视为中止。

2. 如果你选择上传`launchpad`，成功了之后又改动了一些东西，再上传可能会邮件通知你这个错误：

```
File platon-mpc_0.1.0.orig.tar.bz2 already exists in whose ppa, but uploaded version has different contents
```

这时你需要编辑`(版本号-释出号)`。例如，修改`(0.1.0-1)`为`(0.1.0-2)`或者`(0.1.1-1)`，总之高于之前版本才可以。 

3. 如果您已经提交了的版本高于当前提交版本，要么删除远程ppa，要么修改待提交版本，使之大于已提交版本。参考上一条的解决方案。


实例如下：

```
platon-mpc (0.1.0-1) xenial; urgency=medium

  * Initial release (Closes: #nnnn)  <nnnn is the bug number of your ITP>

 -- yylyyl <unlinunli@163.com>  Tue, 08 Jan 2019 20:17:06 +0800
```


- ***rules***

例如，源码编译时，要加在cmake或make后面的参数，可以使用（统一使用`dh_auto_configure`这个宏）

```
override_dh_auto_configure:
    dh_auto_configure -- -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release
```

来覆盖默认的参数，否则不用改。 


再如，库的搜索与依赖，使用如下：

```
override_dh_shlibdeps:
    dh_shlibdeps --dpkg-shlibdeps-params=--ignore-missing-info -l.:/usr/lib:/usr/local/lib:/usr/lib/platon
```

`dh_*`可以使用`man dh_xxx`来查看具体的使用说明。



*若无必要，可以删除后缀是`.ex`和`.EX`的文件；若要使用，请去掉后缀，并加上执行权限。*

- ***preinst.ex***

安装前执行脚本


- ***postinst.ex***

安装后执行脚本


- ***prerm.ex***

删除前执行脚本


- ***postrm.ex***

删除后执行脚本


## 本地编译测试

在`platon-mpc-0.1.0`目录下，执行

```
dpkg-buildpackage
```

来进行本地编译测试。

如果缺少依赖，请在`debain/control`中的`Build-Depends`添加依赖项。如gcc (>= 4.9.2), cmake (>= 2.8.11)。

如果出现这样的警告：

```
gpg: skipped "Marguerite Su <marguerite@unknown>": secret key not available
gpg: [stdin]: clearsign failed: secret key not available
[...]
dpkg-buildpackage: warning: Failed to sign .dsc and .changes file
```

这是因为没有OpenPGP密钥，有了密钥之后可以使用

```
dpkg-buildpackage -kEBE5A290
```

来进行本地编译，也就不会有那个警告了。 


## 上传

[官方文档之上传](https://help.launchpad.net/Packaging/PPA/Uploading).


1. 生成用于上传的`platon-mpc_0.1.0-1_source.changes`文件。

在`platon-mpc-0.1.0`目录，执行

```bash
debuild -S -sa -kEBE5A290
```

`EBE5A290`是密钥ID，与`-k`之间没有空格。

`-sa`代表`include source`，也就是上传`platon-mpc_0.1.0.orig.tar.bz2`源代码包。

也可以用`-sd`，但不包括源代码包，主要适用于只改了`debian`目录中的控制文件这样的小升级。

如果初始上传使用`-sd`，`launchpad`会报错，错误代码是：

```
Unable to find platon-mpc_0.1.0.orig.tar.gz in upload or distribution.
```

2. 上传。在创建PPA时，网站上有相关[使用说明](https://help.launchpad.net/Packaging/PPA/Uploading)。

```
dput ppa:user/ppa-name source_version-release_source.changes
```

上传成功与否都会发送邮件进行通知，部分本人遇到的问题在打包的过程中有说明。

更多关于`上传错误`解决方案，参考 https://help.launchpad.net/Packaging/UploadErrors.


## 使用

打开 https://launchpad.net/ubuntu/+ppas 搜索PPA名称即可。里面有相关说明。

**添加PPA源**

sudo add-apt-repository ppa:user/ppa-name
sudo apt-get update

**删除PPA源**

sudo add-apt-repository -r ppa:user/ppa-name
然后进入 /etc/apt/sources.list.d 删除关于PPA源的文件即可。
sudo apt-get update

**安装软件包**

sudo apt-get install package-name

**卸载软件包**

sudo apt-get remove package-name


*安装后，目录结构如下（假设安装在/usr下）*

```bash
$ tree /usr/include/PlatON -L 2
/usr/include/PlatON
├── batcher.h
├── bit.h
├── block.h
├── comparable.h
├── constants.h
├── float_circuit.h
├── google
│   └── protobuf
├── integer.h
├── number.h
└── swappable.h

~$ tree /usr/lib/PlatON
/usr/lib/PlatON
├── libemp-tool.so.0.1.0
├── libGlacier2++11.so.36
├── libhiredis.so.0.14
├── libIce++11.so.36
├── libIceUtil++11.so.36
├── libjsonrpccpp-client.so.1
├── libjsonrpccpp-common.so.1
├── libjsonrpccpp-server.so.1
├── libmicrohttpd.so.12
├── libmpc-jit.so.6
├── libmpc_vm_platonsdk.so.0.1.0
├── libmpc_vm_service.so.0.1.0
└── librelic.so

~$ tree /usr/bin/PlatON
/usr/bin/PlatON
├── ctool
├── ethkey
├── platon
├── platon-mpc
└── protoc

/usr/bin$ ls -al ctool ethkey platon platon-mpc protoc
ctool -> /usr/bin/PlatON/ctool*
ethkey -> /usr/bin/PlatON/ethkey*
platon -> /usr/bin/PlatON/platon*
platon-mpc -> /usr/bin/PlatON/platon-mpc*
protoc -> /usr/bin/PlatON/protoc*

```

**运维参考**

对于`platon-all`/`platon-mpc`都有。

1. 例子参考`debians/`，拷贝过来直接修改即可，详细说明见[打包]()。

2. 脚本参考[install_ppa_bin.sh](install_ppa_bin.sh)。

3. 根据需要修改`changelog`/`control`/`postinst`/`postrm`/`rules`。


**install_ppa_bin.sh Usage**
```
bash -x ./install_ppa_bin.sh platon-all 0.7 1 0
```
Wait for upload, then login launchpad, it will compile the source into binary. Maybe 30 mins. Then:
```
apt-get install software-properties-common
add-apt-repository ppa:huzhenyuan-platon/platon
apt-get update
apt install platon-all
```
***OVER !***


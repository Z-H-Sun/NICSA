# 为 NICS 计算自动添加虚拟原子
[`English`](/README.md) **`中文`**

Gaussian可以计算NICS(0)和/或NICS(1)（本质上就是计算磁屏蔽值），但是虚拟原子的坐标需要手动添加，手算起来相当费劲。

> 核独立化学位移(Nucleus-independent chemical shift, NICS)是被广泛使用的衡量芳香性的指标。它的含义是在某个人为设定的不在原子核位置上的磁屏蔽值的负值，负值越大（即对磁场屏蔽越强）则芳香性越强。这个位置的一般取为共轭环的几何中心，这个位置的NICS被称为NICS(0)；或取平面上方/下方1 Å的位置，称为NICS(1)，这个指标体现的主要是π电子的贡献。

`NICS Automator` 可读取`.gjf`文件中的分子构型（构型优化结束后可由GaussView打开并存为`.gjf`文件）并自动生成用于NICS(0/1)计算的虚拟原子坐标及新的`.gjf`输入文件。

## 广告
* 最新发布 `CLab`，[点此下载](https://github.com/Z-H-Sun/NICSA/releases/download/v1.081/CLab_Win_Release.NICSA_1.081%2BFETAnal_1.041.zip)！它是 Windows 平台上的`NICSA`与[`FETAnal`](https://github.com/Z-H-Sun/FETAnal)两个模块的合集，其大小与单个模块相当，但可同时实现两者功能。

## 特性
* 跨平台的Python程序，用户友好
* 可视化，图形用户界面 (GUI) 显示分子结构
* 自动找环
* 自动生成虚拟原子 "Bq"

## 更新日志

### 1.081 版（仅对 Windows 用户）
* 优化用户界面
* 现可双击`CreateDesktopShortcuts.exe`以自动创建带预设的桌面快捷方式，方便调用

### 1.08 版
<p align="center"><img src="/screenshots/4.png" width="90%" height="90%"></p>

* 启用 Ctrl-C 取消功能
* 针对 Windows 用户，本发行版将 GUI 后台从 Tk/Tcl 改为更好的 Qt
* 实验性功能：

  * 可自定义窗口大小
  * 调整了控制台窗口（仅限 Windows）和 GUI 窗口的默认位置，保证它们不会重叠到一起
  * 将 GUI 窗口标题设置为输入文件名

### 1.07 版
* 启用多进程处理，大幅提高找环效率。目前，即使是六苯并蔻这样的稠环体系也能 **在几秒内处理完毕** (\* 取决于电脑配置)
* 对于Windows用户，目前该程序由[`Nuitka`](https://github.com/Nuitka/Nuitka)编译，由于其能将Python代码转为C语言编译，运行速度比CPython解释器还快一倍！

### 1.05 版
* 自该版本起，程序配置将存于同目录下的一个独立的文件`nicsa.config`中，方便Windows用户无需重新编译也能修改配置
* 提供关掉显示3D坐标轴和背景的选项，制图更明晰
* 找环效率大幅提升（通过删除无向图中不必要的节点，例如氢原子肯定不会参与成环）

## 运行环境 及 下载地址

### Windows
* Windows 7 **64位** 或以上版本
* **推荐** 使用编译版本，因其运行速度更快。下载此[发行包](https://github.com/Z-H-Sun/NICSA/releases/download/v1.081/NICSA_1.081_Win_Release.zip)，解压至任意路径并运行`nicsa\nicsa.exe`

  * 需要安装 Microsoft Visual C++ Redistributable for Visual Studio 2015-2019 ([下载](https://aka.ms/vs/16/release/vc_redist.x64.exe))，否则系统将提示“vcruntime140.dll缺失”。不过，**很有可能你之前已经安装过了**，因为不少软件都依赖此运行库
* **【广告】或者，你可以[下载`CLab`](https://github.com/Z-H-Sun/NICSA/releases/download/v1.081/CLab_Win_Release.NICSA_1.081%2BFETAnal_1.041.zip)，其中包括了`NICSA`，但功能更强大！**
* **如果你是开发者**，希望调试程序并使用**自己的Python环境**，则可下载开发者工具包。但是，自1.08版起不再维护且**不推荐使用**，如果需调试请参考[之前版本](https://github.com/Z-H-Sun/NICSA/tree/v1.07)

### Mac OS
* Mac OS X 10.10 或更高版本

好消息是，系统自带 Python 2.7（含 Matplotlib 1.3）；坏消息是，后者没有`mpl_toolkits`扩展。你可以选择自行安装， **或者，可以选择下载[这个](https://github.com/Z-H-Sun/NICSA/releases/download/v1.08/NICSA_1.08_Mac.zip)集成有 matplotlib.mpl_toolkits 1.3.0 的包** （该扩展是由官网 [PyPI.org](https://pypi.org/project/matplotlib/1.3.0/) 获得的）

### Linux
* 需有桌面环境以显示 GUI
* Python >= 2.7 含

  * Matplotlib >= 1.3 **（含 mpl_toolkits）**
  
只需 [nicsa](/nicsa) 及配置文件 [nicsa.config](/nicsa.config) 。运行 `chmod +x nicsa` 以添加“可执行”标志

### 附加说明
对于 \*nix 系统 (Mac OS X 和 Linux), 如果你配有 Python3 而非 Python2 环境, **最好将 `nicsa` 的第一行改为 `#!/usr/bin/env python3`**

## 用法简介
* 详细用法参见英文说明文档（同时提供样例以参考）的[How to use](/README.md#how-to-use)一节
* 针对Windows用户，高于1.081版本时可双击运行`CreateDesktopShortcuts.exe`以自动创建带预设的桌面快捷方式，方便调用
* 针对Mac用户，**请确保打开方式为“实用工具-终端(Utilities-Terminal)”。如果从网上下载，系统 Gatekeeper 可能阻止程序运行，请到 系统偏好-安全与隐私-通用 中放行**
* 根据注释更改配置文件 [nicsa.config](/nicsa.config)，特别是`COMMAND`和`FIGURE_SIZE`、`COMPONENTS`，前者表示生成的.gjf中希望指定哪个方法/基组进行计算，后两者指定了图形界面窗口大小及其中显示哪些组件（是否显示氢原子/标签/平面等）
  * 1.08 版的配置文件中写有一些实验性功能。虽然不太可能发生，但若造成意外，请删除那几行的代码
* 将（构型优化完的）目标分子的.gjf输入文件拖拽至应用程序（仅限Windows），或拖入终端窗口（各平台通用）并回车
  * 对于Windows编译版，可以将可执行文件创建桌面快捷方式以方便调用：这样可直接将输入文件拖至快捷方式上便可用该程序打开此输入文件
* 将在一个独立的图形用户界面窗口中显示分子的初始结构（下图）<p align="center"><img src="/screenshots/1.png" width="60%" height="60%"></p>
  * 鼠标左/右键拖动以更改视角/缩放
  * 单击复选框以显示/隐藏氢原子、化学键或原子标签
* 当提示“Enter atom numbers that form the ring of interest”时，可进行下列操作之一以添加虚拟原子：<p align="center"><img src="/screenshots/2.png" width="60%" height="60%"></p>
  * 直接输入所有对应原子编号，之间用空格分隔；
  * 输入`auto [n]`表示让程序自动寻找所有的*n*元环，但也可以省略掉n表示寻找所有环；
  * 输入`more [a b c]`表示让程序自动寻找所有同时含有*a*号、*b*号、*c*号……原子的环；
    * `auto [n]`和`auto/more [a b c]`之间略有区别，详见英文文档；
    * 自动找环程序在罕见的情况下（特别是稠合度很高的芳烃）可能会返回一些错误的结果（详见英文文档），此时需要手动剔除这些“假环”（下图）；
    * 除第一种情况（手动指定）外，自动找环程序 **首次** 需要花约十秒钟时间来初始化当前分子，之后会把结果存在`./<filename>.nicsa`中，之后再次分析时无需重复耗时；<p align="center"><img src="/screenshots/3.png" width="60%" height="60%"></p>
  * 之后，目标环会高亮（呈绿色）显示；
    * 当提示“Is this ……?”时，直接回车（表示这的确是目标环）继续流程，或按N回车以取消（见上图）；
    * 如果当前环被程序认为是之前已经算过的，直接回车可跳过该环以避免重复，或按Y回车以强制添加；
    * 如果选定了某个环，程序首先会用二元线性回归拟合平面，然后在环中心/平面上下两边距离1 Å处各添加一个虚拟原子以分别用于NICS(0)和NICS(1)计算；
    * 平面和虚拟原子会显示于图形窗口中，它们的方程/坐标会显示在终端中。
  * **随时可以按下<kbd><kbd>Ctrl</kbd>+<kbd>C</kbd></kbd>取消操作**。
    * 特别是当符合条件的环有很多时，可以中途取消以跳过之后的一大堆;
    * 对于Mac OS用户（及其他使用Tk而非Qt作为GUI后台的情况），在按下<kbd><kbd>Ctrl</kbd>+<kbd>C</kbd></kbd>后还需按一次<kbd>Enter</kbd>以生效
* 除了上述三种操作，还可以：
  * 输入`del [n]`表示删除*n*号环及虚拟原子，但也可以省略掉*n*表示删除上一个环；
  * 注意删掉某个环后，环编号和虚拟原子编号可能会发生变化，请关注图形窗口中更新的编号标签
  * 输入`show [n]`表示高亮*n*号环并显示平面方程及虚拟原子坐标，但也可以省略掉*n*表示显示上一个环；
  * **随时可以按下<kbd><kbd>Ctrl</kbd>+<kbd>C</kbd></kbd>退出程序**;
    * 退出前会询问是否保存结果;
    * 对于Mac OS用户（及其他使用Tk而非Qt作为GUI后台的情况），在按下<kbd><kbd>Ctrl</kbd>+<kbd>C</kbd></kbd>后还需按一次<kbd>Enter</kbd>以生效
  * 直接回车以退出编辑并**保存所有更改**。
    * **注意：如果不这么做的话，程序不会保存任何更改！**
* 单击复选框可显示/隐藏虚拟原子、标签、平面等。

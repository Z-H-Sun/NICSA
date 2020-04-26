# NICS Automator
**`English`** [`中文`](/README_zh-CN.md)

Automatically creates an Gaussian input file eligible for NICS(0)/(1) calculations based on the initial .gjf file, which can be obtained by saving the optimized geometry using GaussView.

## Features
* A cross-platform python program
* Graphic user interface for displaying the molecule
* User friendly
* Automatic ring-finding function
* Automatic analysis of the locations of "Bq" ghost atoms

## What's new

### Version 1.07
* Enabled multi-processing, further improving ring-finding performance: Now, aromatic systems as large as hexabenzocoronene **can be processed within seconds** (\* depending on the performance of your computer)
* For Windows users, the executable is now compiled by [`Nuitka`](https://github.com/Nuitka/Nuitka), which translates Python into a C level program and runs **twice as fast** as the native CPython interpreter!

### Version 1.05
* Starting from this version, the configurations will be defined in another file, `nicsa.config` in the same folder, allowing Windows users to modify settings by editing this plain text file rather than re-compiling the executable
* Users will now have the option to turn off the 3D axes and the background
* The performance of automatic ring-finding has been greatly improved by removing unnecessary nodes (e.g. hydrogen atoms)

## Runtime Environment
The requirements listed below are recommended for running this program. If not met, however, workarounds are also provided here.

### For Windows
* Windows 7 **64-bit OS** or higher
* **It is recommended** to use the compiled program, because it is now a C-level program and runs much faster. ~~*This is deprecated though, since it runs much slower, given that it will first release a Python environment into temporary path. Besides, the source code cannot be edited since it has been compiled into the executable.*~~ You can download the [release package](https://github.com/Z-H-Sun/NICSA/releases/download/v1.07/NICSA_1.07_Win_Release.zip), extract it to anywhere, and run `nicsa\nicsa.exe`

  * You will need Microsoft Visual C++ Redistributable for Visual Studio 2015-2019 installed ([Download here](https://aka.ms/vs/16/release/vc_redist.x64.exe)); otherwise, the system will prompt you that "vcruntime140.dll is missing." However, **it is very likeyly that you have already installed it** because a lot of other softwares depend on it
* If you, **as a developer**, want to debug the source code and use **your own Python** environment, you can download the [dev package](https://github.com/Z-H-Sun/NICSA/releases/download/v1.07/NICSA_1.07_Win_Dev.zip) with an executable, `nicsa.exe`, served as "wrapper script", which enables the drag-drop function and prevents abrupt exit on error. You must make sure you have

  * Python 2.7/3.4 or higher **with PyWin32 installed** and with the following library
  
    * Matplotlib >= 1.3 **with mpl_toolkits** and their dependencies (If you do not have the `matplotlib` library, you can run `pip install matplotlib` in `cmd`; or, if the one you have does not include `mpl_toolkits` extension, try `pip install -U matplotlib`)
  * No VC runtime library required

### For Mac OS
* Mac OS X 10.10 or higher

Fortunately, Python 2.7 with Matplotlib 1.3 was built-in to Mac OS X. However, the library lacks `mpl_toolkits` extension, and thus it should be set up additionally; **Or, if you do not want to deal with those `pip` stuff, we provide [this package](https://github.com/Z-H-Sun/NICSA/releases/download/v1.07/NICSA_1.07_Mac.zip) with matplotlib.mpl_toolkits 1.3.0 integrated** \(which was extracted from official website [PyPI.org](https://pypi.org/project/matplotlib/1.3.0/)\).

### For Linux
* Must be with a desktop environment to display GUI
* Python >= 2.7 with

  * Matplotlib >= 1.3 **with mpl_toolkits**
  
After proper deployment, only [nicsa](/nicsa) and its configuration file [nicsa.config](/nicsa.config) need to be downloaded. Run `chmod +x nicsa` in bash to make it executable.

### Additional Comment
For \*nix systems (Mac OS X and Linux), if you have deployed a Python3 environment rather than Python2, **you may want to change the first line of `nicsa` to `#!/usr/bin/env python3` instead**.

## How to use
### Run the program
* For Windows and Mac OS X, double-click on the executable to run;

  * For Mac OS X, make sure that the default application for executables is "Terminal"
  * For Mac OS X, execution of Internet files may be blocked by the system's gatekeeper; you can write the file yourself by copying the source code of [nicsa](/nicsa) to it, or you may "Allow Apps from Anywhere" to solve the problem
* For either Windows, Mac, or Linux, you can also run `<path/to/>nicsa` in cmd/bash to lunch the program;
* When prompted to "Input a .gjf file", you can do any of the following:

  * Entering the filename (*relative path or absolute path, with or without space*), after which this .gjf input file will be analyzed

    * The path should be no longer than 260 characters, which is a limit of Python, so please don't blame me for that :)
  * Dragging the file of interest to the terminal, which can save effort in inputing;

* **For Windows only**, dragging the file *to the executable* **can do the same trick with above**. For the compiled version, it would be more convenient if you **create a desktop link** (shortcut) to `nicsa.exe`, because then you can **drag the .gjf file directly to that shortcut and open it with `nicsa`**
* For either Windows, Mac OS, or linux, to run `<path/to/>FETAnal <*.gjf>` in cmd/bash **is equivalent to** running the program without arguments followed by entering `<*.gjf>` to the program;
* You can try out [this example](/Example/bnhbc.gjf), whose results are given in [the same folder](/Example) for your reference;
* After that, the original molecule will be displayed in a separate GUI window (as shown in the figure below);
  
  * Drag using left/right mouse to change viewing angle/zoom in or out
  * Click on the checkbox to toggle visibility of hydrogen atoms, bonds, or lables.

<p align="center"><img src="/screenshots/1.png" width="60%" height="60%"></p>

### Adding ghost atoms
<p align="center"><img src="/screenshots/2.png" width="90%" height="90%"></p>

* When prompted to "Enter atom numbers that form the ring of interest", you can do one of the following to add ghost atoms:

  * Entering the atom numbers directly, each separated by a space;
  * Entering `auto [n]` suggesting that you want the program to detect all *n*-member-rings, where *n* can be omitted so as to find rings of all sizes;
  * Entering `more [a b c ...]` suggesting that you want the program to detect rings that contain atoms #*a*, #*b*, #*c*, and so on.

    * There is a little difference between `auto [n]` and `auto`/`more [a b c ...]`; see the section [Details on Ring Finding](/README.md#details-on-ring-finding) for more information;
    * The automatic ring-finding function may return some *false* rings (see the section [Details on Ring Finding](/README.md#details-on-ring-finding) for more information), and you might need to distinguish them manually;
    * Except the first scenario (direct designation), the program requires a **ONE-TIME** initialization for this molecule and may take a while (up to tens of seconds), after which the information will be recorded in `./<filename>.nicsa` for future convenience;

  * After this, the target ring will be highlighted.
    * When prompted "Is this ...?", directly press enter to continue (take this as a *true* ring), or press 'n' and then enter to cancel;
    * If a ring is considered duplicate by the program, directly press enter to skip over, or enter 'y' to add this ring anyway;
    * If you choose to add a ring, a best-fitting plane will be calculated using binary linear aggression; and then, a ghost atom at the plane center and two ones at 1 angstrom distance away from it (on each side of the plane) will be added, for NICS(0) and (1) calculation, respectively.
    * The plane and the ghost atoms will be shown in the figure, and their information will be shown in the terminal. 
* In addtition to the aforementioned three cases, you may also:

  * Enter `del [n]` to delete ring #*n*, where *n* can be omitted so as to delete the last ring;

    * Note that the ring number and Bq number are subject to change after deletion, please look at the updated figure to find the new ring number *m* (label as "P*m*" on the ring plane);
  * Enter `show [n]` to display information of ring #*n*, where *n* can be omitted so as to show the last ring;
  * Directly press enter to save all the changes.

    * The program will **not save anything** unless you do so.
* Click on the checkbox in the figure to toggle visibility of labels, ghost atoms, ring planes, etc.

### Advanced Settings
* You can edit the configuration file [nicsa.config](/nicsa.config) according to the annotations;

  * Now, for the Windows compiled package, you can find the configuration file alongside `nicsa.exe` ~~Of course, if you run the single-executable version with integrated Python environment, you cannot edit this since the source code has been compiled and thus not editable.~~
  * It is written in Python code;
  * Among them, `COMMAND` and `COMPONENTS` are especially useful in that you may want to change the method/basis set for a NICS calculation or the default visiblity of bonds, labels, atoms, etc.
* If a .gjf has been read by the program, a `<filename>.nicsa` plain-text file will be generated for future convenience. You can edit this file using a text editor (like Notepad) to re-define the bonds and rings.

  * The `connectivity` list records the bonds between non-hydrogen atoms. Each tuple has two numbers defining which two atoms are bonded. Note that the number **is not the actual atom number**, but the number of non-H atoms without reckoning in hydrogens or ghost atoms, and you should start counting from zero instead of one;
  * The `connectivityH` list records the bonds between a hydrogen and a non-H atom. Each tuple has two elements defining the coordinates of these two atoms;
  * The `ringsAuto` list records the composition of all rings, each element of which is a list of atoms that forms the ring. Again, note that the number **is not the actual atom number** (see first item);
  * The `ringsReduced` list is similar to `ringsAuto` except that it does not count in the rings that are *obviously false*. For example, a naphthalene has two 6-member-rings, and those two, in combination, also form a 10-member-ring, but the 10-member-ring is *obviously* not what we want. See the section [Details on Ring Finding](/README.md#details-on-ring-finding) for more information.

### Details on Ring Finding
* The algorithm first tries to all the circles (`RingsAuto`). If a large circle contains a small one, then both two circles are taken into account, though pratically we should not count in the large one. (Remember the naphthalene example above?) This process might take tens of seconds for large polycyclic aromatics
* Then the program will try to rule out the *false* rings and store the legitimate ones in the `RingsReduced` list. The algorithm is not perfect now. Although it is easy to handle the issue topologically (say, if Ring<sub>*i*</sub> has all the vertices of Ring<sub>*j*</sub>, then Ring<sub>*i*</sub> is not legitimate), you cannot tell whether a ring is what we want if not taking geometry into account. However, it is really hard to do it on a "geometrical" level. What we can only do is to consider about the simplest case, *i.e.* it is impossible for Ring<sub>*i*</sub> not to include Ring<sub>*j*</sub> when they share only one vertex, by assuming that the molecule does not contain bridged rings

  * Despite the effort, exceptions may, though rare, happen for heavily-fused polycyclic molecules as shown in the picture below. In this scenerio, you must rule it out mannually.<p align="center"><img src="/screenshots/3.png" width="60%" height="60%"></p>
* There is a little difference between `auto [n]` and `auto`/`more [a b c ...]`. The former is based on the `RingsAuto` list, and the latter two based on the `RingsReduced` list.

  * Therefore, if your ring is somehow ruled out in the `RingsReduced` list, which is very, very, very rare, you can still find it by specifying its number of vertices using `auto[n]`.

## Developers
* If you want to compile the Python script on Windows, you may use [`Nuitka`](https://github.com/Nuitka/Nuitka) by running `Compile\make.bat`. ~~It is crucial **not** to install `numpy` higher than 1.16.2 nor `matplotlib` higher than 3.0.2. *If you don't believe that, just try and you'll know why*.~~ (This does not matter anymore)
  * The compilation requires [mingw64](https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-win32/sjlj/x86_64-8.1.0-release-win32-sjlj-rt_v6-rev0.7z/download). Download it and extracts it to `C:\`. If you place it in another path, please make changes to `Compile\make.bat` accordingly
  * This tool is rather unreliable at the current stage. `Numpy` and `matplotlib` are not compiled to avoid undesirable errors; in addition, part of them are already C-based, so if you must compile them, the program may run even slower.
  * Due to various reasons, after compilation, you need to copy the dependencies to the "dist" folder to make the executable work (e.g. `numpy`, `matplotlib`, `cycler`, `kiwisolver`, etc.) You can follow the error messages to find which ones are needed. Especially, the program cannot find the `Tcl/Tk` dependency, so in [Line 97-100 of `nicsa`](/nicsa#L97-L100) the environment variable is set manually to circumvent the error. If you still have no idea how to meet the requirements, just compare the contents in your folder with those of the release package
* If you want to compile the "wrapper script" executable, you may need a tool called `Bat to Exe Converter` (which unfortunately was out of maintenance for long) and [nicsa.bat](/Wrapper/nicsa.bat).

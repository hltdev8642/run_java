# run_java
## Run java program in termux.
Because the JDK is too big to install in termux.
So it has another way to run Java program in termux---ecj.
This script can automatically install ecj, dx and termux-tools in termux to run Java program.

## Install

```bash
pkg i git ecj dx -y
cd ~
git clone https://github.com/HemanthJabalpuri/run_java
cd run_java
sh install.sh
```

## Run java program
```
javac <JavaFile>.java
java <JavaFile>
```

example 1 - single file input:
```bash
cd ~/run_java
javac ./Test/HelloWorld.java
java ./Test/HelloWorld
```

example 2 - multi-file input:
```bash
cd ~/run_java
javac ./Test/*.java
# (or)
javac ./Test/HelloWorld.java ./Test/HelloWorld2.java
```

**Note:-** `javac` produces _dex_ file which is finally executed by Dalvik Virtual Machine that comes with all android devices.

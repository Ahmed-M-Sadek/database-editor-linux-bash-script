# bash script for a database management system

The script offers a basic text based user interface for a DBMS (Database Management System) that gives the user a way to create and interact with database directories and table files

## Requirements

The script only requires the gawk package which can be installed easily using

```bash
sudo apt install gawk
```

## Preparation

Make sure you have the correct permissions to run the main script, The other sub-scripts used grant permission automatically and you don't have to set permissions.
This can be done through the following command

```bash
chmod a+x DBSearchEngine.sh
```

It is also preferrable to set the working directory before hand in the configeration file "configFile.txt"
make sure that you set the working directory as the bin directory this ensures the script to find the requires built-in sub-scripts which it uses to complete its required functionalitites 
In case you already have a Databases DIrectory: set the working space to the Databases directory

Here is an example for the configFile.txt

```
Current Working Directory:/home/userName/optionalDirectory/bin
Current Working Space:/home/userName/optionalDirectory/Databases
```

## Usage

The script is run using the following command if you are in the same directory in which the script is located

```bash
./DBSearchEngine.sh
```

or you can add the absolute path to script after the " . "

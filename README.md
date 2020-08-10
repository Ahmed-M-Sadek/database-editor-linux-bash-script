# Database Search Engine

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

### User Interface

The script starts by asking if the user is willing to use the directory that is save in the configeration file.

If the user enters "N" or "n" it requires the user to type in the path to the new directory which it then saves in the configeration file as the default path for later usage.

### Features

The user is asked to choose from the set of features offered in the main menu by the script.

#### Create a database

#### Delete a database

#### Open a database

##### Create a table

##### Delete a table

##### Insert into a table

##### Modify a table entry

##### Display a table

##### List all available tables

#### List all available databases

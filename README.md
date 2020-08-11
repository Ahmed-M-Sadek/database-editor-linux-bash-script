# Database Search Engine

The script offers a basic text based user interface for a DBMS (Database Management System) that gives the user a way to create and interact with database directories and table files

## Requirements

The script only requires the gawk package which can be installed easily using:

```bash
sudo apt install gawk
```

## Preparation

Make sure you have the correct permissions to run the main script, The other sub-scripts used grant permission automatically and you don't have to set permissions.
This can be done through the following command.

```bash
chmod a+x DBSearchEngine.sh
chmod a+x changePermissions.sh
```
In case the script does not set the permissions correctly there are two options:

#### 1) Use the changePermissions.sh script
#### 2) Set the permissions manually 

It is also preferrable to set the working space before hand in the configeration file "configFile.txt".

In case you already have a Databases DIrectory: set the working space to the Databases directory.
You can also set the working space directory to an empty directory in order to create a new Databases directory in that path.

Here is an example for the configFile.txt

```
Current Working Directory:/home/userName/optionalDirectory/bin
Current Working Space:/home/userName/optionalDirectory/Databases
```
:warning: Do not set or change the working directory path. It should be set automatically.
## Usage

The script is run using the following command if you are in the same directory in which the script is located

```bash
./DBSearchEngine.sh
```

or you can add the absolute path to script after the " . "

### User Interface

The script starts by asking if the user is willing to use the directory that is save in the configeration file.

If the user enters "N" or "n" it requires the user to type in the path to the new directory which it then saves in the configeration file as the default path for later usage.

## Features

The user is asked to choose from the set of features offered in the main menu by the script.

### Create a database

allows the user to create and name a new database directory.

### Delete a database

lists available databases and prompts the user to enter a name from the list to delete the database with that name.

### Open a database

lists available databases and promts the user to enter a name from the list to show the features offered for that database.

### List all available databases

Lists all available databases inside the Databases directory.


## Opening a database

The features offered when opening a database include:

### 1) Create a table

Creates and names a new table file.
Then asks for the number of columns, names and datatypes for each of the columns.
The first column must be the Primary key of the table.

### 2) Delete a table

Lists available tables and prompts the user to enter the name of the table to be deleted

### 3) Insert into a table

Lists available tables and prompts the user to enter the name of the table.
Then requires the user to enter a unique value for the primary key and then proceeds to request the data for the other columns.

### 4) Modify a table entry

Lists available tables and prompts the user to enter the name of the table.
The user then enters an existing primary key and enters new values for the entry with that primary key.

### 5) Display a table

Lists available tables and prompts the user to enter the name of the table.
Then it displays the table in column format so the user can view it easily.

### 6) List all available tables

Lists all available tables in the opened database.

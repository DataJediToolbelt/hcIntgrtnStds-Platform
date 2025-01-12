# hcIntgrtnStds-Platform
Healthcare Integration Standards Platform

# How To Implement
This section covers how to implement.

## Data Model
This project was moved from a private repo to a public repo in 11-2024.
Our first effort was to remove ALL the data tier work in multiple database
technologies and start almost at the beginning. To do this we
are initially implementing SQLite and will progress to implement other
RBDMS once the data model is accurate.

## Code
Its Python 3 based.  We currently have implemented Python v3.9 through various dot releases in 3.12 successfully on multiple operating systems, 
We have leveraged either the download and installers from python.org or simply installed Anacoda. 

<b>We have experienced issues with several libraries on 3.13 still being an issue as of November 20, 2024.</b>

### Python Virtual Environment
We always recommend following all best practices of technologies, one very nice one in Python is
there usage of virtual environments. While we have the venv directory excluded within the .getignore
you must activate or source it depending upon your OS.

Here is one of the thousands of articles that explains virtual environments in Python.
https://python.land/virtual-environments/virtualenv

### Conda or Python Virtual Envs
We are huge fans of Conda, it simplifies everything. However, it is a very large implementation and
install based on what it brings with it.

#### Conda Virtual Env.

To create a virtual env in Conda:

`
conda create -n yourenvname python=x.x anaconda
`

Activating the virtual env. for your work:

`
source activate yourenvname
`

Install Additional Packages into env.:

`
conda install -n yourenvname [package]
`


To view the virtul env list

`
conda env list
`

Deleting the virtual environment:

`
conda remove -n yourenvname --all
`


#### Python Virtual Env.
We used the simple command (while within the specific project directory): python -m venv venv

##### MacOS and Linux

` source ./venv/bin/activate
`

##### Windows

`
source .\venv\bin\activate.bat
`
or
`
source .\venv\bin\activate.ps1
`

##### Libraries Implemented
This section is intended to show any non-builtin/included Python libraries. These are the core
ones we have added (they have carried along the libraries they leverage as well).

#### Installing Packages and PIP
PIP manages Python packages, it also must be updated and maintained. 
From the project directory virtual environment.

`
python -m pip install --upgrade pip
`

We have tried to simplify how you can get the platform running, we have put the
packages into a requirements.txt file. Within the project directory virtual 
environment you can run:

`
pip install -r requirements.txt
`

#### Security checks on Modules
Security is very important when using any libraries, Python does have a reputation for having
a large amount of modules that are "unsafe". Here is an article from Red Hat about checking for vulnerabilities.

https://www.redhat.com/sysadmin/find-python-vulnerabilities

In order for us to try and mitigate this risk we plan on following a very common path, using pip-audit.
From the project directory, or within the IDE if you are using one:

`
pip install pip-audit
`

Then, simply run

`
pip-audit
`
# Platform
In order to best explain how the Synthetic Data Platform works we have created content
that explains it. Please start <a href="./Platform-Areas.md" target="_blank">here</a>.

## How To Use Platform
This section is intended to explain how to leverage the platform

## How to Add Custom Data To Any Specification
The following section covers how you can add data to any content
that vendor use to enhance their specification.

1. You need to make sure vendors are in place in the system
2. You add SEGMENTS to the refdata_segments table
3. You add FIELDS in the refdata_fields table
4. You add the appropriate SEGMENTS and associate them to the appropriate industry std and message in REFDATA_MSG_SEGMENTS
5. You add the appropriate FIELDS and associate them to the appropriate industry std and message in the REFDATA_SEGMENT_FIELDS

# KiCad Shared Object Dockerfile

This repository contains the Dockerfile and the other files needed to build a docker image with KiCad and python 2.7.

Several tags of the image are available. The tags of the repo correspond to the version of KiCad.

A "CI template.yml" file is also present. It's a "template" for the ".gitlab-ci.yml" file you will use in a PCB project with **automatic gerber files generation.**
The variable PROJECTNAME and VERSION have to be changed depending on the project. Also try to use an image corresponding with the version of KiCad you have locally.

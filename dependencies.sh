#!/bin/bash

#Project dependencies file
#Final authority on what's required to fully build the project

# byond version
# Extracted from the Dockerfile. Change by editing Dockerfile's FROM command.
LIST=($(sed -n 's/.*byond:\([0-9]\+\)\.\([0-9]\+\).*/\1 \2/p' Dockerfile))
export BYOND_MAJOR=${LIST[0]}
export BYOND_MINOR=${LIST[1]}
unset LIST

#node version
export NODE_VERSION=14
export NODE_VERSION_PRECISE=14.16.1

#rust_g git tag
export RUST_G_VERSION=3.1.0

#node version
export NODE_VERSION=12

# PHP version
export PHP_VERSION=7.2

# SpacemanDMM git tag
export SPACEMAN_DMM_VERSION=suite-1.8

# Python version for mapmerge and other tools
export PYTHON_VERSION=3.9.0

# Extools git tag
export EXTOOLS_VERSION=v0.0.6

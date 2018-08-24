#!/bin/bash
#

cd ews-minimal-notebook
./build.sh
cd ..

cd ews-notebook
./build.sh
cd ..

cd ews-notebook-r-julia
./build.sh
cd ..
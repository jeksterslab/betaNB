#!/bin/bash

git clone git@github.com:jeksterslab/betaNB.git
rm -rf "$PWD.git"
mv betaNB/.git "$PWD"
rm -rf betaNB

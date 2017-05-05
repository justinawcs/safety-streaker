#!/bin/bash
# Gives Directory names of nodes.lua files

find . -name node.lua | xargs dirname


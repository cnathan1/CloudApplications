#!/bin/bash

x=$(wc  -l $1 | cut -f 1 -d " ")
y=$((x/30))

split -d -l $y $1 input_chunk/chunk-

#!/bin/bash
for i in $(seq 1 5); do sleep 0.5; clear; v=$(shuf -i 1-100 -n 1); figlet Roleta; echo "------> 5x de 1 a 100 <------"; figlet $v; done

# Usando nanoseconds tambem da
# v_nano=$(date +'%N') && echo $v_nano

#!/bin/bash
sudo su

cd /opt/minecraft

nohup bash run.sh </dev/null &>/dev/null &

sleep 5m
nohup bash notify.sh </dev/null &>/dev/null &

sleep 10m
nohup bash auto-destroy.sh </dev/null &>/dev/null &

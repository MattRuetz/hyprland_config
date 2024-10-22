#!/bin/bash
SINK=$(wpctl status | grep "*" | grep "Sink" | sed 's/[^a-zA-Z0-9 ]//g' | sed 's/^[ \t]*//' | cut -d " " -f 2)
wpctl set-default $SINK

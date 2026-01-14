#!/bin/bash
# Set LIBRARY_PATH to include the pixi environment library directory
# This allows the linker to find libraries like lttng-ust during colcon build

if [ -n "$CONDA_PREFIX" ]; then
    export LIBRARY_PATH="${CONDA_PREFIX}/lib${LIBRARY_PATH:+:$LIBRARY_PATH}"
fi

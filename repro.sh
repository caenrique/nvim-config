#!/usr/bin/env bash

export XDG_DATA_HOME='.repro/data'
export XDG_CONFIG_HOME='.repro/config'
export XDG_RUNTIME_DIR='.repro/runtime'
export XDG_STATE_HOME='.repro/state'

nvim -u repro.lua

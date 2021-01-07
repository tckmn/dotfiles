#!/usr/bin/env bash

# get dbus env vars
set -a
. ~/.dbus/session-bus/*
set +a

# start systemd units
# systemctl --user import-environment DISPLAY DBUS_SESSION_BUS_ADDRESS XDG_SESSION_ID
systemctl --user import-environment
systemctl --user start graphical-session.target

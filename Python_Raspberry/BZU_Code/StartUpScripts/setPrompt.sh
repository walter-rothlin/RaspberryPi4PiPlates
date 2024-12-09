#!/bin/bash


PREPAREDPROMPT="${debian_chroot:+($debian_chroot)}\[\033[01;32m\][\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$"

export PS1="\[\033[01;32m\]$1:[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\\$ "
#!/bin/bash

ls -al | grep -v ^d | grep -v total | wc -l

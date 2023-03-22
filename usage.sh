#!/usr/bin/sh

# File: usage.sh
# Author: Christopher Bates <christopher.bates.developer@gmail.com>
# Date: Wed Mar 22 09:49:51 AM PDT 2023

# This shell script prints the SYNOPSIS section of its argument to standard output.

# SYNOPSIS
# 	usage <command>

command="$(echo $@)" # Account for commands with more than 1 token.

# Get starting line for SYNOPSIS section of manpage for <command>.
start_line="$( man ${command} | grep -n -m 1 -e 'SYNOPSIS' | grep -o -e "[[:digit:]]*")"

# Get the number of lines in the SYNOPSIS section of manpage for <command>.
second_line="$(( ${start_line} + 1))"
section_height="$( man ${command} | tail -n +${second_line} | grep -n -m 1 -e ^[[:upper:]] | grep -o -e [[:digit:]]*)"

# Get the last line of the SYNOPSIS section.
stop_line="$(( ${start_line} + ${section_height} - 1 ))" # Avoid the off-by-one error!

# Output the SYNOPSIS section. 
man ${command} | head -${stop_line} | tail -n +${start_line}

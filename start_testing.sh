#!/bin/bash
echo "You are about to use the script command to record your testing session. Please input the required information below without file extensions."
read -e -p 'Timing Path and Name? [/root/PenTest_Timing]: ' time_name
read -e -p 'Log Path and Name? [/root/PenTest_Log]: ' log_name

time_name=${time_name:-/root/PenTest_Timing}
log_name=${log_name:-/root/PenTest_Log}
d=$(date +%Y-%m-%d_%H:%M:%S)

timing=${time_name}_${d}.txt
logs=${log_name}_${d}.log

script --timing=$timing $logs

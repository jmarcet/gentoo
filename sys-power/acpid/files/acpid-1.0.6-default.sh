#!/bin/sh
# /etc/acpi/default.sh
# Default acpi script that takes an entry for all actions

set $*

group=${1%%/*}
action=${1#*/}
device=$2
id=$3
value=$4

log_unhandled() {
	logger "ACPI event unhandled: $*"
	logger "     group: ${group} || action: ${action} || device: ${device} || id: ${id} || value: ${value}"
}

case "$group" in
	button)
		case "$action" in
			power)
				/sbin/init 0
			;;

			# if your laptop doesnt turn on/off the display via hardware
			# switch and instead just generates an acpi event, you can force
			# X to turn off the display via dpms.  note you will have to run
			# 'xhost +local:0' so root can access the X DISPLAY.
			lid)
				SYS_BRIGHTNESS=$(ls /sys/class/backlight/*_backlight/brightness)
				CUR_BRIGHTNESS=`cat ${SYS_BRIGHTNESS}`
				LAST_BRIGHTNESS=/tmp/.last_brightness
				logger "ACPI handled -> lid: brigthness=${CUR_BRIGHTNESS}"
				case "$id" in
					open)
						if [ -e "${LAST_BRIGHTNESS}" ]; then
							cat ${LAST_BRIGHTNESS} > "${SYS_BRIGHTNESS}"
							rm -f "${LAST_BRIGHTNESS}"
						fi
						CUR_BRIGHTNESS=`cat ${SYS_BRIGHTNESS}`
						#logger "ACPI handled -> lid open: brightness=${CUR_BRIGHTNESS}"
					;;
					close)
						[ -e "${LAST_BRIGHTNESS}" ] && rm -f "${LAST_BRIGHTNESS}"
						echo "${CUR_BRIGHTNESS}" > "${LAST_BRIGHTNESS}"
						echo 0 > "${SYS_BRIGHTNESS}"
						#logger "ACPI handled -> lid close: brightness=${CUR_BRIGHTNESS}"
					;;
				esac
			#	xset dpms force off
			;;

			*)	log_unhandled $* ;;
		esac
	;;

	ac_adapter)
		case "$value" in
			# Add code here to handle when the system is unplugged
			# (maybe change cpu scaling to powersave mode).  For
			# multicore systems, make sure you set powersave mode
			# for each core!
			*0)
				for CPU in $(ls  /sys/devices/system/cpu/|grep -E "cpu[0-9]+"); do
					echo conservative > /sys/devices/system/cpu/${CPU}/cpufreq/scaling_governor
					logger "ACPI handled -> bat: ${CPU} `cat /sys/devices/system/cpu/${CPU}/cpufreq/scaling_governor`"
				done
				for controller in $(ls /sys/class/scsi_host/|grep -E "host[0-9]+"); do
					echo min_power > /sys/class/scsi_host/${controller}/link_power_management_policy
					logger "ACPI handled -> bat: ${controller} `cat /sys/class/scsi_host/${controller}/link_power_management_policy`"
				done
			;;

			# Add code here to handle when the system is plugged in
			# (maybe change cpu scaling to performance mode).  For
			# multicore systems, make sure you set performance mode
			# for each core!
			*1)
                for CPU in $(ls  /sys/devices/system/cpu/|grep -E "cpu[0-9]+"); do
                    echo ondemand > /sys/devices/system/cpu/${CPU}/cpufreq/scaling_governor
					logger "ACPI handled -> ac: ${CPU} `cat /sys/devices/system/cpu/${CPU}/cpufreq/scaling_governor`"
                done
				for controller in $(ls /sys/class/scsi_host/|grep -E "host[0-9]+"); do
					echo max_performance > /sys/class/scsi_host/${controller}/link_power_management_policy
					logger "ACPI handled -> ac: ${controller} `cat /sys/class/scsi_host/${controller}/link_power_management_policy`"
				done
			;;

			*)	log_unhandled $* ;;

		esac
	;;
	battery|processor) ;;

	*)	log_unhandled $* ;;
esac

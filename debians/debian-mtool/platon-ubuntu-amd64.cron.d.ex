#
# Regular cron jobs for the platon-all package
#
0 4	* * *	root	[ -x /usr/bin/platon-all_maintenance ] && /usr/bin/platon-all_maintenance

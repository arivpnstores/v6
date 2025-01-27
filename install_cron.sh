#!/bin/bash

clear


    cat >/etc/cron.d/xp_all <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		0 0 * * * root /usr/bin/xp
	END
    cat >/etc/cron.d/logclean <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		*/59 * * * * root /usr/bin/logclean
	END
	    cat >/etc/cron.d/daily_reboot <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		0 3 * * * /sbin/reboot
	END
    cat >/etc/cron.d/autobackup <<-END
		SHELL=/bin/sh
		PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
		2 0 * * * root /usr/local/sbin/autobackup
	END
     cat >/etc/cron.d/autoupdate <<-END
		SHELL=/bin/bash
                PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
                30 0 * * * root wget --no-check-certificate https://raw.githubusercontent.com/arivpnstores/v6/main/menu/install_menu.sh -O update.sh && chmod +x update.sh && ./update.sh && rm -rf update.sh
	END
    cat >/etc/cron.d/kill_account <<-END	
	        SHELL=/bin/bash
                PATH=/sbin:/bin:/usr/sbin:/usr/bin
                */1 * * * * root /usr/local/sbin/kill_exp exp_kill
                */1 * * * * root /usr/local/sbin/kill_exp vme_kill
                */1 * * * * root /usr/local/sbin/kill_exp vle_kill
                */1 * * * * root /usr/local/sbin/kill_exp tro_kill
                */1 * * * * root /usr/local/sbin/kill_exp ssh_kill                                
	END

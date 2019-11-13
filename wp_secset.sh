#!/bin/bash

#############################################################################################
# Enter full, valid path to the new or existing location of the WordPress directory,
# e.g. /var/www/wordpress or /var/www/myblog:" (# ls -alh /var/www < command can be useful)
MVWPLOC=/var/www/myblog
#############################################################################################

# Run script as root
if [[ "$EUID" -ne 0 ]]; then
	echo -e "Sorry, you need to run this as root"
	exit 1
fi

# Clean Screen
clear

# Main menu
echo "Options:"
echo "   1) Download, unzip, move WordPress to provided directory"
echo "   2) Import WordPress database and update URIs after migration"
echo "   3) Add security rules to wp-config (use option after installing WordPress)"
echo "   4) Add security rules for Nginx (use this after installing Nginx)"
echo "   5) Download mu-plugins (Brute Force Attack Deffender)"
echo "   6) Update the script"
echo "   7) Exit or go to previous menu"
echo

	while [[ $WPOPT !=  "1" && $WPOPT != "2" && $WPOPT != "3" && $WPOPT != "4" && $WPOPT != "5" && $WPOPT != "6" && $WPOPT != "7" ]]; do
		read -p "Select an option [1-7]: " WPOPT
	done
# Prepare directory for downloads, sources
	if [[ ! -d /usr/local/src/wordpress ]]; then
		mkdir -p /usr/local/src/wordpress
	fi
# Install dependencies
	if [[ ! -f /usr/bin/unzip ]]; then
		echo
		echo "Please wait installing unzip..."
        	apt install unzip -y &>/dev/null
		echo
	fi
	if [[ ! -f /usr/bin/wget ]]; then
		echo
		echo "Please wait installing wget...."
        	apt install wget -y &>/dev/null
		echo
	fi

case $WPOPT in
	1) # Download, unzip and move WordPress folder
	if [[ -d $MVWPLOC ]]; then
		echo
		read -p "It seems like WordPress folder is not empty, continue downlaod? [y/n]: " -e WPRDWN
		if [[ "$WPRDWN" = 'y' ]]; then
			cd /usr/local/src/wordpress || exit 1
			echo
			wget -c https://wordpress.org/latest.zip
			unzip latest.zip
			echo
			mv wordpress $MVWPLOC
			chown -R root:root $MVWPLOC
			chown -R www-data:www-data $MVWPLOC/wp-content/
			echo
			read -n1 -r -p "Press any key to continue..."
                	echo
			ls -alh $MVWPLOC
			echo
			echo "WordPress files and folders permissions after changes:"
			echo
		else
			echo
			exit
			echo
		fi
	fi
	;;
	2)
		echo
		echo "Comming soon"
		echo

	;;
	3) # Downlaod wp-restrictions for Nginx
		if [[ ! -f $MVWPLOC/wp-config.php ]]; then
			echo
			echo -e "It seems like WordPress is not installed yet\nor wp-config.php is in different location."
			echo
			exit 1
		else
			cd /usr/local/src/wordpress || exit 1
			wget https://raw.githubusercontent.com/intsez/WordPress/master/addins2_wp-config.php.txt
			cat addins2_wp-config.php.txt >> $MVWPLOC/wp-config.php
			if [ $? -eq 0 ]; then
				cat $MVWPLOC/wp-config.php
				echo
				echo "Rules added to $MVWPLOC/wp-config.php. Adjust them as needed."
				echo
			else
				echo "Wrong path or wp-config.php doesn't exist"
			fi
		fi
	;;
	4) # Downlaod additional configuration for Nginx
	if [[ ! -d /etc/nginx/conf.d ]]; then
		echo
		echo -e "It seems like Nginx is not installed or directory /etc/nginx/conf.d doesn't exist. Exiting."
		echo
		exit 1
	else

		if [[ -e /etc/nginx/conf.d/wp_nx_restr.conf ]]; then
			echo
			echo -e "File /etc/nginx/conf.d/wp_nx_restr.conf exists.\nRename the file or update it manually."
			echo
			exit 1
		fi
		cd /etc/nginx/conf.d || exit 1
		echo
		wget https://raw.githubusercontent.com/intsez/WordPress/master/wp_nx_restr.conf
		echo
		echo "Rules saved in '/etc/nginx/conf.d/'. Adjust them as need it and reload Nginx."
	fi
	;;
	5) # Select, download then install plugins and 'mu-plugins'"
	if [[ ! -d /etc/fail2ban ]]; then
		echo "It seems like fail2ban is not installed, this plugin won't work without fail2ban."
		read -p "Install fail2ban? [y/n]: " -e F2B_INST
   		if [[ "$F2B_INST" = 'y' ]]; then
			apt update; apt install fail2ban -y
		fi
	fi
	if [[ ! -d $MVWPLOC/wp-content/mu-plugins ]]; then
		mkdir -p $MVWPLOC/wp-content/mu-plugins
	fi
	# Download configuration for mu-plugin
	if [[ -e $MVWPLOC/wp-content/mu-plugins/wordpress-auth.php ]]; then
		echo
		echo "Plugin already installed."
		echo
		exit 1
	else
		cd $MVWPLOC/wp-content/mu-plugins || exit 1
		echo -e "<?php\nfunction login_failed_403() {\nstatus_header( 403 );\n}\nadd_action( 'wp_login_failed', 'login_failed_403' );" > wordpress-auth.php
	# Download configuration for fail2ban
		cd /etc/fail2ban/filter.d || exit 1
		echo -e "[Definition]\nfailregex = <HOST>.*POST.*(wp-login\.php|xmlrpc\.php).* 403 " > wordpress-auth.conf
		echo -e "\n[wordpress-auth]\nenabled = true\nport = http,https\nfilter = wordpress-auth\nlogpath = /var/log/nginx/access.log\nmaxretry = 3\nbantime = 3600" >> /etc/fail2ban/jail.local
		echo
		/etc/init.d/fail2ban restart
	# Suggested plugins
		echo
		echo "Other sugested plugins to download:"
		echo
		echo " - HTML Editor Syntax Highlighter"
		echo " - Child Theme Configurator"
		echo " - Responsive Lightbox"
		echo " - Tinymce Advanced"
		echo " - WP Super Cache"
		echo " - Contact Form 7"
		echo " - Google Captcha"
		echo " - Ninja Firewall (Nginx only)"
		echo " - WP Mail Smtp"
		echo " - Cookie Law"
		echo " - JetPack"
	fi
	;;
	6) # Update the script
		echo
		wget https://raw.githubusercontent.com/intsez/WordPress/master/wp_secset.sh -O wp_secset.sh
		chmod +x wp_secset.sh
		echo ""
		echo "Update done."
		echo
		sleep 2
		./wp_secset.sh
		exit
	;;

	7) # Previous menu or exit
		echo
		echo "Bye."
		echo
		exit
	;;
esac
# cleaning after installation
echo
rm -rf /usr/local/src/wordpress
echo

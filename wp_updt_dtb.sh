#!/bin/bash
echo
echo -e "Before we start open this script 'wp_updt_dtb.sh' in any editor\nand provide few variables."
echo
echo "Press any key to continue or ctrl+c to cancel..."
read -n1 -r -p ""

# Provide valid paths and domain/addresses
################################################################################
# Enter full path and valid name to backup database e.g. /backups/mysql/dtb1.sql
pathdtbck=/change/me/dtb1.sql
# Enter valid path to Wordpress directory (e.g. /var/www/wordpress)"
wpath=/var/www/wordpress
# Enter old ip address/domain:
oldaddr=http://change_Old_URI.com
# Enter new ip address/domain:
newaddr=https://to_new_URI.io
################################################################################
echo
echo -e "!!! Warning !!!\n\tThe database that's going to be updated will be completely cleared first."
echo
echo "Current Wordpress database name:"
cat ${wpath}/wp-config.php | grep DB_NAME
echo
echo "Enter database name to update (current Wordpress database name):"
read updtdtbn
echo
echo "Please wait importing database..."
# clearing all tables in current database
mysql -Nse 'show tables' ${updtdtbn} | while read table; do mysql -e "drop table ${table}" ${updtdtbn}; done
# importing database
mysql ${updtdtbn} < ${pathdtbck}
if [ $? -eq 0 ]; then
	echo
	echo "Database imported."
	echo
else
	echo
	echo "Unexpected failure."
	echo
fi
# show then read table_prefix
mysqlshow ${updtdtbn}
echo
echo "Enter imported database table prefix to update current Wordpress table prefix:"
read table_pref
echo -e "UPDATE ${table_pref}options SET option_value = replace(option_value, '${oldaddr}', '${newaddr}') WHERE option_name = 'home' OR option_name = 'siteurl';" > updtSQL.sql
echo -e "UPDATE ${table_pref}posts SET guid = replace(guid, '${oldaddr}','${newaddr}');" >> updtSQL.sql
echo -e "UPDATE ${table_pref}posts SET post_content = replace(post_content, '${oldaddr}', '${newaddr}');" >> updtSQL.sql
echo -e "UPDATE ${table_pref}postmeta SET meta_value = replace(meta_value,'${oldaddr}','${newaddr}');" >> updtSQL.sql
echo -e "UPDATE ${table_pref}usermeta SET meta_value = replace(meta_value, '${oldaddr}','${newaddr}');" >> updtSQL.sql
echo -e "UPDATE ${table_pref}links SET link_url = replace(link_url, '${oldaddr}','${newaddr}');" >> updtSQL.sql
echo -e "UPDATE ${table_pref}comments SET comment_content = replace(comment_content , '${oldaddr}','${newaddr}');" >> updtSQL.sql
echo
echo "Please wait updating database..."
mysql ${updtdtbn} < updtSQL.sql
if [ $? -eq 0 ]; then
	echo
	echo "Database updated."
	rm -rf updtSQL.sql
	mysql -e "FLUSH PRIVILEGES;"
	echo
	echo -e "Remember to change entrys in 'wp-config.php' file, a specially table_prefix = '$table_pref'\nand copy backup of wp-content to new WordPress directory "
	echo
else
	echo
	echo "Unexpected failure."
	echo
fi
echo "Press any key to continue..."
read -n1 -r -p ""
echo
exit

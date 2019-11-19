#!/usr/bin/env bash

# script to delete wordpress spam and trash comments of multiple domains 
# Assumes site directories are under /var/www/html/siteurl
# First give execute permission to script:  chmod +x delete-spam-trash-comments.sh
# To run file ./delete-spam-trash-comments.sh
# cron job entry to Delete all Spam and Trash comments - Daily at 2:00am
# 00 02 * * * /bin/bash /var/www/path-to-script/delete-spam-trash-comments.sh > /var/log/delete-spam-trash-comments.log

SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin


WPSITES=(
domain1.com
domain2.net
domain3.com
domain4.org
)

WPPATH=/var/www/html/

echo " "
echo "Script to Delete all SPAM and TRASH Comments"
echo " "

for i in "${WPSITES[@]}"
do
  :

cd $WPPATH$i

echo "--------------------------------------------- "
echo " "
echo "Domain: $i"
echo "Current Folder:" $(pwd)
echo " "
echo "--------------------------------------------- "

echo " "
echo " "

echo "Before Deleting $i Comment Stats:"
wp comment count --allow-root
echo " "
echo " "

echo "Now deleting $i all spam comments.."
wp comment delete --allow-root $(wp comment list --status=spam --format=ids --allow-root)
echo " "
echo " "

echo "Now deleting $i all trash comments.."
wp comment delete --allow-root $(wp comment list --status=trash --format=ids --allow-root)
echo " "
echo " "

echo "After Deleting $i Comment Stats:"
wp comment count --allow-root
echo " "
echo " "

echo "Deleted all Spam and Trash comments for $i"
echo " "
echo " "

done


echo " "
echo " "
echo "Done Deleting for all sites"
echo " "

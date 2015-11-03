#!/bin/bash

# Script to install Drupal app

# Be careful using database credentials, this script is meant to be used on development server, to speed things up.
dbuser="root"
dbpass="root"
sites_path="/Users/petiar/Sites"

if [ $# -lt 1 ];
then
  echo "Usage: install_drupal.sh appname [dbname]"
  exit
fi

appname=$1

if [ $# -eq 2 ];
then
  dbname=$2
else
  dbname="db_$1"
fi

current_path=`pwd`

cd $sites_path
echo "About to installing application $appname on database $dbname."
echo "Downloading Drupal..."
drush dl drupal --drupal-project-rename=$appname
cd $appname
echo "Installing Drupal..."
drush site-install --db-url="mysql://$dbuser:$dbpass@localhost/$dbname" --site-name=$appname --account-name=admin --account-pass=admin
echo "Disabling clean urls..."
drush vset clean_url 0 --yes
echo "Done. Go to http://localhost/~petiar/$appname"
cd $current_path;
 

#!/usr/bin/env bash

if /usr/local/bin/owncloud-installed
then
  echo "Upgrading server database..."
  /usr/local/bin/owncloud-migrate
else
  echo "Installing server database..."
  /usr/local/bin/owncloud-install
fi

true

#!/bin/sh

#   Copyright © 2017 Teclib. All rights reserved.
#
# fastlane_config.sh is part of FlyveMDMInventory
#
# FlyveMDMInventory is a subproject of Flyve MDM. Flyve MDM is a mobile
# device management software.
#
# FlyveMDMInventory is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 3
# of the License, or (at your option) any later version.
#
# FlyveMDMInventory is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# ------------------------------------------------------------------------------
# @author    Hector Rondon
# @date      25/08/17
# @copyright Copyright © 2017 Teclib. All rights reserved.
# @license   GPLv3 https://www.gnu.org/licenses/gpl-3.0.html
# @link      https://github.com/flyve-mdm/flyve-mdm-ios-inventory
# @link      https://flyve-mdm.com
# ------------------------------------------------------------------------------

echo ----------- Create Fastlane environment variables ------------
# Create Fastlane environment variables
echo FASTLANE_PASSWORD=$FASTLANE_PASSWORD >> .env
echo TELEGRAM_WEBHOOKS=$TELEGRAM_WEBHOOKS >> .env
echo GIT_REPO=$GH_REPO_SLUG >> .env
echo GIT_BRANCH=$CIRCLE_BRANCH >> .env
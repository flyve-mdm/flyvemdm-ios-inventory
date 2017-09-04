#!/bin/sh

#   Copyright © 2017 Teclib. All rights reserved.
#
# script.sh is part of flyve-mdm-ios-inventory
#
# flyve-mdm-ios-inventory is a subproject of Flyve MDM. Flyve MDM is a mobile
# device management software.
#
# flyve-mdm-ios-inventory is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 3
# of the License, or (at your option) any later version.
#
# flyve-mdm-ios-inventory is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# ------------------------------------------------------------------------------
# @author    Hector Rondon
# @date      04/09/17
# @copyright Copyright © 2017 Teclib. All rights reserved.
# @license   GPLv3 https://www.gnu.org/licenses/gpl-3.0.html
# @link      https://github.com/flyve-mdm/flyve-mdm-ios-inventory
# @link      https://flyve-mdm.com
# ------------------------------------------------------------------------------

if [[ ("$TRAVIS_BRANCH" == "develop" || "$TRAVIS_BRANCH" == "master") && "$TRAVIS_PULL_REQUEST" == "true" ]]; then
    xcodebuild test -project ${APPNAME}.xcodeproj -scheme $APPNAME CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO -destination 'name=iPhone 6'
elif [[ "$TRAVIS_BRANCH" != "develop" && "$TRAVIS_BRANCH" != "master" && "$TRAVIS_PULL_REQUEST" == "false" ]]; then
    xcodebuild clean build -project ${APPNAME}.xcodeproj -scheme $APPNAME CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO
fi

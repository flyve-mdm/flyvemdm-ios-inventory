#!/bin/sh

#   Copyright © 2017 Teclib. All rights reserved.
#
# install.sh is part of FlyveMDMInventory
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

# Update gem
gem update --system
# Clean Gem
gem cleanup
# Install jazzy for generate documentation
gem install jazzy
# Install bundler last version
gem install bundler
# Install node
brew install node
# Install jq for json parse
brew install jq
# Install standard-version scope global
npm i -g standard-version
# Install conventional-github-releaser scope global
npm install -g conventional-github-releaser
# Install podspec-bump for increment podspec version
npm install -g podspec-bump
# Install libs from package.json
npm install
# Install gems from Gemfile
bundle install --path vendor/bundle
# Update fastlane plugin
bundle exec fastlane update_plugins

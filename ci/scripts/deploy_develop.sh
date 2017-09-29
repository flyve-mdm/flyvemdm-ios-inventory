#!/bin/sh

#   Copyright © 2017 Teclib. All rights reserved.
#
# deploy_develop.sh is part of FlyveMDMInventory
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
# @date      08/09/17
# @copyright Copyright © 2017 Teclib. All rights reserved.
# @license   GPLv3 https://www.gnu.org/licenses/gpl-3.0.html
# @link      https://github.com/flyve-mdm/flyve-mdm-ios-inventory
# @link      https://flyve-mdm.com
# ------------------------------------------------------------------------------

# Generate CHANGELOG.md and increment version
npm run release -- -t ''
# Get version number from package.json
export GIT_TAG=$(jq -r ".version" package.json)
# Revert last commit
git reset --hard HEAD~1
# Update CFBundleShortVersionString
/usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString ${GIT_TAG}" ${PWD}/${APPNAME}/Info.plist
# Update CFBundleVersion
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $CIRCLE_BUILD_NUM" ${PWD}/${APPNAME}/Info.plist
# Add modified and delete files
git add ${APPNAME}/Info.plist
# Create commit
git commit -m "ci(beta): generate **beta** for version ${GIT_TAG}"

# Generate documentation with jazzy
jazzy \
--clean \
--author Flyve MDM \
--author_url https://flyve-mdm.com \
--github_url $CIRCLE_REPOSITORY_URL \
--output docs \
--theme jazzy/themeFlyve \
--min-acl private \
--objc \
--umbrella-header FlyveMDMInventory/FlyveMDMInventory.h \
--framework-root . \
--sdk iphonesimulator

# Add docs folder
git add docs -f
# Create commit, NOTICE: this commit is not sent
git commit -m "ci(docs): generate **docs** for version ${GIT_TAG}"

# Generate code coverage reporting with xcov
bundle exec fastlane coverage

# Add coverage folder
git add coverage -f
# Create commit, NOTICE: this commit is not sent
git commit -m "ci(docs): generate **coverage** for version ${GIT_TAG}"

# Update documentation on gh-pages
git branch -D gh-pages
git fetch origin gh-pages
git checkout gh-pages

# Remove old documetation
rm -rf docs
rm -rf coverage

git checkout $CIRCLE_BRANCH docs

# Add docs folder
git add docs
# Create commit
git commit -m "ci(docs): generate documentation with jazzy for version ${GIT_TAG}"

# Get code coverage from develop branch
git checkout $CIRCLE_BRANCH coverage
# Add coverage folder
git add coverage
# Create commit
git commit -m "ci(docs): generate coverage with xcov for version ${GIT_TAG}"

# Push commit to origin gh-pages branch
git push origin gh-pages

git checkout $CIRCLE_BRANCH -f

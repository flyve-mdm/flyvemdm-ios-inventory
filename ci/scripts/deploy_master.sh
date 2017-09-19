#!/bin/sh

#   Copyright © 2017 Teclib. All rights reserved.
#
# deploy_master.sh is part of FlyveMDMInventory
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
# @date      09/09/17
# @copyright Copyright © 2017 Teclib. All rights reserved.
# @license   GPLv3 https://www.gnu.org/licenses/gpl-3.0.html
# @link      https://github.com/flyve-mdm/flyve-mdm-ios-inventory
# @link      https://flyve-mdm.com
# ------------------------------------------------------------------------------

GH_COMMIT_MESSAGE=$(git log --format=oneline -n 1 $CIRCLE_SHA1)

if [[ $GH_COMMIT_MESSAGE != *"ci(release): generate CHANGELOG.md for version"* && $GH_COMMIT_MESSAGE != *"ci(build): release version"* ]]; then

    # Generate CHANGELOG.md and increment version
    npm run release -- -t '' -m "ci(release): generate CHANGELOG.md for version %s"
    # Push tag to github
    # conventional-github-releaser -t $GH_TOKEN -r 0
    # Get version number from package.json
    export GIT_TAG=$(jq -r ".version" package.json)
    # Update CFBundleShortVersionString
    /usr/libexec/PlistBuddy -c "Set :CFBundleShortVersionString ${GIT_TAG}" ${PWD}/${APPNAME}/Info.plist
    # Update CFBundleVersion
    /usr/libexec/PlistBuddy -c "Set :CFBundleVersion $CIRCLE_BUILD_NUM" ${PWD}/${APPNAME}/Info.plist
    # Increment podspec version
    podspec-bump -i ${GIT_TAG} -w
    # Add modified and delete files
    git add -u
    # Create commit
    git commit -m "ci(build): release version ${GIT_TAG}"
    # Push commits and tags to origin branch
    git push --follow-tags origin $CIRCLE_BRANCH

    # Create zip example code
    zip -r $CIRCLE_ARTIFACTS/app_example_code.zip Example/*
    # Create release with github-release
    github-release release \
    --user $CIRCLE_PROJECT_USERNAME \
    --repo $CIRCLE_PROJECT_REPONAME \
    --tag ${GIT_TAG} \
    --name "Inventory Engine v${GIT_TAG}" \
    --description "Inventory Engine v${GIT_TAG}"
    # Upload example code release
    github-release upload \
    --user $CIRCLE_PROJECT_USERNAME \
    --repo $CIRCLE_PROJECT_REPONAME \
    --tag ${GIT_TAG} \
    --name "example.zip" \
    --file $CIRCLE_ARTIFACTS/app_example_code.zip

    # Update CHANGELOG.md on gh-pages
    git branch -D gh-pages
    git fetch origin gh-pages
    git checkout gh-pages
    git checkout $CIRCLE_BRANCH CHANGELOG.md

    # Create header content
    HEADER="---\nlayout: modal\ntitle: changelog\n---\n"
    # Duplicate CHANGELOG.md
    cp CHANGELOG.md CHANGELOG_COPY.md
    # Add header to CHANGELOG.md
    (echo $HEADER ; cat CHANGELOG_COPY.md) > CHANGELOG.md
    # Remove CHANGELOG_COPY.md
    rm CHANGELOG_COPY.md

    # Add CHANGELOG.md
    git add CHANGELOG.md
    # Create commit
    git commit -m "ci(docs): generate CHANGELOG.md for version ${GIT_TAG}"
    # Push commit to origin gh-pages branch
    git push origin gh-pages

    # Checkout to release branch
    git checkout $CIRCLE_BRANCH -f
fi

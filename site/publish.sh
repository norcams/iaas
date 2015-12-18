#!/bin/bash -eux

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo

# Add changes to git.
git add -A public/

# Commit changes.
msg="site/publish.sh: site update"
git commit -m "$msg"

git push origin master
(cd .. && git subtree push --prefix=site/public norcams:iaas gh-pages)

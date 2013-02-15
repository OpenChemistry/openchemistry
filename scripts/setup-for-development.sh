#!/usr/bin/env bash

# Make sure we are inside the repository.
cd "${BASH_SOURCE%/*}/.."

echo "Ensuring all submodules are checked out and up to date..."
git submodule init
git submodule sync
git submodule update

# Rebase master by default
git config rebase.stat true
git config branch.master.rebase true

echo "Checking basic user information..."
scripts/gitsetup/setup-user
echo

scripts/gitsetup/setup-hooks
echo

echo "Setting up git aliases..."
scripts/setup-git-aliases
echo

echo "Setting up Gerrit..."
scripts/gitsetup/setup-gerrit ||
  echo "Failed to setup Gerrit. Run this script again to retry."
echo

setup_version=1
git config hooks.setup ${setup_version}

read -ep "Set up submodules for development? [Y/n]: " r
if [ "$r" == "Y" ] || [ "$r" == "y" ] || [ "$r" == "" ]; then
  submodules=(avogadrolibs avogadroapp avogadrodata mongochem molequeue)
  for module in ${submodules[@]};
  do
    cd $module
    echo
    echo "Configuring '$module' for development."
    echo
    scripts/setup-for-development.sh || die "$module failed to setup."
    cd ..
  done
fi

echo "Setup for development complete for Open Chemistry supermodule."

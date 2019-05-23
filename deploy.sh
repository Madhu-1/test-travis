#!/bin/bash
if [ "${TRAVIS_BRANCH}" == 'csi' ]; then
	export ENV_RBD_IMAGE_VERSION='v0.3-canary'
	export ENV_CEPHFS_IMAGE_VERSION='v0.3-canary'
	echo "@@@@@@@@ csi branch"
elif [ "${TRAVIS_BRANCH}" == 'master' ]; then
	export ENV_RBD_IMAGE_VERSION='canary'
	export ENV_CEPHFS_IMAGE_VERSION='canary'
	echo "##### master branch"
else
	echo "am i here???? !!! Branch ${TRAVIS_BRANCH} is not a deployable branch; exiting"
	exit 0 # Exiting 0 so that this isn't marked as failing
fi

if [ "${TRAVIS_PULL_REQUEST}" == "false" ]; then
	echo "This is for the branch master"
	echo ${TRAVIS_BRANCH}

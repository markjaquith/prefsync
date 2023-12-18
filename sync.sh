#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ICLOUD=$DIR/iCloud
PREFS=~/Library/Preferences

# If the first argument is push, and a second argument is a valid file, push that file to iCloud.
if [ "$1" == "push" ] && [ -f "$2" ]; then
	FILE=$(basename "$2")
	echo "⬆️  $FILE"
	cp "$2" "$ICLOUD"
	exit 0
fi

# If the first argument is push, and a second argument is a valid file inside prefs, push that file to iCloud.
if [ "$1" == "push" ] && [ -f "$PREFS/$2" ]; then
	FILE=$(basename "$2")
	echo "⬆️  $FILE"
	cp "$PREFS/$2" "$ICLOUD"
	exit 0
fi

# If the first argument is pull, and a second argument is a valid file, pull that file from iCloud.
if [ "$1" == "pull" ] && [ -f "$2" ]; then
	FILE=$(basename "$2")
	echo "⬇️  $FILE"
	cp "$ICLOUD/$FILE" "$PREFS/$2"
	exit 0
fi

# If the first argument is pull, and a second argument is a valid file inside iCloud, pull that file to iCloud.
if [ "$1" == "pull" ] && [ -f "$ICLOUD/$2" ]; then
	FILE=$(basename "$2")
	echo "⬇️  $FILE"
	cp "$ICLOUD/$2" "$PREFS"
	exit 0
fi

# If the first argument is list, list all files in iCloud.
if [ "$1" == "list" ]; then
	ls -1 "$ICLOUD/"
	exit 0
fi

# If the first argument is pull, pull all prefs from iCloud.
if [ "$1" == "pull" ]; then
	FILES=$(ls -1 "$ICLOUD/")
	for FILE in $FILES; do
		if [ -f "$ICLOUD/$FILE" ]; then
			echo "⬇️  $FILE"
			cp "$ICLOUD/$FILE" "$PREFS"
		fi
	done
	exit 0
fi

# If the first argument is push, push all prefs to iCloud, only pushing prefs that already exist on iCloud.
if [ "$1" == "push" ]; then
	FILES=$(ls -1 "$ICLOUD/")
	for FILE in $FILES; do
		if [ -f "$PREFS/$FILE" ]; then
			echo "⬆️  $FILE"
			cp "$PREFS/$FILE" "$ICLOUD"
		fi
	done
	exit 0
fi

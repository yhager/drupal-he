#!/bin/bash

PACKAGE_DIR="../.build"
VER=$(git describe --all|sed 's@.*/\(.*\)@\1@')
PACKAGE=../he-$VER.tar.gz

# TODO: use LANG variable instead of hardcoding it.

rm -rf $PACKAGE_DIR
for file in *-*.po; do 
  DIR=$(echo $file | sed 's@\([a-z]*\)\-\([a-z]*\).po@\1/\2/translations@'); 
  mkdir -p $PACKAGE_DIR/$DIR;
  FILE=$(echo $file | sed 's@\([a-z]*\)\-\([a-z]*\).po@\1-\2.he.po@');
  cp $file $PACKAGE_DIR/$DIR/$FILE
done

for file in general.po includes.po misc.po; do
  FILE=$(echo $file | sed 's@\([a-z]*\).po@\1.he.po@');
  cp $file $PACKAGE_DIR/modules/system/translations/$FILE;
done

INSTALLER_DIR="$PACKAGE_DIR/profiles/default/translations"
mkdir -p $INSTALLER_DIR
cp installer.po $INSTALLER_DIR/he.po

for file in *.txt; do
  cp $file $PACKAGE_DIR/.
done

tar zcf $PACKAGE -C $PACKAGE_DIR .
rm -rf $PACKAGE_DIR

echo package is at $PACKAGE

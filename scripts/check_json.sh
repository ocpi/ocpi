#!/bin/bash

echo "================================================="
echo "lint all JSON files in a directory"
echo "================================================="
echo ""

RETVAL=0
FILE_COUNT=0
ERROR_COUNT=0
for jsonfile in *.json; do
    jsonlint-php -q $jsonfile
    if [ $? != 0 ]; then
      echo ""
      ((++ERROR_COUNT));
      RETVAL=1
    fi
    ((++FILE_COUNT));
done

echo "JSON files checked: $FILE_COUNT, errors: $ERROR_COUNT";
echo ""

exit $RETVAL


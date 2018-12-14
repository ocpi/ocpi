#!/bin/bash

echo "================================================="
echo "lint all JSON files in a directory"
echo "================================================="
echo ""

RETVAL=0
for jsonfile in *.json; do
    jsonlint $jsonfile
    if [ $? != 0 ]; then
      echo "ERROR: "
      jsonlint -v $jsonfile
      echo ""
      RETVAL=1
    fi
done

exit $RETVAL


#!/bin/sh

if [ $# -lt 2 ]; then
  echo "Usage: $0 YYYY-MM-DD keyword" 1>&2
  exit 1
fi

export AWS_DEFAULT_PROFILE={your aws's profile}

export EXPORT_DATECMD={date or gdate}
export EXPORT_DESTINATION_S3BUCKET={your s3bucket}

CURRENT_DIR=$(cd $(dirname $0); pwd)
sh $CURRENT_DIR/grep.sh "{your s3's folder name from s3 bucket}/$1" $2

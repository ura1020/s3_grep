#!/bin/sh

#===================================================================================
# s3に日時エクスポートしたアーカイブ状態のログに対するgrep
# keywordはワイルドカード使用可
# author ura1020
#===================================================================================

if [ $# -lt 2 ]; then
  echo "Usage: $0 s3dir/YYYY-MM-DD keyword" 1>&2
  exit 1
fi

EXPORT_DATECMD=${EXPORT_DATECMD:-date}
EXPORT_DESTINATION_S3BUCKET=$EXPORT_DESTINATION_S3BUCKET

start_time=$($EXPORT_DATECMD '+%Y-%m-%d %H:%M:%S')
echo "start_time:$start_time"

target_s3dir=$1
keyword=$2
echo "target_s3dir:${target_s3dir} keyword:${keyword}"

s3root=${EXPORT_DESTINATION_S3BUCKET}/${target_s3dir}
echo "s3root:${s3root}"

files=$(aws s3 ls ${s3root} \
  --recursive | awk '{print $4}')

result=~/s3_grep_$($EXPORT_DATECMD '+%Y%m%d_%H%M%S').log
:> $result
for file in ${files[@]} ; do
  path="s3://${EXPORT_DESTINATION_S3BUCKET}/${file}"
  echo "zgrep -a \"${keyword}\" ${path}"
  aws s3 cp ${path} - | zgrep -a ${keyword} >> $result
  total_line=$(cat $result | wc -l)
  echo "total_line:$total_line"
done

echo "grepped to ${result}"

end_time=$($EXPORT_DATECMD '+%Y-%m-%d %H:%M:%S')
echo "end_time:$end_time"

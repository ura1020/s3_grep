# CloudWatchLogs から S3 にエクスポートしたログのgrepツール

## 概要
https://github.com/ura1020/cloudwatchlogs_export.git
でエクスポートしたアーカイブログを直接grepするツールです。<br>
VPC内であれば通信量は発生しません。<br>

## 使い方
```
# 日付指定
sh sample.sh 2020-08-08 keyword
```

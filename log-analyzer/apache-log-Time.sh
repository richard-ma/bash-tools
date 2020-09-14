#!/bin/sh

echo "查询时间访问URL: $2"
cat $1 | grep $2 | awk '{print $7}' | sort | uniq -c | sort -nr 

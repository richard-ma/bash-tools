#!/bin/sh

echo "访问时间热点"
awk '{print $4}' $1|cut -c 14-18|sort|uniq -c|sort -nr|head

echo "访问IP热点"
awk '{print $1}' $1|sort|uniq -c|sort -nr|head

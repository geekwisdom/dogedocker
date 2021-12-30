#!/bin/bash
#Get the latest dogecoin core ver
while [ 1 ] ; do
latestver=`curl --silent "https://api.github.com/repos/dogecoin/dogecoin/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")'`
lastver=`cat doge.version`
if [ "$latestver" == "$lastver" ] ; then
echo "version unchanged"
else
echo "new versoin detected $latestver!"
ver=`echo $latestver | sed s/v//g` 
file_to_get="https://github.com/dogecoin/dogecoin/releases/download/$latestver/dogecoin-$ver-x86_64-linux-gnu.tar.gz"
final_file="dogecoin-$ver-x86_64-linux-gnu.tar.gz"
foldername="dogecoin-$ver"
echo "file to get is $file_to_get"
/home/dogecoin/data/doge_stop
sleep 20
wget $file_to_get
rm -rf dogecoin
tar -xvf $final_file
mv $foldername dogecoin
rm $final_file
/home/dogecoin/data/doge_start
echo $latestver > doge.version
fi
echo "Sleeping..."
sleep 60
#restart if needed
r=`ps waux | grep "dogecoind" | grep -v "grep"`
if [ "$r" == "" ] ; then
/home/dogecoin/data/doge_start
fi
#check again in about 24hours
sleep 86400
done

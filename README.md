# GeekWisdom Dogecoin Docker

Automatically build your dogecoin server inside a docker

Don't forget to update the data/dogecoin.conf with a petter rpcusername and password!

Build It: 

docker build -t geekwisdom/dogecoin .

Run It: 

docker run -d -p 22555:22555 -p 18332:18332 geekwisdom/dogecoin

Mount your own data dir

sudo docker run -d -p 22555:22555 -p 18332:18332 -v /media/docker1/dogecoin:/home/dogecoin/data geekwisdom/dogecoin

Be sure to copy the doge_start and doge_stop into your data dir!

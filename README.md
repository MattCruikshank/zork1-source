> sudo docker build --progress=plain -t zork1-source .
>
> sudo docker run -it -v $(pwd)/saves:/home/builder/zork1/save zork1-source

> sudo docker run -it -v $(pwd)/saves:/home/builder/zork1/save mattcruikshank/zork1-source 

//////////////////////

> docker build -t mattcruikshank/zork1-source:latest .

> docker login

> docker push mattcruikshank/zork1-source:latest

> docker run -it --rm -v $(pwd)/saves:/home/zork/save mattcruikshank/zork1-source:latest

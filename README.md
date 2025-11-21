> sudo docker build --progress=plain -t zork1-source .
>
> sudo docker run -it -v $(pwd)/saves:/home/builder/zork1/save zork1-source

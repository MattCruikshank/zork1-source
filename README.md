To try it:

> docker run -it --rm -v $(pwd)/saves:/home/zork/save mattcruikshank/zork1-source:latest

https://hub.docker.com/repository/docker/mattcruikshank/zork1-source/

Notes for how I build, push, and run it:

> docker build -t mattcruikshank/zork1-source:latest .

> docker push mattcruikshank/zork1-source:latest

> docker run -it --rm -v $(pwd)/saves:/home/zork/save mattcruikshank/zork1-source:latest

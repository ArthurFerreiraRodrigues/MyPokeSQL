#!/bin/bash

sudo bash container-build.sh
sudo docker exec -it mypokesql-mysql-1 bash
Docker examples:
========
See https://github.com/wsargent/docker-cheat-sheet

* Server:
    * Start the server
        > docker-machine start $MACHINE_NAME 
    * Stop the server
        > docker-machine stop $MACHINE_NAME 
* Containers:
    * Show all running containers
        > docker ps -a
    * Stop all running containers
        > docker ps -a -q | xargs docker stop
* Images:
    * List all images with no label and no running container
        > docker images -f dangling=true -q

    * Delete all images with no label and no running container
        > docker images -f dangling=true -q | xargs docker rmi

EWS Related examples:
========

* Start the complete notebook on host port `10000` in `F:\wi_A` (cannot work directly under `F:\`):
    > docker run --name jupyter --rm -p 8888:10000 -v /ews_drives:/home/ewsuser/ews_drives ewsconsulting/notebook:lastest start.sh jupyter notebook --notebook-dir=/home/ewsuser/ews_drives/f/wi_A


# Backup and restore files
* Backup:
    > docker run --name jupyter -d -v $(pwd):/home/ewsuser ewsconsulting/notebook:lastest bash 
    > docker run --name jupyter -d ewsconsulting/notebook:lastest bash
    > docker exec jupyter /home/ewsuser -u root --password=root /home/ewsuser/package-list.txt > package-list.txt

* Restore
    > cat MYFILE | docker exec -i CONTAINER /home/ewsuser -u root --password=root MYFILE
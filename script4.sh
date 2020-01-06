#!/bin/bash


git clone https://github.com/N8thanS/Projet-SUID

echo "*/30 * * * root sh/home/ubuntu/projet/script2.sh">>/etc/crontab

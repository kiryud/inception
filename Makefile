# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jijeong <jijeong@student.42seoul.k>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/12/13 12:26:21 by jijeong           #+#    #+#              #
#    Updated: 2023/12/13 12:26:32 by jijeong          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: up

ps:
	sudo docker-compose -f ./srcs/docker-compose.yml ps


up: volume
	sudo docker-compose -f ./srcs/docker-compose.yml up --build

build:
	sudo docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	sudo docker-compose -f ./srcs/docker-compose.yml down

clean:
	sudo docker-compose -f ./srcs/docker-compose.yml down -v
re:
	sudo make fclean
	sudo make up

fclean:
	sudo make clean
	sudo docker system prune --all --force --volumes
	sudo docker network prune --force
	sudo docker volume prune --force
	sudo rm -fr /home/jijeong/volume

volume:
	sudo mkdir -p /home/jijeong/volume/wp
	sudo mkdir -p /home/jijeong/volume/db

.PHONY: all ps up build down clean re fclean volume
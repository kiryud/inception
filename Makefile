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

down:
	sudo docker-compose -f ./srcs/docker-compose.yml down -v

re:
	sudo make fclean
	sudo make up

fclean:
	sudo docker-compose -f ./srcs/docker-compose.yml down -v
	sudo docker volume prune
	sudo rm -fr ~/volume

volume:
	sudo mkdir -p ~/volume/wp
	sudo mkdir -p ~/volume/db

.PHONY: on off re fclean env
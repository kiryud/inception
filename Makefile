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
	@docker-compose -f ./srcs/docker-compose.yml ps


up: volume
	@docker-compose -f ./srcs/docker-compose.yml up

down:
	@docker-compose -f ./srcs/docker-compose.yml down -v

re:
	make fclean
	make up

fclean:
	@docker-compose -f ./srcs/docker-compose.yml down -v
	rm -fr ~/volume

volume:
	mkdir -p ~/volume/wp
	mkdir -p ~/volume/db

.PHONY: on off re fclean env
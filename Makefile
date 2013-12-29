# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aeddi <aeddi@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2013/12/14 16:00:35 by aeddi             #+#    #+#              #
#    Updated: 2013/12/20 11:06:57 by aeddi            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME			=	fdf
CC				=	gcc
CFLAGS			=	-Wall -Wextra -Werror -O3 -I $(LIBFT_DIR) -I $(INCS_DIR)
LFLAGS			=	-L $(LIBFT_DIR) -lft
LIBFT_DIR		=	libft
INCS_DIR		=	includes
OBJS_DIR		=	objects
SRCS_DIR		=	sources
SRCS			=	main.c

OBJS			=	$(patsubst %.c, $(OBJS_DIR)/%.o, $(SRCS))

all				:	$(NAME)

$(NAME)			:	comp_lib $(OBJS)
	$(CC) -o $(NAME) $(OBJS) $(LFLAGS)

comp_lib		:
	$(MAKE) -C $(LIBFT_DIR)

$(OBJS_DIR)/%.o	:	$(addprefix $(SRCS_DIR)/, %.c)
	@mkdir -p $(OBJS_DIR)
	$(CC) $(CFLAGS) -o $@ -c $^

fclean			:	clean
	rm -f $(NAME)

clean			:
	rm -rf $(OBJS_DIR)

re				:	fclean all

.PHONY: clean all re fclean

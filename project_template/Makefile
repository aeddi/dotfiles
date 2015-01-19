# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aeddi <aeddi@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2013/12/14 16:00:35 by aeddi             #+#    #+#              #
#    Updated: 2014/05/19 23:09:03 by aeddi            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME			=	
CC				=	cc
GDB				?=	0
ifeq ($(GDB), 1)
	CFLAGS		=	-Wall -Wextra -Werror -pedantic -g3 	\
					-I $(LIBFT_INCS_DIR) -I $(INCS_DIR)
else
	CFLAGS		=	-Wall -Wextra -Werror -pedantic -O3 	\
					-I $(LIBFT_INCS_DIR) -I $(INCS_DIR)
endif
LFLAGS			=	-L $(LIBFT_DIR) -lft
LIBFT_DIR		=	./libft
LIBFT_INCS_DIR	=	./libft/includes
INCS_DIR		=	./includes
OBJS_DIR		=	./objects
SRCS_DIR		=	./sources
OBJS			=	$(patsubst %.c, $(OBJS_DIR)/%.o, $(SRCS))
SRCS			=	

all				:	$(NAME)

$(NAME)			:	$(OBJS_DIR) $(OBJS)
	@$(CC) -o $(NAME) $(OBJS) $(LFLAGS)
	@echo "]   \033[1;32mDone\033[0;0m"

$(OBJS_DIR)/%.o	:	$(addprefix $(SRCS_DIR)/, %.c)
	@$(CC) $(CFLAGS) -o $@ -c $^
	@echo ".\c"

$(OBJS_DIR)		:	make_libft
	@mkdir -p $(OBJS_DIR)
	@echo "\033[1;32mCompiling $(NAME)   \033[0;0m[\c"

make_libft		:
	@$(MAKE) -C $(LIBFT_DIR)

fclean			:	clean
	@rm -f $(NAME)
	@echo "\033[1;31m$(NAME) deleted\033[0;0m"

clean			:
	@rm -rf $(OBJS_DIR)
	@echo "\033[1;31mObjects deleted\033[0;0m"

re				:	fclean all

.PHONY: clean all re fclean

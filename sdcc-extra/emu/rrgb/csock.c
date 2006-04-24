/*

$Id$
This file is part of socket(1).
Copyright (C) 1992 by Juergen Nickelsen <nickel@cs.tu-berlin.de>
Please read the file COPYRIGHT for further details.

*/

#if defined __linux__ || defined __CYGWIN__
#include <unistd.h>
#endif
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <errno.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/time.h>
#include <signal.h>
#include "csock.h"

void init_signals(void);

int socket_poll( int asocket )
{
	fd_set read_fd;
	int ret;
	struct timeval wait;

	FD_ZERO(&read_fd);
	FD_SET(asocket, &read_fd);
	
	wait.tv_sec=0;
	wait.tv_usec=0;

	/* Wait for input */
	ret = select( asocket+1, &read_fd, NULL, NULL, &wait );
	if (ret<0 && errno != EINTR) {
		return -1;
	}
	return ret;
}
		
int socket_get( int asocket )
{
	char buffer[2];
	if (socket_read( asocket, buffer, 1)!=-1) {
		return buffer[0];
	}
	return -1;
}

int socket_read( int asocket, char *buffer, int len )
{
	int got;

	got = read( asocket, buffer, len );
	if (got==-1) {
		return -1;
	}
	return got;
}

int socket_write( int sink, char *buffer, int len )
{
	int wrote;

	while (len>0) {
		wrote = write( sink, buffer, len );
		if (wrote == -1) {
			return -1;
		}
		len-=wrote;
	}
	return 0;
}

int socket_init(int port)
{
	struct sockaddr_in sock;
	int ret;

	ret = socket(AF_INET, SOCK_STREAM, 0);
	if (ret<0)
		return -1;
	/* Clear the sockaddr_in */
	memset((void *)&sock, 0, sizeof(struct sockaddr_in));

	sock.sin_family = AF_INET;
	sock.sin_addr.s_addr = htonl(INADDR_ANY);
	sock.sin_port = htons(port);

	if (bind(ret, (struct sockaddr *)&sock, sizeof(struct sockaddr_in))<0) {
		return -2;	/* Bind error */
	}
	if (listen(ret, 1)<0) {
		return -3;	/* Listen error */
	}
	return ret;
}

int socket_main(int hsocket)
{
	struct sockaddr_in sock;
	int asocket;		/* Active socket */
	int sock_len;
	char buffer[200];
	int got;
	
	sock_len=sizeof(struct sockaddr_in);
	asocket = accept( hsocket, (struct sockaddr *)&sock, &sock_len );
	if (asocket==-1) {
		return -1;
	}
	socket_write( asocket, "Hi there\n", 9 );
	while (1) {
		while (socket_poll(asocket)==0) {}
		if ((got=socket_read(asocket, buffer, 200))>0) {
			socket_write( asocket, buffer, got );
		}
		else
			break;
	}
	close(asocket);
	return 0;
}

/* Signal handler, print message and exit */
void exitsig(sig)
int sig ;
{
    if (sig != SIGUSR1) {
	fprintf(stderr, "\nSignal %i occured, exiting\n", sig) ;
    }
    exit(-sig) ;
}

/* set up signal handling. All except TSTP, CONT, CLD, and QUIT
 * are caught with exitsig(). */
void init_signals()
{
    int i ;
#ifdef BSD_SIG_SETMASK		/* only with BSD signals */
    static struct sigvec svec = { exitsig, ~0, 0 } ;
#endif

    for (i = 0; i < NSIG; i++) {
	switch (i) {
#ifdef SIGTSTP
	  case SIGTSTP:
	  case SIGTTOU:
	  case SIGTTIN:
	  case SIGSTOP:
	  case SIGCONT:
	    continue ;
#endif
#if !defined (SIGCHLD) && defined (SIGCLD)
#define SIGCHLD SIGCLD
#endif
#ifdef SIGCHLD
	  case SIGCHLD:
	    continue ;
#endif
#ifdef SIGWINCH
	  case SIGWINCH:	/* it is ridiculous to exit on WINCH */
	    continue ;
#endif
	  case SIGQUIT:		/* if the user wants a core dump, */
	    continue ;		/* they can have it. */
	  default:	    
#ifdef BSD_SIG_SETMASK
	    sigvec(i, &svec, NULL) ;
#else
	    signal(i, exitsig) ;
#endif
	}
    }
}

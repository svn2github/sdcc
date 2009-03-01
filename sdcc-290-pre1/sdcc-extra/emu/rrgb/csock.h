#ifndef __CSOCK_H
#define __CSOCK_H

int socket_poll( int asocket );
int socket_get( int asocket );
int socket_read( int asocket, char *buffer, int len );
int socket_write( int sink, char *buffer, int len );
int socket_init(int port);
int socket_main(int hsocket);

#endif /* __CSOCK_H */

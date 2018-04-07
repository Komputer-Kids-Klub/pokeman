## -------------------------------------- ##
## Client Connections
## connects clients
## -------------------------------------- ##

from Constants import *
import sys
import socket
import select
from random import randint

# sockets
l_sockets = []

# idle users
l_clients = {}

# broadcast chat messages to all connected clients
def broadcast (server_socket, sock, message):
    #print("broadcasted",message.encode("utf-8"))
    for socket in l_sockets:
        # send the message only to peer
        if socket != server_socket and socket != sock :
            try :
                socket.send((message+"\n").encode("utf-8"))
                #socket.send(b"b100x")
            except :
                # broken socket connection
                socket.close()
                # broken socket, remove it
                if socket in l_sockets:
                    l_sockets.remove(socket)

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server_socket.bind((HOST, PORT))
server_socket.listen(10)

print("Chat server started on port " + str(PORT))

def recieve_connection():
    ready_to_read, ready_to_write, in_error = select.select([server_socket], [], [], 0)

    if len(ready_to_read)>0:
        sockfd, addr = server_socket.accept()
        l_sockets.append(sockfd)
        print(str(addr) + " connected")

        l_clients[addr] = Client(addr)

        # sockfd.send(b"gey")
        # broadcast(server_socket, sockfd, "[%s:%s] entered our chatting room\n" % addr)
        #print("[%s:%s] entered our chatting room\n" % addr)

    # get the list sockets which are ready to be read through select
    # 4th arg, time_out  = 0 : poll and never block
    ready_to_read, ready_to_write, in_error = select.select(l_sockets, [], [], 0)

    for sock in ready_to_read:
        # a message from a client, not a new connection
        # process data recieved from client,
        try:
            # receiving data from the socket.
            data = sock.recv(RECV_BUFFER)
            if data:
                # there is something in the socket
                #sockfd.send(data)
                # broadcast(server_socket, sock, "\r" + '[' + str(sock.getpeername()) + '] ' + data)
                #print(str(sock.getpeername()) + ': ' + data)
                l_clients[sock.getpeername()].recieved_data(data)
            else:
                # at this stage, no data means probably the connection has been broken
                # broadcast(server_socket, sock, "Client (%s, %s) is offline\n" % addr)
                print(str(sock.getpeername()) + " is offline")

                del l_clients[sock.getpeername()]

                # remove the socket that's broken
                if sock in l_sockets:
                    l_sockets.remove(sock)

        # exception
        except:
            # broadcast(server_socket, sock, "Client (%s, %s) is offline\n" % addr)
            print(str(sock.getpeername()) + " is offline")

            del l_clients[sock.getpeername()]

            continue

class Client(object):
    def __init__(self,addr=None):
        self.addr = addr

    def recieved_data(self,str_data):
        print(str_data)

    def run(self):
        Log.info("here")
        return True
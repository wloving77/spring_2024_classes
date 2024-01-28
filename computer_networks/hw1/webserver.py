from socket import * 
import sys # In order to terminate the program

# Create a TCP server socket
#(AF_INET is used for IPv4 protocols)
#(SOCK_STREAM is used for TCP)



serverSocket = socket(AF_INET, SOCK_STREAM)
serverSocket.setsockopt(SOL_SOCKET, SO_REUSEADDR, 1)
serverPort = 8080
serverSocket.bind(('', serverPort))

serverSocket.listen(1)

#### END A

allowed_methods = ['GET', 'HEAD']
removed_pages = ['dummy.html']

while True:

    try:
        print('The server is ready to receive')
        connectionSocket, addr = serverSocket.accept()
        connectionSocket.settimeout(10)
        print('A client connected.')

        request_text = connectionSocket.recv(1024).decode()
        request_split = request_text.split(' ')

        method = request_split[0]
        version = request_split[2].split("\r")[0]
        file_path = request_split[1]

        print(f"Method: {method}")
        print(f"Version: {version}")
        print(f"Path: {file_path}")

        #initialize file content to empty bytes
        file_content=b''

        # Handle test case 3

        if(method not in allowed_methods):
            response = (
                "HTTP/1.1 405 Method Not Allowed\r\n"
                "Content-Length: 0\r\n"
                "\r\n"
            )
        elif(version!="HTTP/1.1"):
            response = (
                "HTTP/1.1 505 HTTP Version Not Supported\r\n"
                "Content-Length: 0\r\n"
                "\r\n"
            )            
        elif(file_path.strip("/") in removed_pages):
            response = (
                "HTTP/1.1 301 Moved Permanently\r\n"
                f"Location: http://127.0.0.1:8080/hello.html\r\n"
                "Content-Length: 0\r\n"
                "\r\n"
            )
        else:    
            try:
                with open(file_path.strip("/"), "rb") as file:
                    file_content = file.read()
                    response = (
                        "HTTP/1.1 200 OK\r\n"
                        "Content-Type: text/html\r\n"
                        f"Content-Length: {len(file_content)}\r\n"
                        "\r\n"
                    )
            except IOError:
                    with open("404.html", "rb") as file:
                        file_content = file.read()
                        response = (
                            "HTTP/1.1 404 Not Found\r\n"
                            "Content-Type: text/html\r\n"
                            f"Content-Length: {len(file_content)}\r\n"
                            "\r\n"
                        )

        full_response = response.encode() + file_content
        connectionSocket.sendall(full_response)

    except timeout:
        print("Connection Timed Out")

    except Exception as e:
        print(e)

    finally:
        connectionSocket.close()
        print("Connection Closed")
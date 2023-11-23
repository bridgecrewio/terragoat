import urllib.request
import time

aws_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"

with urllib.request.urlopen('https://github.com/mkrle/malware-samples/raw/main/Binaries/Linux.Wirenet/9A0E765EECC5433AF3DC726206ECC56E') as response:
   with open('container_malware.elf','wb') as f:
    f.write(response.read())

while True:
    time.sleep(86400)

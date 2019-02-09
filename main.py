import pyximport
pyximport.install()
from calc import *

from random import randint
e, n, d = genkeys(randint(0, 99999), randint(0, 99999))
print("e, n, d: ", e, n, d)
print("sizes: ", e.bit_length(), n.bit_length(), d.bit_length())
message = str(input())

mes = list()
for ch in message:
    mes.append(modexp(ord(ch), e, n))
print(mes)

word = str()
for num in mes:
    word += (chr(modexp(num, d, n)))

print(word)

import time
start_time = time.time()
from random import random, seed, randint, randrange
import pyximport; pyximport.install()
from ctest import *
from helpers import *
import sys
sys.setrecursionlimit(1000)
from math import gcd


seed()

p = randint(0, 99999)
p = prime_n(p)
q = randint(0, 99999)
q = prime_n(q)

n = p * q

fi_n = (p-1) * (q-1)
print("fi_n", fi_n)
e = 65537
# while True:
#     private = randrange(fi_n)
#     print("private", private)
#     if gcd(private, fi_n) == 1:
#         break

print("gcd:", gcd(e, fi_n))
d = bezout(fi_n, e)
print("d=", d)
enc = modexp(17, e, n)
print("enc", enc)
print("dec", modexp(enc, d, n))


print("--- %s seconds ---" % (time.time() - start_time))


if __name__ == "__main__":
  gen_keys()

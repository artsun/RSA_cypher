
from libc.math cimport sqrt
from libc.stdlib cimport rand, srand
from cpython cimport bool

def isprime(int n):
    if n & 1 == 0:
        return False
    cdef int x
    for x in range(3, int(sqrt(n))+1, 2):
        if n % x == 0:
            return False
    return True

def _rnd(int r):
    srand(r)
    return (8388608 + rand() % 16777215)

def modexp(long long int x, long long int y, long long int N):
    if (y == 0):
      return 1
    z = modexp(x, y // 2, N)
    if (y % 2 == 0):
      return (z*z) % N
    else:
      return (x*z*z) % N

def prime_n(int r):
    cdef int n = _rnd(r)
    cdef bool flag = isprime(n)
    while (flag != True):
        n -= 1
        flag = isprime(n)
    return n

def bezout(fi_n, private):
    x, lastx = 0, 1
    a, b = fi_n, private
    while b:
        a, q, b = b, a // b, a % b
        x, lastx = lastx - q * x, x
    result = (1 - lastx * fi_n) // private
    if result < 0:
        result += fi_n
    return result

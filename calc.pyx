from libc.math cimport sqrt
from libc.stdlib cimport rand, srand
from cpython cimport bool

#define unsigned long long int as uint8: 8bit long uint
ctypedef unsigned long long int uint8

cpdef bool _isprime(uint8 n):
    '''
    check if number is prime or not
    '''
    if n & 1 == 0:
        return False
    cdef uint8 x
    for x in range(3, int(sqrt(n))+1, 2):
        if n % x == 0:
            return False
    return True


cpdef uint8 _rnd(uint8 r):
    '''
    generates 32 bit-long random int
    '''
    srand(r)
    return (2147483648 + rand() % 4294967295)


cpdef uint8 _getprime(uint8 r):
    '''
    takes 32 bit-long random int and decend until number is prime
    '''
    cdef uint8 n = _rnd(r)
    cdef bool flag = _isprime(n)
    while (flag != True):
        n -= 1
        if n.bit_length()<32:   #<-----check if lower then 32 bit then gen another num
            n = _rnd(r)
        flag = _isprime(n)
    return n


cpdef uint8 _bezout(uint8 fi_n, uint8 private):
    x, lastx = 0, 1
    a, b = fi_n, private
    while b:
        a, q, b = b, a // b, a % b
        x, lastx = lastx - q * x, x
    result = (1 - lastx * fi_n) // private
    if result < 0:
        result += fi_n
    return result

def genkeys(int r1, int r2):
    cdef uint8 p = _getprime(r1)
    cdef uint8 q = _getprime(r2)
    cdef uint8 n = p * q
    cdef uint8 fi_n = (p-1) * (q-1)
    cdef uint8 e = 65537
    cdef uint8 d = _bezout(fi_n, e)
    return e, n, d


cpdef uint8 modexp(uint8 x,uint8 y, uint8 N):
    if (y == 0):
      return 1
    z = modexp(x, y // 2, N)
    if (y % 2 == 0):
      return (z*z) % N
    else:
      return (x*z*z) % N


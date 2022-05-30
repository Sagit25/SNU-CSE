from math import *

n = int(input())
i = 2
while True:
    while n % i == 0:
        print(i)
        n /= i
    if n == 1:
        break
    i += 1
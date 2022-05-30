def SuperSum(k, n):
    if k == 0:
        return n
    sum = 0
    for i in range(1, n+1):
        sum += SuperSum(k-1, i)
    return sum

k, n = map(int, input().split())
print(SuperSum(k, n))
n, m = map(int, input().split())
r = int(input())

if r % 4 == 0:
    for i in range(1, n+1):
        for j in range(1, m+1):
            print((i*j)%10, end = " ")
        print("")
elif r % 4 == 1:
    for i in range(1, m+1):
        for j in range(n, 0, -1):
            print((i*j)%10, end = " ")
        print("")
elif r % 4 == 2:
    for i in range(n, 0, -1):
        for j in range(m, 0, -1):
            print((i*j)%10, end = " ")
        print("")            
else:
    for i in range(m, 0, -1):
        for j in range(1, n+1):
            print((i*j)%10, end = " ")
        print("")
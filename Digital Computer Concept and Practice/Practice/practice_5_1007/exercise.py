n = int(input())

for i in range(1, 2*n):
    if i <= n:
        for j in range(n-i):
            print(" ", end = "")
        for j in range(1, i):
            print(j, end = "")
        for j in range(i, 0, -1):
            print(j, end = "")
    else:
        for j in range(i-n):
            print(" ", end = "")
        for j in range(1, 2*n-i):
            print(j, end = "")
        for j in range(2*n-i, 0, -1):
            print(j, end = "")
    print("")
    
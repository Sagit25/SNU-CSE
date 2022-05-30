n = int(input())
l = -1
a = list([0]*n for i in range(n))

while True:
    m = input()
    if m[0] == 'E':
        break
    l += 1
    x1, y1, x2, y2 = map(int, m.split())
    for i in range(x1, x2+1):
        for j in range(y1, y2+1):
            a[i][j] = 1

for i in range(n):
    for j in range(n):
        if a[i][j] == 0:
            print('*', end = " ")
        else:
            print(chr(ord('a')+l), end = " ")
    print("")

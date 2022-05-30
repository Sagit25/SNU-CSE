import sys

flag = 0
a, b = map(str, input().split())
x = y = 0
for i in range(9):
    c = list(input())
    if c[0] == 'R':
        if i < 4:
            print("COLDGAME")
        else:
            if x > y:
                print(a)
            elif y > x:
                print(b)
            else:
                print("TIE")
        flag = 1
        break
    x += int(c[0])
    y += int(c[2])
    if x-y >= 15:
        print(a)
        flag = 1
        break
    elif y-x >= 15:
        print(b)
        flag = 1
        break

if flag == 0:
    if x > y:
        print(a)
    elif y > x:
        print(b)
    else:
        print("TIE")
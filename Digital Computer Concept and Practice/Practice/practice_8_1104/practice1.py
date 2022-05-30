import sys
a = list(input().split())

try:
    s = list(input().split())
    for i in range(1, len(s), 2):
        flag = 0
        for j in a:
            if s[i] == j:
                flag = 1
                break
        if flag == 0:
            print("Not allowed operation!")
            sys.exit()
    str = ""
    for i in s:
        str += i
    print(round(eval(str)))
except ZeroDivisionError:
    print("Cannot be divided by zero!")
    
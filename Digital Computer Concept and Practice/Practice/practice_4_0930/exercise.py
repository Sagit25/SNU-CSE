import sys

n = int(input())
if n > 5 or n < 1:
    print('No valid number')
    sys.exit()

for i in range(n):
    a, b = map(str, input().split())
    if a == '����':
        if b == '��':
            print('��')
        elif b == '���':
            print('����')
        else:
            print('����')
    elif a == '����':
        if b == '��':
            print('����')
        elif b == '���':
            print('����')
        else:
            print('��')
    else:
        if b == '��':
            print('����')
        elif b == '���':
            print('��')
        else:
            print('����')
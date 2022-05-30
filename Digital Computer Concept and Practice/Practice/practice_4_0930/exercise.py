import sys

n = int(input())
if n > 5 or n < 1:
    print('No valid number')
    sys.exit()

for i in range(n):
    a, b = map(str, input().split())
    if a == '°¡À§':
        if b == '½Â':
            print('º¸')
        elif b == 'ºñ±è':
            print('°¡À§')
        else:
            print('¹ÙÀ§')
    elif a == '¹ÙÀ§':
        if b == '½Â':
            print('°¡À§')
        elif b == 'ºñ±è':
            print('¹ÙÀ§')
        else:
            print('º¸')
    else:
        if b == '½Â':
            print('¹ÙÀ§')
        elif b == 'ºñ±è':
            print('º¸')
        else:
            print('°¡À§')
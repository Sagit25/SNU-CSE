n, m = map(int, input().split())

def ChangeCh(x):
    if x < 10:
        return str(x)
    else:
        return str(chr(ord('A')+x-10))

def BaseM(x, y):
    if x < y:
        return ChangeCh(x)
    return BaseM(x // y, y) + ChangeCh(x % y)

print(BaseM(n, m))
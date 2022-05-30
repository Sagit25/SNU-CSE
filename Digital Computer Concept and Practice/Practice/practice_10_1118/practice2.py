n = int(input())
a = [['   ' for i in range(2*(n//3))] for j in range(n)]

def star(x, y, l):
    if l == 3:
        a[x][y] = '***' 
        a[x][y+1] = '** ' 
        a[x+1][y] = ' * ' 
        a[x+1][y+1] = '*  '
        a[x+2][y] = '  *'
        return
    else: 
        star(x, y, l//2)
        star(x, y+l//3, l//2)
        star(x+l//2, y+l//6, l//2)
        return
        
star(0, 0, n)

for i in a:
    print(''.join(i))      
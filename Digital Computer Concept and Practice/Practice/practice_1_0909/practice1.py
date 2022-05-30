ans = 0
n = int(input())
for i in range(1, n+1):
    if(i % 10 == 0):
        continue
    elif(i % 2 == 0 or i % 5 == 0):
        ans += i
print(ans)
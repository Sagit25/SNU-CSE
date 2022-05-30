n = int(input())
t = [0, 0, 1]
for i in range(3, n+1):
    t.append(int(t[i-1])+int(t[i-2])+int(t[i-3]))
print(t[n])
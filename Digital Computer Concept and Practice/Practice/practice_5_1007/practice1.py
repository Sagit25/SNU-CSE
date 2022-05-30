import sys

ans = int(input())
t = int(input())
for i in range(t):
    x = int(input())
    ans += x
    if ans < 0:
        print("Broke")
        print(ans-x)
        sys.exit()
print("Save")
print(ans)

    


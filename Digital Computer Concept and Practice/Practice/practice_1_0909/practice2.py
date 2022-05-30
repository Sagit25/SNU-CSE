a = int(input())
b = int(input())
c = int(input())
d = int(input())
sum = a + b + c + d
if(a <= 30 or b <= 30 or c <= 30 or d <= 30): 
    print("F")
elif(sum >= 360):
    print("A")
elif(sum >= 320):
    print("B")
elif(sum >= 240):
    print("C")
else:
    print("D")
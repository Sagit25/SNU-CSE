class Team:
    def __init__(self, name, string, num):
        self.name = name
        self.string = string
        self.num = num  

n = 2
t = []
for i in range(n):
    b = input()
    t.append(Team(chr(ord('A')+i), b, len(b)))

x = y = 0
while x < t[0].num and y < t[1].num:
    a = t[0].string[x]
    b = t[1].string[y] 
    if a == b:
        x += 1
        y += 1
    elif (a == 'R' and b == 'S') or (a == 'S' and b == 'P') or(a == 'P' and b == 'R'):
        y += 1
    else: 
        x += 1
                
if x >= t[0].num and y >= t[1].num:
    print("TIE")
elif x >= t[0].num:
    print(t[1].name)
elif y >= t[1].num:
    print(t[0].name)
        
                
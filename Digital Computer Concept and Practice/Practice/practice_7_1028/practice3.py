cmd = input()
origin = list(input())
code = list(input())
sen = list(input())

def encrypt():
    codebook = dict(zip(origin, code))
    for i in sen:
        value = codebook.get(i)
        if value != None:
            print(codebook[i], end="")
        else:
            print(i, end="")

def decrypt():
    codebook = dict(zip(code, origin))
    for i in sen:
        value = codebook.get(i)
        if value != None:
            print(codebook[i], end="")
        else:
            print(i, end="")

if cmd == "encrypt":
    encrypt()
else:
    decrypt()

import turtle as t

def big_ear(x):
    t.left(90)
    t.fillcolor('#8f5c4b')
    t.begin_fill()
    t.circle(-50*x)
    t.end_fill()
    t.right(90)

def small_ear(x):
    t.left(90)
    t.fillcolor('#68422f')
    t.begin_fill()
    t.circle(-20*x)
    t.end_fill()
    t.right(90)

def eyes(x):
    t.left(90)
    t.fillcolor('black')
    t.begin_fill()
    t.circle(-10*x)
    t.end_fill()
    t.right(90)

t.shape("turtle")
t.width(5)
t.speed(10)

t.left(90)
t.penup()
t.fd(100)
t.pendown()
t.right(90)

t.circle(-150, 20)
big_ear(1)
t.circle(-150, 10)
small_ear(1)
t.circle(-150, 310)
big_ear(-1)
t.circle(-150, -10)
small_ear(-1)
t.circle(-150, 30)

t.fillcolor('#8f5c4b')
t.begin_fill()
t.circle(-150)
t.end_fill()

t.penup()
t.right(90)
t.fd(110)
t.right(90)
t.fd(30)
t.pendown()
eyes(-1)

t.penup()
t.bk(60)
t.pendown()
eyes(1)

t.penup()
t.fd(30)
t.left(90)
t.fd(30)
t.pendown()

t.fillcolor('#ffd1b8')
t.begin_fill()
t.left(90)
t.circle(-25, 90)
t.fd(30)
t.circle(-25, 180)
t.fd(30)
t.circle(-25, 90)
t.end_fill()

t.penup()
t.right(90)
t.fd(30)
t.pendown()

t.left(150)
t.fd(20)
t.left(120)
t.fd(20)
t.left(120)
t.fd(20)
t.right(30)
t.fd(20)
t.right(45)
t.fd(15)
t.bk(15)
t.left(120)
t.fd(15)

t.hideturtle()
t.exitonclick()
import turtle as t

t.shape("turtle")
t.width(4)
t.speed(1)

t.left(90)
t.penup()
t.fd(100)
t.pendown()
t.right(90)

t.fillcolor('yellow')
t.begin_fill()
t.circle(-100)
t.end_fill()

t.width(2)
t.penup()
t.right(90)
t.fd(60)
t.left(90)
t.fd(40)
t.pendown()

t.fillcolor('black')
t.begin_fill()
t.circle(-10)
t.end_fill()

t.penup()
t.bk(80)
t.pendown()

t.fillcolor('black')
t.begin_fill()
t.circle(-10)
t.end_fill()

t.penup()
t.fd(40)
t.right(90)
t.fd(100)
t.right(90)
t.pendown()

t.circle(-80, 30)
t.circle(-80, -60)

t.hideturtle()
t.exitonclick()
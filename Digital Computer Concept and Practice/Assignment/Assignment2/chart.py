import turtle as t

# parameters
turtle_speed = 0
 
# constants
AXIS_LENGTH = 500
AXIS_MARGIN = 20
AXIS_WIDTH = 3
PIXEL_PER_VAL = 2.5
RADIUS = 1

LABELS = ["A", "B", "C", "D", "E", "F"]
COLORS = ["red", "blue", "green", "pink", "grey", "yellow"]


def axis():
    t.setworldcoordinates(-200,-200,700,700)
    t.shape("turtle")
    t.speed(turtle_speed)
    t.width(AXIS_WIDTH)

    ####### Enter Your Code ########

    t.fd(AXIS_LENGTH + AXIS_MARGIN)
    t.left(140)
    t.fd(AXIS_MARGIN)
    t.bk(AXIS_MARGIN)
    t.right(280)
    t.fd(AXIS_MARGIN)
    t.bk(AXIS_MARGIN)
    t.left(140)
    t.goto(0, 0)
    t.left(90)
    t.fd(AXIS_LENGTH + AXIS_MARGIN)
    t.left(140)
    t.fd(AXIS_MARGIN)
    t.bk(AXIS_MARGIN)
    t.right(280)
    t.fd(AXIS_MARGIN)
    t.bk(AXIS_MARGIN)
    t.left(140)
    t.goto(0, 0)
    t.fd(AXIS_LENGTH + AXIS_MARGIN)
    t.left(140)
    t.fd(AXIS_MARGIN)
    t.bk(AXIS_MARGIN)
    t.right(280)
    t.fd(AXIS_MARGIN)
    t.bk(AXIS_MARGIN)
    t.left(140)
    t.goto(0, 0)
    
    ####### End of the Code ########


def bar_chart(data):
    
    ####### Enter Your Code ########

    label_num = [0] * 6
    for i in data:
        if i == 'A':
            label_num[0] += 1
        elif i == 'B':
            label_num[1] += 1
        elif i == 'C':
            label_num[2] += 1
        elif i == 'D':
            label_num[3] += 1
        elif i == 'E':
            label_num[4] += 1
        else:
            label_num[5] += 1

    label_height = 80
    for i in range(6):
        t.color(COLORS[i])
        t.begin_fill()
        t.fd(label_height)
        t.right(90)
        t.fd(label_num[i]*PIXEL_PER_VAL)
        t.right(90)
        t.fd(label_height)
        t.right(90)
        t.fd(label_num[i]*PIXEL_PER_VAL)
        t.right(90)
        t.end_fill()
        t.color('black')
        t.fd(label_height)
        t.right(90)
        t.fd(label_num[i]*PIXEL_PER_VAL)
        t.right(90)
        t.fd(label_height)
        t.right(90)
        t.fd(label_num[i]*PIXEL_PER_VAL)
        t.right(90)
        t.fd(label_height)

    print(1)
    ####### End of the Code ########


def scatterplot(data):

    ####### Enter Your Code ########

    t.penup()
    for i in data:
        l, x, y = map(str, i.split())
        t.goto(int(x)+1, int(y))
        t.pendown()
        t.color(COLORS[ord(l)-ord('A')])
        t.begin_fill()
        t.circle(RADIUS)
        t.end_fill()
        t.penup()
    
    print(1)
    ####### End of the Code ########


def free_turtle():
    t.exitonclick()

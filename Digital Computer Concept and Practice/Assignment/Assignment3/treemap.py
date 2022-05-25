import turtle as t
import sys
from data import DATA_CSE, DATA_YOUTUBE, DATA_DRINK

def tree_map(box_range, data):
    """
    box_range에 해당하는 영역에 문제에서 제시한 알고리즘에 따라 treemap을 그린다.

    input:
     * box_range: category에 해당하는 영역 좌표-(x1,x2,y1,y2 )
     * data: category 내 data-(카테고리명, data1, data2,...)
    """
    # === ENTER YOUR CODE ===

    x1, x2, y1, y2 = box_range
    t.penup()
    t.goto(x1, (y1+y2)/2)
    t.pendown()
    t.pencolor('black')
    t.write(data[0], align = 'right')

    sort_data = sorted(data[1:], key=lambda x:x[1], reverse=True)

    total = 0
    for i in sort_data:
        total += i[1]

    for i in sort_data:
        if x2-x1 > y2-y1:
            newx1 = x1+(x2-x1)*i[1]/total
            t.penup()
            t.goto(x1+5, y1+5)
            t.pendown()
            t.color(i[2])
            t.begin_fill()
            t.goto(newx1-5, y1+5)
            t.goto(newx1-5, y2-5)
            t.goto(x1+5, y2-5)
            t.goto(x1+5, y1+5)
            t.end_fill()
            t.penup()
            t.goto((x1+newx1)/2, (y1+y2)/2)
            t.pendown()
            t.pencolor('white')
            t.write(i[0], align = 'center')
            x1 = newx1
            total -= i[1]
        else:
            newy2 = y2-(y2-y1)*i[1]/total
            t.penup()
            t.goto(x1+5, newy2+5)
            t.pendown()
            t.color(i[2])
            t.begin_fill()
            t.goto(x2-5, newy2+5)
            t.goto(x2-5, y2-5)
            t.goto(x1+5, y2-5)
            t.goto(x1+5, newy2+5)
            t.end_fill()
            t.penup()
            t.goto((x1+x2)/2, (newy2+y2)/2)
            t.pendown()
            t.pencolor('white')
            t.write(i[0], align = 'center')
            y2 = newy2
            total -= i[1]
    
    # === END OF YOUR CODE ===



def divide_area(box_range, data):
    """
        전체 영역을 카테고리별 영역으로 구분한 정보를 담고있는 딕셔너리를 return한다.
        input:
         * box_range: 전체 영역에 해당하는 좌표-(x1,x2,y1,y2)
         * data: 카테고리별 데이터 정보 - [category1_data, category2_data...]
        output:
         * category_coord - 딕셔너리
            - key: category 명
            - value: category에 해당하는 영역 좌표 정보 (x1', x2', y1', y2')
    """
    # === ENTER YOUR CODE ===
    
    category_coord = None
    category_coord = dict()
    name = []
    num = []
    total = 0

    for i in data:
        name.append(i[0])
        number = 0
        for j in i[1:]:
            number += j[1]
        num.append(number)
        total += number
    
    cadata = dict(zip(name, num))
    ncadata = sorted(cadata.items(), key=lambda x:x[1])

    x1, x2, y1, y2 = box_range

    for i in ncadata:
        key, value = i[0], i[1]
        category_coord[key] = (x1, x2, y1, y1+(y2-y1)*value/total)
        y1 += (y2-y1)*value/total
        total -= value
    
    # === END OF YOUR CODE ===
    
    return category_coord

def write_myinfo(box_range):
    """
    본인의 학번,이름(영문),학과(영문) 정보를 treemap box 상단 중앙에 기입
    input:
        * box_range : treemap box 영역 좌표
    """
    # === ENTER YOUR CODE ===

    x1, x2, y1, y2 = box_range
    t.penup()
    t.goto((x1+x2)/2, y2+30)
    t.pendown()
    t.write("2021-15738 Sukhun Yang CLS", align = 'center', font = 15)

    # === END OF YOUR CODE ===

if __name__ == "__main__":

    box_range = (-450, 450, -300, 300)
    
    arg = sys.argv[1]

    if arg == "cse":
        data = DATA_CSE
    elif arg == "youtube":
        data = DATA_YOUTUBE
    elif arg == "drink":
        data = DATA_DRINK
    else:
        print("Wrong argument!!!")
    
    write_myinfo(box_range)
    category_coord = divide_area(box_range,data)
    
    if category_coord:
        for category in data:
            category_name = category[0]
            area = category_coord[category_name]
            tree_map(area,category)

    # 화살표 숨기기
    t.hideturtle()

    ts = t.getscreen()
    ts.getcanvas().postscript(file="result.eps")
    
    # t.exitonclick() # 주석처리 하지 않고 작성하여 제출할 경우 감점
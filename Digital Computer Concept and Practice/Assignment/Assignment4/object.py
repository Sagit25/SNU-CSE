import pygame as pg
import random

from color import *

# Background Constant 
lside = rside = 5
uside = dside = 10

class GridObject():
    # Constructer
    def __init__(self, x, y, game, color):
        self.game = game
        self.active = True
        self.color = color
        self.x = x  # grid column index
        self.y = y  # grid row index
        
    # Event Handling function
    def handle_event(self, event):
        pass
    
    # Tick Function
    def tick(self):
        pass
    
    # Draw Function (for Food)
    def draw(self):
        block_size = self.game.block_size
        pg.draw.rect(self.game.display, self.color, [self.x*block_size, self.y*block_size, block_size, block_size])  

    # Interact Function
    def interact(self, other):
        pass

class Player1(GridObject):
    # Initial Speed, Color
    dx = 0
    dy = 0
    color = LITTLE_BLUE
    
    def __init__(self, x, y, game, snake, size):
        self.time = 0
        self.size = size
        self.snake = snake
        super().__init__(x, y, game, self.color)
    
    def handle_event(self, event):
        if event.type == pg.KEYDOWN:
            if event.key == pg.K_a:
                self.dx = -1
                self.dy = 0
            elif event.key == pg.K_d:
                self.dx = 1
                self.dy = 0
            elif event.key == pg.K_w:
                self.dx = 0
                self.dy = -1
            elif event.key == pg.K_s:
                self.dx = 0
                self.dy = 1     
    
    def tick(self):
        self.x += self.dx
        self.y += self.dy

    def interact(self, other):
        if isinstance(other, Food):
            if self.x == other.x and self.y == other.y:
                other.active = False
                self.size += other.score
    
    def draw(self):
        if len(self.snake) > 1:
            self.time += 1
        else:
            self.time = 0
        if len(self.snake) >= self.size:
            del self.snake[0]
        self.snake.append([self.x, self.y])
        if self.time > 50:
            self.time = 0
            self.size -= 1
            del self.snake[0]       
        
        for snk in self.snake:
            if snk == self.snake[len(self.snake)-1]:
                pg.draw.rect(self.game.display, BLUE, [snk[0]*self.game.block_size, snk[1]*self.game.block_size, self.game.block_size, self.game.block_size])
            else:
                pg.draw.rect(self.game.display, self.color, [snk[0]*self.game.block_size, snk[1]*self.game.block_size, self.game.block_size, self.game.block_size])

class Player2(GridObject):
    # Initial Speed, Color
    dx = 0
    dy = 0
    color = LITTLE_RED
    
    def __init__(self, x, y, game, snake, size):
        self.time = 0
        self.size = size
        self.snake = snake
        super().__init__(x, y, game, self.color)
    
    def handle_event(self, event):
        if event.type == pg.KEYDOWN:
            if event.key == pg.K_LEFT:
                self.dx = -1
                self.dy = 0
            elif event.key == pg.K_RIGHT:
                self.dx = 1
                self.dy = 0
            elif event.key == pg.K_UP:
                self.dx = 0
                self.dy = -1
            elif event.key == pg.K_DOWN:
                self.dx = 0
                self.dy = 1     
    
    def tick(self):
        self.x += self.dx
        self.y += self.dy

    def interact(self, other):
        if isinstance(other, Food):
            if self.x == other.x and self.y == other.y:
                other.active = False
                self.size += other.score
    
    def draw(self):
        if len(self.snake) > 1:
            self.time += 1
        else:
            self.time = 0
        if len(self.snake) >= self.size:
            del self.snake[0]
        self.snake.append([self.x, self.y])
        if self.time > 50:
            self.time = 0
            self.size -= 1
            del self.snake[0]       
        
        for snk in self.snake:
            if snk == self.snake[len(self.snake)-1]:
                pg.draw.rect(self.game.display, RED, [snk[0]*self.game.block_size, snk[1]*self.game.block_size, self.game.block_size, self.game.block_size])
            else:
                pg.draw.rect(self.game.display, self.color, [snk[0]*self.game.block_size, snk[1]*self.game.block_size, self.game.block_size, self.game.block_size])            

class Food(GridObject):
    def __init__(self, game):
        self.x = random.randint(lside+1, game.n_cols-2+lside)
        self.y = random.randint(uside+1, game.n_rows-2+uside)
        self.color, self.score = FOOD_COLOR[random.randrange(3)]
        super().__init__(self.x, self.y, game, self.color)
        
    def interact(self, other):
        if isinstance(other, Player1) or isinstance(other, Player2):
            if self.x == other.x and self.y == other.y:
                self.active = False
                for obj in self.game.active_objects():
                    self.x = random.randint(lside+1, self.game.n_cols-2+lside)
                    self.y = random.randint(uside+1, self.game.n_rows-2+uside)
                    if self.x != obj.x or self.y != obj.y:
                        break
                self.color, self.score = FOOD_COLOR[random.randrange(3)]
                self.active = True
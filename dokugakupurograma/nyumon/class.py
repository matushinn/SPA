#1
class Apple():
    def __init__(self,color,length):
        self.color = color
        self.length = length

#2
import math

class Circle():
    def __init__(self,radius):
        self.radius = radius

    def area(self):
        return self.radius**2*math.pi

a_circle = Circle(1)

print(a_circle.area())

#3
class Triangle():
    def __init__(self,base,height):
        self.base = base
        self.height = height

    def area(self):
        return self.base * self.height / 2

a_triangle = Triangle(2,3)
print(a_triangle.area())

#4
class Hexagon():
    def __init__(self,radius):
        self.radius = radius

    def area(self):
        return self.radius * 6

a_hexagon = Hexagon(3)

print(a_hexagon.area())





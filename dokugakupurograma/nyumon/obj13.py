class Rectangle():
    def __init__(self,width,height):
        self.width = width
        self.height = height

    def calculate_perimeter(self):
        return  self.width*2+self.height*2

class Square():
    def __init__(self,s1):
        self.s1 = s1

    def calculate_perimeter(self):
        return self.s1 * 4

a_rectangle = Rectangle(2,3)
a_square = Square(2)

print(a_rectangle.calculate_perimeter())
print(a_square.calculate_perimeter())




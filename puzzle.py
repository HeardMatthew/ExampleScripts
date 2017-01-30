def sim_squ_trials(n): 
	# Find the average difference between any two points within a square with side length 1. 
    from random import random
    from math   import sqrt
    total = 0
    for i in list(range(n)):
        point1 = [random(), random()]
        point2 = [random(), random()]
        magnitude_x = abs(point1[0] - point2[0])
        magnitude_y = abs(point1[1] - point2[1])
        hypotenuse  = sqrt(magnitude_x**2 + magnitude_y**2)
        total += hypotenuse
    distance = total / n
    return distance
	# What is the exact answer? (2 + sqrt(2) + 5*ln(sqrt(2) + 1))/15, from http://mindyourdecisions.com/blog/2016/07/03/distance-between-two-random-points-in-a-square-sunday-puzzle/

def sim_circumf_trials(n): 
    # Find the average difference between any two points along the circumference of a unit circle. 
    from random import random
    from math   import cos, sin, sqrt, pi
    total = 0
    for i in list(range(n)):
        theta1 = 2*pi*random()
        theta2 = 2*pi*random()
        point1 = [cos(theta1), sin(theta1)]
        point2 = [cos(theta2), sin(theta2)]
        magnitude_x = abs(point1[0] - point2[0])
        magnitude_y = abs(point1[1] - point2[1])
        hypotenuse  = sqrt(magnitude_x**2 + magnitude_y**2)
        total += hypotenuse
    distance = total / n
    return distance
	# I do not know what the exact answer is. 

def sim_circ_trials(n): 
    # Find the average difference between any two points within a unit circle. 
    from random import random
    from math   import cos, sin, sqrt, pi
    total = 0
    for i in list(range(n)):
        theta1 = 2*pi*random()
        theta2 = 2*pi*random()
        point1 = [random()*cos(theta1), random()*sin(theta1)]
        point2 = [random()*cos(theta2), random()*sin(theta2)]
        magnitude_x = abs(point1[0] - point2[0])
        magnitude_y = abs(point1[1] - point2[1])
        hypotenuse  = sqrt(magnitude_x**2 + magnitude_y**2)
        total += hypotenuse
    distance = total / n
    return distance
    # I do not know what the exact answer is.
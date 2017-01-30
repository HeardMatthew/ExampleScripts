def digit_sum(n): # Sums a list of intergers from 1 to n, including n. 
    if (n < 0) or (type(n) != int):
        print("Input must be a non-negative interger")
    else:
        total = 0
        for digit in list(range(n+1)):
            total += digit
    return total

def digit_root(n): # Calculates the digital root of a nonnegative number. 
    if (n < 0) or (type(n) != int):
        print("Input must be a non-negative interger")
    else:
        total = 0
        for digit in list(range(n)):
            total += n % 10
            n = n//10
    return total
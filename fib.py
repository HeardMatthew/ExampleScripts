# Generate a list of the fibonnaci sequence using a recursive formula
def fibonnaci(num):
    fib = [ ]
    count = 0
    while count < num:
        if count == 0:
            fib = fib + [1]
        elif count == 1:
            fib = fib + [1]
        else:
            fib = fib + [(fib[count - 1] + fib[count - 2])]
        count += 1
    return fib
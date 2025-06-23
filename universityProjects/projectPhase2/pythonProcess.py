# ---------------------- STRING INPUT ------------------------------
datos = [
    19.3, 20.7, 21.5, 22.9, 23.1,
    24.6, 25.8, 26.4, 27.0, 28.2,
    29.9, 30.0, 19.8, 20.5, 21.7,
    22.3, 23.6, 24.1, 25.9, 26.7,
    27.4, 28.8, 29.2, 19.5, 20.1,
    21.9, 22.6, 23.4, 24.8, 25.2, 31.7
]

def stringify_data(data, amount):
    data.sort()
    input_string = ""
    for n in range(amount):
        input_string += str(data[n])
        if(n < (amount-1)):
            input_string += "\n"
    return input_string

input_string = stringify_data(datos, len(datos))
print(input_string)
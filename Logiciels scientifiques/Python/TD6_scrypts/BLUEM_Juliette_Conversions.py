from math import pi

# Angles :
def from_Degres_to_Radians(nb):
    return round(nb*pi/180,3)

def from_Radians_to_Degres(nb):
    return round(nb*180/pi)

# Monnaies :
def from_Euros_to_Dollars(nb):
    return round(nb*1.215,2)

def from_Euros_to_Pounds(nb):
    return round(nb*0.888,2)

def from_Euros_to_Yens(nb):
    return round(nb*7.868,2)

def from_Dollars_to_Euros(nb):
    return round(nb/1.215,2)

def from_Pounds_to_Euros(nb):
    return round(nb/0.888,2)

def from_Yen_to_Euros(nb):
    return round(nb/7.868,2)

# Temperatures :
def from_Celsius_to_Kelvin(nb):
    return round(nb + 273.15,2)

def from_Kelvin_to_Celsius(nb):
    return round(nb - 273.15,2)

def from_Celsius_to_Fahrenheit(nb):
    return round(nb*9/5 + 32)

def from_Fahrenheit_to_Celsius(nb):
    return round((nb-32)*5/9)

if __name__ == "__main__":
    print(from_Degres_to_Radians(90))
    print(from_Radians_to_Degres(pi))
    print(from_Euros_to_Dollars(50))
    print(from_Euros_to_Pounds(50))
    print(from_Euros_to_Yens(50))
    print(from_Dollars_to_Euros(61))
    print(from_Pounds_to_Euros(45))
    print(from_Yen_to_Euros(393))
    print(from_Celsius_to_Kelvin(20))
    print(from_Kelvin_to_Celsius(293))
    print(from_Celsius_to_Fahrenheit(180))
    print(from_Fahrenheit_to_Celsius(356))
import BLUEM_Juliette_Conversions as conv
from math import pi

a = 85
b = conv.from_Celsius_to_Kelvin(a)
c = pi

print(a, "°C =", b, "K")
print(round(c,2), "rad =", conv.from_Radians_to_Degres(c), "°")
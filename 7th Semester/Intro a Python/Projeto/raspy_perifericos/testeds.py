from DS18B20 import DS18B20

sensor = DS18B20("28-00000a3b3b3b")
print(sensor.read_temp()[0])

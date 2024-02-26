import os
import glob
import time

os.system("modprobe w1-gpio")
os.system("modprobe w1-therm")


class DS18B20:
    def __init__(self, codigo_do_sensor):
        self.codigo_do_sensor = codigo_do_sensor
        self.base_dir = "/sys/bus/w1/devices/"
        self.device_folder = glob.glob(self.base_dir + codigo_do_sensor)[0]
        self.device_file = self.device_folder + "/w1_slave"

    def read_temp_raw(self):
        f = open(self.device_file, "r")
        lines = f.readlines()
        f.close()
        return lines

    def read_temp(self):
        lines = self.read_temp_raw()
        while lines[0].strip()[-3:] != "YES":
            time.sleep(0.2)
            lines = self.read_temp_raw()
        equals_pos = lines[1].find("t=")
        if equals_pos != -1:
            temp_string = lines[1][equals_pos + 2 :]
            temp_c = float(temp_string) / 1000.0
            temp_f = temp_c * 9.0 / 5.0 + 32.0
            return temp_c, temp_f
        return self.read_temp()[0]

# Vi medido 0.297V
# Vo para 100hz = 1.44V

# Vi medido na frequencia de corte: 0.297V
# Vo medido na frequencia de corte: 0.975V
# Frequencia de corte = 210k Hz

freq_c = 11800

print("")

multiplos_freq1 = [0.002, 0.01, 0.05, 0.2, 0.5, 0.8, 1, 2, 4, 10, 20, 40]


# exemplo 2


# Vi medido 0.119V
# Vo para 5 Hz = 14.03V

multiplos_freq2 = [0.05, 0.1, 0.2, 0.5, 0.8, 1, 2, 5, 20, 50, 200, 500, 1000]

for val in multiplos_freq2:
    print(val, val*freq_c)

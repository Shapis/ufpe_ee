b = taps
a = 1  # for FIR, but non-1 for IIR
zi = lfilter_zi(b, a)  # calc initial conditions
while True:
    samples = sdr.read_samples(
        num_samples
    )  # Replace with your SDR's receive samples function
    samples_filtered, zi = lfilter(b, a, samples, zi=zi)  # apply filter

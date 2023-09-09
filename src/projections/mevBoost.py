import numpy as np

# Constants
hours_in_day = 24
days_in_month = 30
hours_in_month = days_in_month * hours_in_day

# Adjusted simulation parameters
# 7,200 Epochs per day, ran 1,000 times
num_simulations_large = 7200000
#
# 276 = 2.134182044 ETH
# 0.03888888888
hourly_probability_adjusted = 0.03

# Efficiently simulate using numpy's capabilities
occurrences_large = np.random.binomial(
    hours_in_month, hourly_probability_adjusted, num_simulations_large
)

# Calculate statistics for the large-scale simulation
average_occurrences_large = np.mean(occurrences_large)
min_occurrences_large = np.min(occurrences_large)
max_occurrences_large = np.max(occurrences_large)
median_occurrences_large = np.median(occurrences_large)

average_occurrences_large, min_occurrences_large, max_occurrences_large, median_occurrences_large

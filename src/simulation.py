import numpy as np

# Define the simulation parameters
num_simulations = 1000
results = []

# Run the simulation
for _ in range(num_simulations):
    occurrences = sum(np.random.rand(hours_in_month) < hourly_probability)
    results.append(occurrences)

# Calculate statistics
average_occurrences = np.mean(results)
min_occurrences = np.min(results)
max_occurrences = np.max(results)
median_occurrences = np.median(results)

average_occurrences, min_occurrences, max_occurrences, median_occurrences

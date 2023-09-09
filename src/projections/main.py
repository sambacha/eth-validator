from sympy import *
from numpy import random
from itertools import groupby

x = symbols("x", real=True)


def calculate_prob_success_analytical(r, p):
    n = 32
    xx = min(i for i in solve(1 - x + (1 - p) * p**r * x ** (r + 1)) if i > 1)
    qn = ((1 - p * xx) / ((r + 1 - r * xx) * (1 - p))) * (1 / (xx ** (n + 1)))
    return (1 - qn) * 100


def calculate_prob_success_montecarlo(r, p):
    num_trials = 500000
    n = 32

    epoch_proposals = [random.binomial(1, p, size=n) for i in range(num_trials)]
    num_of_n_consec_proposals = sum(
        [1 for i in epoch_proposals if max_consecutive_ones(i) >= r]
    )

    return num_of_n_consec_proposals / num_trials * 100


def max_consecutive_ones(l):
    return max(([sum(g) for i, g in groupby(l) if i == 1]), default=0)


# n-consecutive blocks
r = [4, 5, 6, 7]

# pool share in %
p = [p / 100 for p in [14.68, 8.76, 5.16, 2.15, 1.76, 1.26, 0.84, 0.77, 0.68, 0.57]]

# prints:
# - probabilities of proposing n consetive blocks for different % share of network
# - montecarlo simulated vs analytical
# - n-consecutive blocks per month (6750 epochs)
for rr in r:
    for pp in p:
        p_analytical = calculate_prob_success_analytical(rr, pp)
        p_montecarlo = calculate_prob_success_montecarlo(rr, pp)
        print(
            "n=",
            pp,
            "r=",
            rr,
            p_analytical,
            p_montecarlo,
            "Monthly n-block:",
            (p_montecarlo / 100) * 6750,
        )

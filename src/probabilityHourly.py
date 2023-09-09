from sympy import symbols, Eq, solve

# Define the variable for probability
p = symbols("p")

# Equation based on the given condition
equation = Eq(1 - (1 - p) ** 12, 0.99)

# Solve for p
hourly_probability = solve(equation, p)[0]
hourly_probability

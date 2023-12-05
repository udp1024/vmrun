# Define the format string for strftime
# %A: full weekday name
# %B: full month name
# %d: day of the month as a decimal number
# %Y: year with century as a decimal number
# %I: hour as a decimal number using a 12-hour clock
# %M: minute as a decimal number
# %p: either AM or PM
format="%I:%M:%S %p"

# Print the current time using the date command and the format string
date "+$format"


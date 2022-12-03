#!/usr/bin/env python3

def priority(c):
    o = ord(c)
    # lowercase
    if o >= 97:
        return o - 96
    # UPPERCASE
    else:
        return o - 38

sum_of_priorities = 0
with open('data.txt', 'r') as file:
    for line in file:
        string = line.strip()
        a = set(string[len(string)//2:])
        b = set(string[:len(string)//2])
        intersection = list(a.intersection(b))
        if not len(intersection): continue
        error_item = intersection[0]
        sum_of_priorities += priority(error_item)

print(sum_of_priorities)

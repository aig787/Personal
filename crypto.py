import sympy
from sympy.matrices import *
from sympy.interactive.printing import init_printing
import random
import os
import sys

M = eye(3)
cols = M.cols

def scalar_multiply(M, row, scalar):
  M[row*M.cols] = M.row(row) * scalar

def row_add(M, r1, r2):
  M[r1*M.cols] = M.row(r1) + M.row(r2)

for i in range(100):
  scalar_multiply(M, random.randrange(0, M.rows), int.from_bytes(os.urandom(16), sys.byteorder, signed=True))
  row_add(M, random.randrange(0, M.rows), random.randrange(0, M.rows))

scalars = Matrix([1, 2, 3])
ans = M * scalars

undone = M.inv() * ans
# ans = scalars[:]
# for j in range(M.rows):
#   for i in range(M.cols):
#     ans[j] = M[j, i] * scalars[i]

print(ans)
print(undone)

# m = M.inv()
# for j in range(m.rows):
#   for i in range(m.cols):
#     ans[j] = m[j, i] *
#
#
# print(ans)

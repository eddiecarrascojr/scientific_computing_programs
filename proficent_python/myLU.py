from numpy import *
def mylu(A,piv=0): # LU decomposition, default=no pivoting
    A = A.copy() # shallow copy of A
    n = len(A) # number of rows of A
    p = range(n) # pivoting "vector"
    d = 1.0 # initialize determinant
    for k in range(n-1): # k=0,...,n-2
        if piv: # use pivoting
            c = list(abs(A[k:,k])) # abs of diag/subdiag coefs in column k
            i = c.index(max(c))+k # index of max multiplier
            A[[k,i]] = A[[i,k]] # permute rows k and i
            p[k],p[i] = p[i],p[k] # exchange values of p[k] and p[i]
            d = -d # permutation changes sign of determinant
        if A[k,k]!=0: # not zero
            A[k+1:,k] /= A[k,k] # compute multipliers (modulus <=1)
            A[k+1:,k+1:] -= A[k+1:,k]*A[k,k+1:] # update submatrix
        else: # A[k,k]=0
            print 'zero pivot at stage ', k+1 # singular matrix
        d *= A[k,k] # update determinant
    d *= A[-1,-1] # only thing to do for k=n-1
    return A,p,d # A contains L,U, p=permutation vector, d=determinant

def mysolve(LU,p,b): # assumes LU,p output of mylu
    n = len(LU) # number of rows
    if n==len(b): # make sure dimensions match
        x = b[p] # apply pivoting to RHS: Pb=b[p]
        for i in range(1,n): # forward elimination
            x[i] -= LU[i,:i]*x[:i]
        for i in range(n-1,-1,-1): # backward substitution
            x[i] -= LU[i,i+1:]*x[i+1:]
            x[i] /= LU[i,i]
    return x
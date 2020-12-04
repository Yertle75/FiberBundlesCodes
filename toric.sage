###################### Chain Complexes as linear transformations
#
# In our case, the chain complexes are a collection of vector spaces over GF(2), with linear transformations between them:
#
# B1 -----> B0      F1 ----> F0
#      dB               dF
#
# E2 ------> E1 -------> E0
#      d2          d1
#
# where dF is an nF*mF matrix  and dB an nB*mB matrix and
#
# d2 =
#  horizontal       vertical
# -----------------------------
# |              |             |
# | I_nB x dF    |  dB x I_nF  |   faces
# |              |             |
# ----------------------------- 
#
# In d2, each line is the boundary of a face, each column the co-boundary of an edge
#
# d1 = 
#    vertices
#  ------------
# |            |
# | dB x I_mF  |  horizontal edges
# |            |
# |------------|
# |            |
# | I_mB x dF  |  vertical edges
# |            |
# -------------
# In d1, each line is the boundary of an edge, each column the co-boundary of a vertex
#
def idm(x):
  return identity_matrix(GF(2),x)

def hw(v):
  return v.hamming_weight()

def VS(M):
  V = VectorSpace(GF(2),M.ncols())
  return V.subspace(M)

def smallest_vector(V):
  v_min = max(V[0],V[1])
  dmin = hw(v_min)
  for v in V:
    w = hw(v)
    if w< dmin and w != 0:
      v_min = v
      dmin = w
  return v_min 
  
def fast_smallest_vector(V):
  v_min = max(V[0],V[1])
  dmin = hw(v_min)
  for v in V:
    w = hw(v)
    if w< dmin and w != 0:
      v_min = v
      dmin = w
  return v_min 

def sample_smallest_vector(V,N):
  v_min = max(V[0],V[1])
  dmin = hw(v_min)
  for i,v in enumerate(V):
    if i==N:
      return v_min
    w = hw(v)
    if w< dmin and w != 0:
      v_min = v
      dmin = w
  return v_min 


# computing the partial operators d1, d2 of the product
def hom_prod(dB,dF):
  nB = dB.nrows()
  mB = dB.ncols()
  nF = dF.nrows()
  mF = dF.ncols()
  d2 = idm(nB).tensor_product(dF).augment(dB.tensor_product(idm(nF)))
  d1 = dB.tensor_product(idm(mF)).transpose().augment(idm(mB).tensor_product(dF).transpose()).transpose()
  return d2,d1

# example  

load("complexes.sage")
dB,dF = tennis_court()
d2,d1 = hom_prod(dB,dF)
Ker_d1 = d1.kernel()
Im_d2 = VS(d2)
H1 = Ker_d1/Im_d2 
H1_basis = matrix([H1.lift(b) for b in H1.basis()])       

Ker_d2t = d2.transpose().kernel() 
Im_d1t = VS(d1.transpose())
H1t = Ker_d2t/Im_d1t
H1t_basis = matrix([H1t.lift(b) for b in H1t.basis()])          

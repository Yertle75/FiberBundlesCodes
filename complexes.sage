# defining the Base and the Fiber (just specifying their partial operator)
# each lines represents the boundary of a 1-cell
# each column represents the co-boundary of a 0-cell 

def toric2by3():
  nB = 2
  mB = 2
  dB = matrix(GF(2),[
  [1,1],
  [1,1]
  ])
  nF = 3
  mF = 3
  dF = matrix(GF(2),[
  [1,1,0],
  [0,1,1],
  [1,0,1],
  ])
  return dB,dF

def weird3by3():
  dB = matrix(GF(2),[
  [1,1,1],
  [1,1,1]
  ])
  dF = matrix(GF(2),[
  [1,1,0],
  [0,1,1],
  [1,0,1],
  ])
  return dB,dF

def tennis_court():
	dB = matrix(GF(2),[
	[1,1,1,0,0,0,0],
	[1,1,0,0,0,0,0],
	[0,1,1,0,0,0,0],
	[1,0,0,1,1,0,0],
	[0,0,1,1,0,0,1],
	[0,0,0,0,1,1,0],
	[0,0,0,0,0,1,1],
	[0,0,0,0,1,1,1]
	])
	dF = matrix(GF(2),[
	[1,1,0],
	[0,1,1],
	[1,0,1],
	])
	return dB,dF

def toric(nB,nF):
  v = vector(GF(2),nB)
  v[-1] = 1
  dB = matrix(GF(2),nB,0)
  for i in range(nB):
    v[i-2] = 0
    v[i] = 1
    dB = dB.augment(v)
  v = vector(GF(2),nF)
  v[-1] = 1
  dF = matrix(GF(2),nF,0)
  for i in range(nF):
    v[i-2] = 0
    v[i] = 1
    dF = dF.augment(v)
  return dB,dF
  
  
    

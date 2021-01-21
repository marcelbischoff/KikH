import numpy as np

class FusionRing:
  def __init__(self, rank=1):
    self.rank = rank
    self.N = np.zeros((rank,rank,rank),dtype=int)
    self.N[0] = np.eye(rank)

  def checkAssociative(self):
    return (np.einsum('ilj,lmk -> ijkm', self.N, self.N) == np.einsum('iml,jlk -> ijkm', self.N, self.N)).all()

  def isCommutative(self):
    return (self.N == np.swapaxes(self.N, 0,2)).all()

  def isSelfDual(self):
    return (self.N[:,0,:] == np.eye(self.rank)).all()

  def checkCharge(self):
    return (self.N[:,0,:].dot(self.N[:,0,:]) == np.eye(self.rank)).all()
  
  def su2(self,level):
    self.rank = level+1
    self.N = np.zeros((self.rank,self.rank,self.rank),dtype=int)
    self.N[0] = np.eye(self.rank)
    for i in range(self.rank):
      for j in range(self.rank):
        for k in range(abs(i-j),i+j+1,2):
          if i+j+k <= 2*level:
            self.N[i,k,j]=1
    return True
"""
  def PrintFusionRules(self)
    for i in range(rank)
      for j in range(rank)
        #printf('[%d][%d] = ',i,j)
        str = ''
      for k = 1:m
        if NN(i,j,k)==1
	  printf('%s[%d]',str, k);
	  str = ' + ';
	end
	if NN(i,j,k) > 1
	  printf('%s%d[%d]',str,NN(i,j,k),k);
	  str = ' + ';
	end
      end
      printf('\n')
    end
  end
end
"""



if __name__ == '__main__':
  r = FusionRing(2)
  r.N[1] = [[0,1],[1,1]]
  assert(r.checkAssociative())
  print(r.isCommutative())
  print(r.isSelfDual())
  print(r.N[:,0,:])

  r.su2(10)
  assert(r.checkAssociative() and  r.checkCharge())
""" 
"""

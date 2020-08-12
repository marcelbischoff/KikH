function N = SU2FusionRules(level)
  rank = level+1;
  N=zeros(rank,rank,rank);
  for i = 0:level
    for j = 0:level
      for k = abs(i-j):2:i+j
        if (i+j+k <= 2*level)
	  N(i+1,j+1,k+1) = 1;
        end
      end
    end
  end
end

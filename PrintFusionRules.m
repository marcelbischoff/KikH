function PrintFusionRules(NN)
  m=size(NN,1)
  for i = 1:m
    for j = 1:m
      printf('[%d][%d] = ',i,j);
      str = '';
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


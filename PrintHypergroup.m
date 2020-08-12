function PrintHypergroup(NN)
  m=size(NN,1);
  printf('\nHypergroup of rank %d:\n',m)
  for i = 1:m
    for j = 1:m
      printf('[%d] * [%d] = ',i,j);
      str = '';
      for k = 1:m
        if NN(i,j,k)==1  || NN(i,j,k)>=.999999999999999
	  printf('%s[%d]',str, k);
	  str = ' + ';
	elseif NN(i,j,k) > 0
	  printf('%s%d[%d]',str,NN(i,j,k),k);
	  str = ' + ';
	end
      end
      printf('\n')
    end
  end
end


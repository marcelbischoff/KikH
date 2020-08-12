
function Bf = Factorize(Af,Bf)
  n=size(Af,1);
  m=size(Bf,2);

  if m == 0
    printf('---Factorizing: done---\n');
    return
  end

  printf('---Factorizing %d x %d---\n',n,m);

  simples = [];

  for i = 1:n
    if Af(i,i) == 1
      if length(simples)==0 || Af(simples,i) == zeros(length(simples),1)
	simples = [simples,i];  
      end  
    end
  end


  k = length(simples);
  if k == 0
    printf('---Factorizing: no simples anymore---\n');
    return
  endif

  nsimples = setdiff(1:n,simples);


  Bf(simples,:) = 0;
  for i = 1:k
    Bf(:,i)=Af(:,simples(i));
  end


  if k == m
    printf('---Factorizing: succesfull ---\n');
    return
  end 

  Anew = Af(nsimples,nsimples) - Af(nsimples,simples)*Af(simples,nsimples);
  nnew = n-k;
  mnew = m-k;
  Bnew = -ones(nnew,mnew);
  Bf(nsimples,(k+1):m) = Factorize(Anew,Bnew);
  return
end



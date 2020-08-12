
%SU(2)_10 fusion rules
level = 10;
N = SU2FusionRules(level);
rank = level+1;

%A = 0+6 is an etale algebra, compute matrix A
curr = zeros(rank);
curr(1)=1;
curr(7)=1;
A = zeros(rank,rank);
for i = find(curr)'
  A=A+curr(i)*reshape(N(:,i:i,:),rank,rank);
end
A

%rank of C_A we know from modular invariant
m=6;
n=size(A,1);
B=-ones(n,m);
B = Factorize(A,B)

NN = zeros(m,m,m);
%Fusion rules need to solve AA*xx=bb
AA = kron(B,B);
if (length(null(AA)) ~= 0)
  printf('WARNING: solution not unique!!!');
end
AAinv = pinv(AA);

for c=1:m
  bb = reshape(N,n*n,n)*B(:,c);
  NN(:,:,c) = int32(round(reshape(AAinv*bb,m,m)));
  if (AA*reshape(NN(:,:,c),m*m,1)-bb ~= zeros(size(bb)))
    printf('WARNING: solution not correct!!!');
  end
end

PrintFusionRules(NN);
dims = zeros(m,1);
for i = 1:m
  dims(i) = norm(reshape(NN(i,:,:),m,m));
end
dims


K = 1:m;
Kloc = [1,5,6];

%Kloc = [1,5];
%TODO is subhypergroup
%is normal

dims(Kloc);
%K/Kloc
Cosets = zeros(1,m);
Cosets(:,Kloc) = ones(1,length(Kloc));
Reps = [1];
for i = setdiff(K,Kloc)
  if sum(Cosets(:,i)) == 0
    tmp = zeros(1,m);
    for j = Kloc
      for k = 1:m
	if NN(i,j,k) > 0 
	  tmp(k)=1;
	end
      end
    end
    Reps = [Reps;i];
    Cosets=[Cosets;tmp];
  end
end
Reps
Cosets

C=zeros(m,m,m);
for i=1:m
  for j=1:m
    for k=1:m
      C(i,j,k) = NN(i,j,k)/dims(i)/dims(j)*dims(k);
    end
  end
end
%PrintHypergroup(C);

D=sum(dims(Kloc))
%rank of Quotient Hypergroup
mm=length(Reps)
%Coefficients of Quotient Hypergroup
CC = zeros(mm,mm,mm);
for i=1:mm
  for j=1:mm
    for k=1:mm
      for l=Kloc
      	CC(i,j,k) =  dims(l)*C(Reps(i),l,:)*C(:,Reps(j),:)*Cosets(k,:)'/D;
      	CC(i,j,k) =  C(Reps(i),l,:)*C(:,Reps(j),:)*Cosets(k,:)';
      end
    end
  end
end
PrintHypergroup(CC);
PrintHypergroup(C);




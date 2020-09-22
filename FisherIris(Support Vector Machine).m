 G=load("fisheriris.mat");
 Y=[ones(50,1);-1*ones(50,1)];
 X=G.meas(1:100,[2 3]);
 
 n=length(X);
 eta=0.01;
 k=10;
 cv=randperm(n,n);
  
 Xtr=X(cv(1:n-(n/k)),:);
 Ytr=Y(cv(1:n-(n/k)));
 Xts=X(cv(n-(n/k)+1:end),:);
 Yts=Y(cv(n-(n/k)+1:end));
 
 %Training 
 b=0;
 w=zeros(1,size(X,2));
 for it=1:1000
     c=randperm(length(Xtr),1);
     if(1-Ytr(c)*(Xtr(c,:)*w'+b)>0)
         b=b-eta*(-1*Ytr(c));
         w=w-eta*(2*(1/it)*w-(1/n)*Ytr(c)*Xtr(c,:));
     else
         b=b;
         w=w-eta*(2*(1/it)*w);
     end
 end
 %Testing
 y_test=Xts*w'+b;
 y_test(y_test>=0)=+1;
 y_test(y_test<0)=-1;
 %Evaluating accuracy
 sum(abs(y_test-Yts)/2) %The more iterations you add, the more precision you get
 
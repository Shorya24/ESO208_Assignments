%Taking input and declaring variables
fileID = fopen("Input1.txt");
data = fgetl(fileID);
n = sscanf(data, '%f');
A=zeros(n,n);
for i=1:1:n
    data = fgetl(fileID);
    A(i,1:1:n) = sscanf(data, '%f');
end
data = fgetl(fileID);
itr_max = sscanf(data, '%f');
data = fgetl(fileID);
err_max = sscanf(data, '%f');
m=n;
itr=0;
diagA=zeros(n,1);
errA=ones(n,1);
eigenvalues=zeros(itr_max,n);

%QR method
for i=1:n
    diagA(i)=A(i,i);
end
while(itr<itr_max)
        z = zeros(n,1);
        Q = zeros(m,n);
        R = zeros(n,n);
        for i = 1:m
            Q(i,1) = A(i,1) / norm(A(:,1));
        end
        for i = 2:n
            sum = zeros(m,1);
            for k = 1:i-1
                sum = sum + (A(:,i)'*Q(:,k))*Q(:,k);
            end
            z = A(:,i) - sum;
            for j = 1:m
                Q(j,i) = z(j)/norm(z);
            end
        end
       
        R=inv(Q)*A;
        if(itr>0)
            for i=1:n
                errA(i)= (abs((A(i,i)-diagA(i))/A(i,i)))*100;
            end
        end
        for i=1:n
            diagA(i)=A(i,i);
        end
        if(norm(errA)<=err_max) 
                break; 
        end

        itr=itr+1;
        eigenvalues(itr,:)=diagA;
        A=R*Q ;
end

%Displaying output
fprintf("Eigenvalues\n");
disp(diagA);
disp("Iterations");
disp(itr);
disp("Eigenvalues obtained at each iteration");
for i=1:itr
    for j=1:n
        fprintf('%f\n', eigenvalues(i,j));
    end
    fprintf('\n');
end

%Writing output to text file
filename = "output4.txt";
outputfile = fopen(filename, "w");
fprintf(outputfile,"Eigenvalues\n");
for i=1:n
    fprintf(outputfile,'%f\n',diagA(i,1));
end
fprintf(outputfile,"\nIterations\n");
fprintf(outputfile, '%d\n', itr);
fprintf(outputfile,"\nEigenvalues obtained at each iteration\n");
for i=1:itr
    for j=1:n
        fprintf(outputfile,'%f\n', eigenvalues(i,j));
    end
    fprintf(outputfile,'\n');
end
fclose(outputfile);
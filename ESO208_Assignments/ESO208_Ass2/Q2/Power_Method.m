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
v=ones(n,1);
itr=0;
e1=1;
eigenvalues=zeros(itr_max,1);

%Power method
while(itr<itr_max)
        B=A*v;
        eigen_value=max(abs(B));
        eigen_vector=B/eigen_value;
        v=eigen_vector;
        e2=eigen_value;
        err=abs((100*(e2-e1))/e2);
        e1=e2;
        itr=itr+1;
        eigenvalues(itr,1) = e1;
        if (err<=err_max)
            break
        end
end

%Displaying output
disp("Eigenvalue");
disp(eigen_value);
disp("Eigenvector");
disp(v);
disp("Iterations");
disp(itr);
disp("Eigenvalues obtained at each iteration");
for i=1:itr
    fprintf('%d %f\n',i,eigenvalues(i,1));
end

%Writing output to text file
filename = "output1.txt";
outputfile = fopen(filename, "w");
fprintf(outputfile,"Eigenvalue\n");
fprintf(outputfile, '%f\n', eigen_value);
fprintf(outputfile,"\nEigenvector\n");
for i=1:n
    fprintf(outputfile,'%f\n',v(i,1));
end
fprintf(outputfile,"\nIterations\n");
fprintf(outputfile, '%d\n', itr);
fprintf(outputfile,"\nEigenvalues obtained at each iteration\n");
for i=1:itr
    fprintf(outputfile,'%d %f\n',i,eigenvalues(i,1));
end
fclose(outputfile);
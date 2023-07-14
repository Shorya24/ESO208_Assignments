%Taking input and declaring variables
fileID = fopen("Input.txt");
data = fgetl(fileID);
n = sscanf(data, '%f');
Aug = zeros(n, n+1);
for i=1:1:n
    data = fgetl(fileID);
    Aug(i,1:1:n+1) = sscanf(data, '%f');
end
A = Aug(:,1:n);
B = Aug(:,n+1);
X = zeros(n,1);
Y = zeros(n,1);
L = zeros(n,n);
U = zeros(n,n);

%Finding values of L and U matrices
for i=1:n
    U(i,i) = 1;
end
L(:,1) = A(:,1);
U(1,:) = A(1,:)/L(1,1);
for i=2:n
    for k=i:n
        L(k,i) = A(k,i) - L(k,1:i-1)*U(1:i-1,i);
    end
    for j=i+1:n
        U(i,j) = (A(i,j) - L(i,1:i-1)*U(1:i-1,j))/L(i,i);
    end
end

%Finding value of y
Y(1) = B(1)/L(1,1);
for k=2:n
    Y(k) = (B(k) - L(k,1:k-1)*Y(1:k-1))/L(k,k);
end

%Finding value of x
X(n) = Y(n)/U(n,n);
for k=n-1:-1:1
    X(k) = (Y(k) - U(k,k+1:n)*X(k+1:n))/U(k,k);
end

%Displaying output in screen
disp("x");
disp(X);
fprintf('\n');
disp("L");
disp(L);
fprintf('\n');
disp("U");
disp(U);

%Writing output to text file
filename = "output4.txt";
outputfile = fopen(filename, "w");
fprintf(outputfile,"x\n");
for i=1:n
    fprintf(outputfile,'%f\n',X(i,1));
end
fprintf(outputfile,"\nL\n");
for i=1:n
    for j=1:n
        fprintf(outputfile,'%f ',L(i,j));
    end
    fprintf(outputfile,'\n');
end
fprintf(outputfile,"\nU\n");
for i=1:n
    for j=1:n
        fprintf(outputfile,'%f ',U(i,j));
    end
    fprintf(outputfile,'\n');
end
fclose(outputfile);

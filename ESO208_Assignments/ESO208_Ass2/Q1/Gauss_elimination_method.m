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

%Forward elimination
for j=1:n-1
    for i= j+1:n
        m=Aug(i,j)/Aug(j,j);
        Aug(i,:) = Aug(i,:) - m*Aug(j,:);
    end
end

%Back subsitution
X(n) = Aug(n,n+1)/Aug(n,n);
for k = n-1:-1:1
    X(k) = (Aug(k,n+1) - Aug(k,k+1:n)*X(k+1:n))/Aug(k,k);
end

%Displaying output in screen
disp("x");
disp(X);

%Witing output to text file
filename = "output1.txt";
outputfile = fopen(filename, "w");
fprintf(outputfile,"x\n");
for i=1:n
    fprintf(outputfile,'%f\n',X(i,1));
end
fclose(outputfile);
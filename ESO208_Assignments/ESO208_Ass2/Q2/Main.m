choice = menu("Choose method for finding eigenvalues of a matrix", "Power Method", "Inverse Power Method", "Inverse Power Method with shift", "QR Method");
if(choice==1)
    Power_Method
elseif(choice==2)
    Inverse_Power_Method
elseif(choice==3)
    Inverse_Power_Method_withshift
elseif(choice==4)
    QR_Method
else
    disp("Error");
end
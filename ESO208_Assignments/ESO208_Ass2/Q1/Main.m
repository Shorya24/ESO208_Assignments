choice = menu("Select method for solving system of linear equations:","Gauss Elimination method without pivoting", "Gauss Elimination method with partial pivoting", "Doolittle method", "Crout method", "Cholesky method" );
if(choice==1)
    Gauss_elimination_method
elseif(choice==2)
    Gauss_elimination_partialpivoting
elseif(choice==3)
    Doolittle_method
elseif(choice==4)
    Crout_method
elseif(choice==5)
    Cholesky_method
else
    disp("Error");
end
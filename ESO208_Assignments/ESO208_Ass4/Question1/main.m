fileid=fopen("inputFile.txt",'r');
formatspec='%s\n';
f = fscanf(fileid,formatspec,1);
f=str2sym(f);
formatSpec= '%f\n';
a = fscanf(fileid,formatSpec,1);
b = fscanf(fileid,formatSpec,1);
err_max=fscanf(fileid,formatSpec,1);

choice = menu('Select one of the following methods:', "Romberg Integration", "Gauss-Legendre quadrature");

%Code for Romberg Integration
if choice==1
    hold on
    plot(a,subs(f,a),"k*",b,subs(f,b),"k*");
    I=zeros(10);
    n=1;
    h=(b-a)/n;
    xo=a;
    x1=a+h;
    sum=0;
    
    for y=1:n
        sum=sum+h*(subs(f,x1)+subs(f,xo))/2;
        xo=x1;
        x1=x1+h;
    end
    I(1,1)=sum;
    
    for i=1:9
        n=2^i;
        h=(b-a)/n;
        hold on
        plot(h,subs(f,h),"k*")
        grid on
        xlabel("x");
        ylabel("y");
        title("Romberg Integration")
        xo=a;
        x1=a+h;
        sum=0;
        for r=1:n
            sum=sum+h*(subs(f,x1)+subs(f,xo))/2;
            xo=x1;
            x1=x1+h;
        end
        I(i+1,1)=sum;
        
        for k=2:i+1
            j=2+i-k;
            I(j,k)=(4^(k-1)*I(j+1,k-1)-I(j,k-1))/(4^(k-1)-1);
        end
        err=((I(1,i+1)-I(2,i))/I(1,i+1))*100;
        if abs(err)<=err_max
            break
        end
    end
    
    fprintf("%f\n",I(1,i+1));
    fprintf("%f\n",i*2)
    fprintf("%f\n",err)
    fileID = fopen('RombergIntegration_output.txt','w');
    fprintf(fileID,"%f\n",I(1,i+1));
    fprintf(fileID,"%f\n",i*2);
    fprintf(fileID,"%f\n",err);

end

%Code for Gauss Legendre Quadrature
if choice==2
    syms z
    r=(b-a)/2*z+(b+a)/2;
    Io=(b-a)*subs(f,(b+a)/2);
    hold on
    plot((b+a)/2,subs(f,(b+a)/2),"k*")
    xlabel("x")
    ylabel("y")
    title("Gauss-Legendre Quadrature")
    grid on

    for i=2:5
        if i==2
            r1=subs(r,-0.57735);
            r2=subs(r,0.57735);
            f1=subs(f,r1);
            f2=subs(f,r2);
            I=(b-a)/2*(f1+f2);
            hold on 
            plot(r1,f1,"k*",r2,f2,"k*")
            grid on
            err=(I-Io)/(I)*100;
            if abs(err)<err_max
                break
            else 
                Io=I;
            end

        elseif i==3
            r1=subs(r,-0.77460);
            r2=subs(r,0);
            r3=subs(r,0.77460);
            f1=subs(f,r1);
            f2=subs(f,r2);
            f3=subs(f,r3);
            I=(b-a)/2*(0.55556*f1+0.88889*f2+0.55556*f3);
            hold on 
            plot(r1,f1,"k*",r2,f2,"k*",r3,f3,"k*")
            grid on
            err=(I-Io)/(I)*100;
            if abs(err)<err_max
                break
            else 
                Io=I;
            end

        elseif i==4
            r1=subs(r,-0.33998);
            r2=subs(r,-0.86114);
            r3=subs(r,0.86114);
            r4=subs(r,0.33998);
            f1=subs(f,r1);
            f2=subs(f,r2);
            f3=subs(f,r3);
            f4=subs(f,r4);
            I=(b-a)/2*(0.65215*f1+0.34785*f2+0.34785*f3+0.65215*f4);
            hold on 
            plot(r1,f1,"k*",r2,f2,"k*",r3,f3,"k*",r4,f4,"k*")
            grid on
            err=(I-Io)/(I)*100;
            if abs(err)<err_max
                break
            else 
                Io=I;
            end

        elseif i==5
            r1=subs(r,-0.53847);
            r2=subs(r,-0.90618);
            r3=subs(r,0);
            r4=subs(r,0.90618);
            r5=subs(r,0.53847);
            f1=subs(f,r1);
            f2=subs(f,r2);
            f3=subs(f,r3);
            f4=subs(f,r4);
            f5=subs(f,r5);
            I=(b-a)/2*(0.47863*f1+0.23693*f2+0.56889*f3+0.23693*f4+0.56889*f5);
            err=(I-Io)/(I)*100;
            hold on 
            plot(r1,f1,"k*",r2,f2,"k*",r3,f3,"k*",r4,f4,"k*",r5,f5,"k*")
            grid on

        end
    end

    fprintf("%f\n",I);
    fprintf("%f\n",i);
    fprintf("%f\n",err)
    fileID = fopen('GaussLegendreQuadrature_output.txt','w');
    fprintf(fileID,"%f\n",I);
    fprintf(fileID,"%f\n",i);
    fprintf(fileID,"%f\n",err);

end



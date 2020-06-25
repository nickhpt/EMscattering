function [ L ] = Lmatrix(r,rp,Lcube,freq)
%ShitMayo
%   Detailed explanation goes here
if isnan(r(1))
    L = zeros(3);
    return
end

D=norm(r-rp);
Theta=(r-rp)/D;
G0=(3.*Theta*Theta'-eye(3))/(4*pi*D.^3);
kb=(2*pi*freq)/physconst('LightSpeed'); %Wave number

% !!! Test index or use norm()<eps instead of r==rp
    %Singular
if norm(r-rp) < 1e-6
    %a=nthroot((3/4*pi)*Lcube^3,3);
    a=((3/4*pi)*Lcube^3)^(1/3);
    L=2/3*((1+1i*kb*a)*exp(-1i*kb*a)-1)*eye(3);
    
else 
    %Non singular 
    %g1=((exp(-1i*kb*(r-rp))-1)/(4*pi*(r-rp)));
    g1=(exp(-1i*kb*D)-1)/(4*pi*D);
    g=(exp(-1i*kb*D)/(4*pi*D));
    thet=Theta*Theta';
    G1=(g1/D^2).*(3*thet-eye(3))+((1i*kb*g)/D)*(3*thet-eye(3))-kb^2*g*thet; %Eq 60
    
    %G1=(g1/D.^2)*(3*(Theta*Theta')-eye(3))+((1i*kb*g)/(D))*(3*(Theta*Theta')-eye(3))....
    %    -kb^2*g*(Theta*Theta'); %Eq. 60
    Gd=kb^2.*g.*eye(3)+G1; %eq62
    
    %Gd=kb^2*(exp(-1i*kb*(D))/(4*pi*(D)))*eye(3)+G1; %Eq 62
    
    L=(G0+Gd).*Lcube^3; 
    
end

end
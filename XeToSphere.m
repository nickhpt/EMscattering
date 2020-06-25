function [ XeNEW ] = XeToSphere(er,eb, Xe, Nx, Ny, Nz, lcube)
	XeNEW = Xe;
	L_xyz=[Nx*lcube,Ny*lcube,Nz*lcube];
	dim_min=min(L_xyz);
    R=dim_min/2; %Radius is half of minimum dimension 
    c=[L_xyz(1)/2;L_xyz(2)/2;L_xyz(3)/2];
    for idz=1:Nz
        for idy=1:Ny
            for idx=1:Nx 
                cx=lcube*(idx-1/2);
                cy=lcube*(idy-1/2);
                cz=lcube*(idz-1/2);
                if sqrt(((cx-c(1)).^2+(cy-c(2)).^2+(cz-c(3)).^2))<R/2
               
					XeNEW(idx,idy,idz,1) = er/eb-1;
					XeNEW(idx,idy,idz,2) = er/eb-1;
					XeNEW(idx,idy,idz,3) = er/eb-1;
                    
               
                end
            end
        end
    end
end

function [C] = getCirculantBlocks(Nx, Ny, Nz, Cx, Cy, Cz, lcube, freq)
    C = zeros(2*Nx,2*Ny,2*Nz,3,3);
    idx =  @(k) (2*Nx-k+2)*(k>Nx)+k*(k<=Nx); %Return k if k is physical else return 
    idy =  @(k) (2*Ny-k+2)*(k>Ny)+k*(k<=Ny);
    idz =  @(k) (2*Nz-k+2)*(k>Nz)+k*(k<=Nz);

    for kz = 1:2*Nz
        for ky = 1:2*Ny
            for kx = 1:2*Nx
                 
            
                if (kx==Nx+1) ||(ky==Ny+1) || (kz==Nz+1)
                     C(kx,ky,kz,:,:) = zeros(3,3);  
                else %Inside physical problem
                     dx = Cx(idx(kx)) - Cx(1);
                     dy = Cy(idy(ky)) - Cy(1);
                     dz = Cz(idz(kz)) - Cz(1);
                     if kx > Nx+1 %Imaginary voxel cond.
                         dx = -dx;
                     end
                     if ky > Ny+1
                         dy = -dy;
                     end
                     if kz > Nz+1
                         dz = -dz;
                     end
                     d = [dx;dy;dz]; %is vector r-rp, norm(d)=D
                    Ltemp = Lmatrix2(d,lcube,freq);        
                    for i = 1 : 3
                        for j = 1 : 3
                            C(kx,ky,kz,i,j) = Ltemp(i,j); %Circulant matrix creation
                        end
                    end
                    
                end
                
            end
        end
    end
end
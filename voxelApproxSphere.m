function [ Cx, Cy, Cz, numVox ] = voxelApproxSphere( Nx, Ny, Nz, lcube)
    cnt = 1;
     L_xyz=[Nx*lcube,Ny*lcube,Nz*lcube];
     dim_min=min(L_xyz);
    R=dim_min/2; %Radius is half of minimum dimension 
    c=[L_xyz(1)/2;L_xyz(2)/2;L_xyz(3)/2];
    const = sqrt(3)/2*lcube;
    for idz=1:Nz
        for idy=1:Ny
            for idx=1:Nx 
                cx=lcube*(idx-1/2);
                cy=lcube*(idy-1/2);
                cz=lcube*(idz-1/2);
                if sqrt(((cx-c(1)).^2+(cy-c(2)).^2+(cz-c(3)).^2))<R/2
                    Cx(cnt)=cx;
                    Cy(cnt)=cy;
                    Cz(cnt)=cz;
                    cnt=cnt+1;
                end
            end
        end
    end
    numVox = cnt-1;
end
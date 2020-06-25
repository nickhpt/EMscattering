function [ Cx, Cy, Cz, numVox] = voxelApproxCube( Nx, Ny, Nz, lcube )
%VOXELAPPROXCUBE Summary of this function goes here
%   Detailed explanation goes here
    cnt = 1;
    for idz=1:Nz
        for idy=1:Ny
            for idx=1:Nx 
                Cx(cnt)=lcube*(idx-1/2);
                Cy(cnt)=lcube*(idy-1/2);
                Cz(cnt)=lcube*(idz-1/2);
                cnt=cnt+1;
            end
        end
    end
    numVox = cnt-1;

end


function P = runIterativeSolver(maxit, tol, Nx, Ny, Nz, X_e, b, Cx, Cy, Cz, lcube, freq)
N = Nx*Nz*Ny;
Pnew = zeros(2*Nx,2*Ny,2*Nz,3); % Start by guessing nothing! (Extended P)
C = -1*getCirculantBlocks(Nx, Ny, Nz, Cx, Cy, Cz, lcube, freq);
C(1,1,1,1,1) = 1/3;
C(1,1,1,2,2) = 1/3;
C(1,1,1,3,3) = 1/3;

Cfft = zeros(2*Nx,2*Ny,2*Nz,3,3);
for i = 1 : 3
    for j = 1 : 3
        Cfft(:,:,:,i,j) = fftn(C(:,:,:,i,j));
    end
end

P = cgs(@afun,b,tol,maxit);
%P = gmres(@afun,b,1,tol,maxit);

function y = afun(Pnew)
    Lrows = zeros(2*Nx,2*Ny,2*Nz,3);
    Pnew = reshape(Pnew,2*Nx,2*Ny,2*Nz,3);
    
    fftPnew = zeros(2*Nx,2*Ny,2*Nz,3);
    
   for j = 1 : 3
       fftPnew(:,:,:,j) = fftn(Pnew(:,:,:,j));
   end
    
    for i = 1 : 3
        for j = 1 : 3
            %Lrows(:,:,:,i) = Lrows(:,:,:,i)+reshape(Cfft(:,:,:,i,j),2*Nx,2*Ny,2*Nz,1).*fftPnew(:,:,:,j);
            Lrows(:,:,:,i) = Lrows(:,:,:,i)+Cfft(:,:,:,i,j).*fftPnew(:,:,:,j);
        end
    end
   
    Lrows2 = zeros(2*Nx,2*Ny,2*Nz,3);
    for j = 1 : 3
       Lrows2(:,:,:,j) = ifftn(Lrows(:,:,:,j));
    end
%     Lrows(:,:,Nz+1:end,:) = 0;
%     Lrows(:,Ny+1:end,:,:) = 0;
%     Lrows(Nx+1:end,:,:,:) = 0;
    
    %y = Pnew+1/3*X_e.*Pnew-X_e.*Lrows;  
    y = Pnew + X_e.*Lrows2;
     y = reshape(y,3*2*Nx*2*Ny*2*Nz,1);

    end
end



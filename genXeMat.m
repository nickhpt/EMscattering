function [X_e] = genXeMat(Nx, Ny, Nz, chi_e)
%     chi_e=ones(1,2*N)*chi_e;
        X_e = ones(2*Nx,2*Ny,2*Nz,3)*chi_e;
         X_e(:,:,Nz+1:end,:) = 0;
        X_e(:,Ny+1:end,:,:) = 0;
        X_e(Nx+1:end,:,:,:) = 0;
%     chi_e(N+1:end)=0;
%     Xe=diag(chi_e);
% 
%     X_e1=[Xe,zeros(2*N,2*N),zeros(2*N,2*N)];
%     X_e2=[zeros(2*N,2*N),Xe,zeros(2*N,2*N)];
%     X_e3=[zeros(2*N,2*N),zeros(2*N,2*N),Xe];
%     X_e=vertcat(X_e1,X_e2,X_e3);
end


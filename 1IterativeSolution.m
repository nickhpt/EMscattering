close all; clear all; clc;
% Retrieve Problem Variables
getInputVars;

%Generate centers and voxels
[Cxx, Cyy, Czz, N] = voxelApproxCube(Nx, Ny, Nz, lcube); 

% Generate Suceptibility Matrix
[X_e] = genXeMat(Nx,Ny,Nz, chi_e);
[X_e] = XeToSphere(epsilon_r,epsilon_b, X_e, Nx, Ny, Nz, lcube);

% Define Excitation
b = ones(2*Nx,2*Ny,2*Nz,3);
         b(:,:,:,2) = 0;
         b(:,:,:,3) = 0;
         b(:,:,Nz+1:end,:) = 0;
         b(:,Ny+1:end,:,:) = 0;
         b(Nx+1:end,:,:,:) = 0;
         
b = X_e .* b;
b = reshape(b,3*2*Nx*2*Ny*2*Nz,1); % Ensure compatibility with cgs/gmres

% Only unique values, all combinations handled by getCirculantBlocks
Cx = unique(Cxx); Cy = unique(Cyy); Cz = unique(Czz);

% Solve for polarization density vectors iteratively
tic
[P] = runIterativeSolver(maxit, tol, Nx, Ny, Nz, X_e, b, Cx, Cy, Cz, lcube, freq);
%[P] = dynamicIterativeSolver([],maxit, tol, Nx, Ny, Nz, X_e, b, Cx, Cy, Cz, lcube, freq);
toc


P = reshape(P,2*Nx,2*Ny,2*Nz,3);
Px = P(1:Nx,1:Ny,1:Nz,1);
Py = P(1:Nx,1:Ny,1:Nz,2);
Pz = P(1:Nx,1:Ny,1:Nz,3);
Pxx=reshape(Px,Nx*Ny*Nz,1);
Pyy=reshape(Py,Nx*Ny*Nz,1);
Pzz=reshape(Pz,Nx*Ny*Nz,1);
%
q=quiver3(Cxx',Cyy',Czz',Pxx,Pyy,Pzz);
camproj('orthographic')


%[startX,startY,startZ] = meshgrid(1:max(Cxx),1:max(Cyy),1:max(Czz))
%streamline(stream2(Cxx',Cyy',Czz',Pxx,Pyy,Pzz,startX,startY,startZ))
view([-90 -90])
daspect([1 1 1])
q.Color = 'blue';
q.AutoScale = 'on';
q.AlignVertexCenters = 'on';
q.AutoScaleFactor = 1.9;
q.LineWidth = 2;
q.MaxHeadSize = 50;
%q.LineSpec='filled'
%title(sprintf('er=%epsilon_r'));



%Polarization in center 
P((Nx+1)/2,(Ny+1)/2,(Nz+1)/2,1);
P((Nx+1)/2,(Ny+1)/2,(Nz+1)/2,2);
P((Nx+1)/2,(Ny+1)/2,(Nz+1)/2,3);


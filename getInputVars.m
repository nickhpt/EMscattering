

% --------------------- Simulation  ---------------------  
maxit = 100; % Max iterations for iterative solver
tol = 1e-12; % Tolerance for iterative solver
restart=[];  %Dynamic solver restarts every "restart" iteration

% --------------------- Geometry  --------------------- 
% lcube = 1/11;       % Side-length of each voxel 2.71 mm
Lx = 1;
Ly = 1;
Lz = 1;
freq = 0;        % Frequency
N0 =5;
Nz = N0;
Ny = N0;
Nx = N0;
% Lx=lcube*Nx;Ly=lcube*Ny;Lz=lcube*Nz; % Actual bound dimensions
lcube = 1/N0;

% --------------------- Electromagnetic constants  --------------------- 
epsilon_r=4; % Relative permittivity 
epsilon_0=8.854187e-12;
epsilon_b=3;
chi_e=epsilon_r-1; % Electric susceptibility 

maxit = Nx*Ny*Nz;
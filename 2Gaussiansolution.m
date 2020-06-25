clear all;clc
%%

getInputVars;

%Generate centers and voxels
[Cx, Cy, Cz, numVox] = voxelApproxCube(Nx, Ny, Nz, lcube); 
%[Cx, Cy, Cz, numVox] = voxelApproxSphere(Nx, Ny, Nz, lcube); 


% Create L-Matrix
Lkl=zeros(3,3,numVox,numVox); % Initialize 4-dimensional dyad placeholder
L = zeros(3,numVox,3,numVox);

for k=1:numVox
    for l=1:numVox
        Ltemp = Lmatrix([Cx(k); Cy(k); Cz(k)],[Cx(l); Cy(l); Cz(l)],lcube,freq);
        
        for i = 1:3
            for j = 1:3
                L(i,k,j,l) = Ltemp(i,j);
                Lkl(:,:,k,l) = Ltemp;
            end
        end
    end
end

%L = reshape(L,3*numVox,3*numVox);



L  = [reshape(Lkl(1,1,:,:),numVox,numVox), reshape(Lkl(1,2,:,:),[numVox,numVox]), reshape(Lkl(1,3,:,:),[numVox,numVox]);
       reshape(Lkl(2,1,:,:),[numVox,numVox]), reshape(Lkl(2,2,:,:),[numVox,numVox]), reshape(Lkl(2,3,:,:),[numVox,numVox]);
       reshape(Lkl(3,1,:,:),[numVox,numVox]), reshape(Lkl(3,2,:,:),[numVox,numVox]), reshape(Lkl(3,3,:,:),[numVox,numVox])];





% Solve for P
epsilon_r=60;                    %Relative permittivity 
epsilon_0=8.854187e-12;
epsilon_b=1;
chi_e=epsilon_r/epsilon_b-1;               %Electric susceptibility 

chi_ee=ones(1,numVox)*chi_e;
Xe=diag(chi_ee);
X_e1=[Xe;zeros(numVox,numVox);zeros(numVox,numVox)];
X_e2=[zeros(numVox,numVox);Xe;zeros(numVox,numVox)];
X_e3=[zeros(numVox,numVox);zeros(numVox,numVox);Xe];
X_e=horzcat(X_e1,X_e2,X_e3);
e=[ones(1,numVox) zeros(1,numVox) zeros(1,numVox)]';

lhs = epsilon_b.*X_e*e;
rhs = (eye(3*numVox)+1/3.*X_e-X_e*L);
P = linsolve(rhs,lhs);
P = reshape(P,numVox,3);
%
figure(2)
q = quiver3(Cx',Cy',Cz',P(:,1),P(:,2),P(:,3));
title('Old Linear Solve')
daspect([1 1 1])
hold on
%scatter3(Cxx',Cyy',Czz');
camproj('orthographic')
xlim([0 1]);
ylim([0 1]);
zlim([0 1]);
q.Color = 'red';
q.AutoScale = 'on';
q.AlignVertexCenters = 'off';
q.AutoScaleFactor = 1;
q.LineWidth = 2;
q.MaxHeadSize = 50;
xlabel('X')
ylabel('Y')
zlabel('Z')
radius = (3/(4*pi)*(Lx/2)^3) ^(1/3);
%axis([0 Lx 0 Ly 0 Lz],'equal')
% hold on
% %[x,y,z] = sphere(20);
% %surf(radius*x+Lx/2,radius*y+Ly/2,radius*z+Lz/2+lcube/4,'FaceAlpha',0.5,'LineStyle',':','FaceColor',[1 0.27 0])
% for k = 1 : numVox
%     plotcube([2*radius/Nx,2*radius/Nx,2*radius/Nx],[Cx(k)-radius/Nx,Cy(k)-radius/Nx,Cz(k)-radius/Nx],0.5,[1 0 0])
% end
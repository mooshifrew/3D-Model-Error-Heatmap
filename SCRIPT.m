clc; clear;
%
% This script requires the user to manually input file1, file2, and
% f2Transformation
% NOTE: scanTransformation is applied to file2

file1 = '<INSERT FILENAME 1>.stl';
file2 = '<INSERT FILENAME 2>.stl';
f2Transformation = [  1 0 0 0
                      0 1 0 0 
                      0 0 1 0
                      0 0 0 1 ];

                    
% Mesh1 = stl model stored in file1 (triangulation object)
% n1    = normal vectors for each triangle in Mesh1
% Mesh2 = stl model stored in file2 (triangulation object)
[Mesh1, n1, Mesh2] = ImportFiles(file1, file2, f2Transformation);

% residuals1 = residual values per triangle in Mesh1 
% residuals2 = residual values per traingle in Mesh2 
% distances1 = minimum distances from triangle centers in Mesh1 to surface
%              of Mesh2
% distances2 = minimum distances from triangle centers in Mesh2 to surface
%              of Mesh1
[residuals1, residuals2] = rDistances(Mesh1, n1, Mesh2);
[distances1] = -point2trimesh('Faces', Mesh2.ConnectivityList, 'Vertices', Mesh2.Points, 'QueryPoints', incenter(Mesh1), 'Algorithm', 'parallel');
[distances2] =  point2trimesh('Faces', Mesh1.ConnectivityList, 'Vertices', Mesh1.Points, 'QueryPoints', incenter(Mesh2), 'Algorithm', 'parallel'); 


disp('RMSE of:')
rmse = RMSE(residuals1);
disp("   Residuals Mesh1:  " + rmse + " ")
rmse = RMSE(residuals2);
disp("   Residuals Mesh2:  " + rmse + " ")
rmse = RMSE(distances1);
disp("   Distances 1:      " + rmse + " ")
rmse = RMSE(distances2);
disp("   Distances 2:      " + rmse + " ")


figure('name', 'Residuals Mesh1')
trisurf(Mesh1, residuals1,'linestyle', 'none')
axis equal
title('Residuals Mesh1')
colorbar

figure('name','Residuals Mesh2')
trisurf(Mesh2, residuals2,'linestyle', 'none')
axis equal
title('Residuals Mesh2')
colorbar

figure('name', 'Distances 1')
trisurf(Mesh1, distances1, 'linestyle', 'none')
axis equal
title('Distances 1')
colorbar

figure('name', 'Distances 2') 
trisurf(Mesh2, distances2,'linestyle', 'none');
axis equal
title('Distances 2')
colorbar


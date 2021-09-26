function [Mesh1, n1, Mesh2] = ImportFiles(f1, f2, f2Transformation)
% Inputs:
%     f1 = file 1 string (must end with .stl)
%     f2 = file 2 string (must end with .stl)
%     f2Transformation = 4x4 transformation matrix that will be applied to
%     Mesh2 so it is aligned with Mesh1
% 
% Outputs:
%     Mesh1 = stl model stored in f1 (triangulation object)
%     n1    = normal vectors for each triangle in Mesh1
%     Mesh2 = stl model stored in f2 (triangulation object)
%
% STL_Import() is used so that normal vectors can be imported easily
[p1, t1, n1] = STL_Import(f1,1);
[p2, t2, n2] = STL_Import(f2,1);

% points in p2 must be transformed before mesh is created
p2 = [p2 ones(1,size(p2, 1))']';
p2 = f2Transformation*p2;
p2 = p2';
p2(:,4) = [];

% Mesh 1 and 2 can now be created
Mesh1 = triangulation(t1, p1);
Mesh2 = triangulation(t2, p2);                              
end 
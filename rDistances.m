function [residuals1, residuals2] = rDistances(Mesh1,n1, Mesh2)
% This function is based on the method described in:
% Using additive manufacturing inaccuracy evaluation of reconstructions from 
% computed tomography
% DOI: 10.1177/0954411912474612
%
% Inputs:
%      Mesh1 = the base mesh that is taken as 'ground truth'
%      n1 = mesh 1 normals
%      Mesh2 = the mesh to be checked against Mesh1
% Outputs:
%     residuals1 = residual values per triangle in Mesh1 
%     residuals2 = residual values per traingle in Mesh2 

% p1 holds all points in Mesh1
% t1 holds the connectivity list of Mesh1
% p2 holds all triangle centers of Mesh2 - they will be checked for error 
% Mesh1Centers holds all triangle centers of triangle 1 (composed of p1, n1, t1)
p1 = Mesh1.Points;
t1 = Mesh1.ConnectivityList;
p2 = incenter(Mesh2);
Mesh1Centers = incenter(triangulation(t1, p1));

% K(i) holds the index of the closest point to p2(i) in Mesh1Centers
% dist(i) holds the distance from p2(i) to Mesh1Centers(K(i))
[K, dist] = dsearchn(Mesh1Centers, p2);

% Create a list of centers the same size as p2 so that centerList(i) is the
% closest triangle center to p2(i) - allows for vectorized code
% center2ScanPoints holds the vectors from each closest triangle center to
% the corresponding point
centerList = Mesh1Centers(K,:);
center2ScanPoints = p2-centerList; 

% Creat a list of normals the same size as p2 so that normalList(i) is the
% normal vector of the triangle closest to point p2(i)
normalList = n1(K,:);

% residuals2 holds the residual for each point which is the projection of
% the vector center2ScanPoints(i) onto normalList(i)
residuals2 = dot(normalList, center2ScanPoints,2);
residuals2 = residuals2./dist;

% resByTriangle is in intermediate variable for calculating residuals1
% Column 1 stores the sum of residual values per triangle in Mesh1 
% Column 2 stores the number of residuals that are added in column 1 so
% that the average can be calculated
resByTriangle = zeros(size(Mesh1Centers,1), 2);
for i = 1:size(K,1)
    resByTriangle(K(i),1) = resByTriangle(K(i),1)+residuals2(i);
    resByTriangle(K(i),2) = resByTriangle(K(i),2)+1;
end

% residuals1 is the average residual value per each triangle in Mesh1
% If the triangle was not closest to any point in Mesh2, the value is set
% to 0
residuals1 = resByTriangle(:,1)./resByTriangle(:,2);
residuals1(isnan(residuals1)) = 0;

end 
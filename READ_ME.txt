This program takes two stl files (file1 and file2) and calculates the error
of file2 when compared with file1. The files that must be present in this 
folder are: 
    - SCRIPT.m
    - rDistances.m
    - ImportFiles.m
    - STL_Import.m
    - point2trimesh.m
    - RMSE.m
    - <File 1>.stl (manually added)
    - <File 2>.stl (manually added)

SCRIPT.m must be edited before running. This involves 3 steps:
    1. <INSERT FILENAME 1>.stl must be replaced with the appropriate filename
    2. <INSERT FILENAME 2>.stl must be replaced with the appropriate filename
    3. f2Transformation must be filled with a transformation matrix that will 
       align Mesh2 with Mesh1. This transformation matrix can be found using 
        Meshlab:
        a) In Meshlab, select File->Import Mesh and import file1 then file2
        b) Open the Align tool, select Mesh 1, then click 'Glue Here Mesh'
        c) Select the second Mesh and press 'point based glueing'
        d) Select at least 3 matching points on each model then 'ok'
        e) click 'Process'. If the models are not overlapping, repeat a-d
        f) Select File->Save Project As (Ctrl+S) and change the filetype to 
           Align Project (*.aln)
        g) Open the .aln file, copy the 4x4 matrix under <File 2>.stl, and paste 
           this matrix into the variable f2Transformation 

The program will display 4 figures from the variables residuals1, residuals2
distances1, and distances2. These values are briefly explained in SCRIPT.m 
and more details can be found in their respective function files (Residuals
in rDistances.m and Distances in point2trimesh.m).

The Root Mean Square of these values is also calculated and displayed for
each array.
    `
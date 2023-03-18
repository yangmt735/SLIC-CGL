function [ cdata ] = read_cifti( filename, wb_command )
%READ_CIFTI Import dscalar.nii files into Matlab
%   CDATA = READ_CIFTI(FILENAME, WB_COMMAND) reads the file given as
%   FILENAME using the native wb_command program, the path of which is
%   given either as a string in WB_COMMAND or specified below as default.

if nargin == 1
    wb_command = 'H:\bjbcd\keyan\workbench-windows64-v1.5.0\workbench\bin_windows64\wb_command';
    % Please set this to the path "wb_command" exe has been extracted to. D:\Program-Files\workbench\bin_windows64/wb_command
end

cii = ciftiopen(filename, wb_command);  
cdata = cii.cdata;

end


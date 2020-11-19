function [VarName1, Area, StdDev, Min, Max, XM, YM, BX, BY, Width, Height, Slice] = importfile_171120(filename, dataLines)
%IMPORTFILE Import data from a text file
%  [VARNAME1, AREA, STDDEV, MIN, MAX, XM, YM, BX, BY, WIDTH, HEIGHT,
%  SLICE] = IMPORTFILE(FILENAME) reads data from text file FILENAME for
%  the default selection.  Returns the data as column vectors.
%
%  [VARNAME1, AREA, STDDEV, MIN, MAX, XM, YM, BX, BY, WIDTH, HEIGHT,
%  SLICE] = IMPORTFILE(FILE, DATALINES) reads data for the specified row
%  interval(s) of text file FILENAME. Specify DATALINES as a positive
%  scalar integer or a N-by-2 array of positive scalar integers for
%  dis-contiguous row intervals.
%
%  Example:
%  [VarName1, Area, StdDev, Min, Max, XM, YM, BX, BY, Width, Height, Slice] = importfile("D:\Data\Raw\20.11.17\Deptho_M450-4_Results.txt", [2, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 17-Nov-2020 12:54:41

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [2, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 12);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = "\t";

% Specify column names and types
opts.VariableNames = ["VarName1", "Area", "StdDev", "Min", "Max", "XM", "YM", "BX", "BY", "Width", "Height", "Slice"];
opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
tbl = readtable(filename, opts);

%% Convert to output type
VarName1 = tbl.VarName1;
Area = tbl.Area;
StdDev = tbl.StdDev;
Min = tbl.Min;
Max = tbl.Max;
XM = tbl.XM;
YM = tbl.YM;
BX = tbl.BX;
BY = tbl.BY;
Width = tbl.Width;
Height = tbl.Height;
Slice = tbl.Slice;
end
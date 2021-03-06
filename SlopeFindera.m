% SlopeFinder
%
% use: [out]=getstrain_lsq2(y,u)
%
% Calculates the strain for a given displacement field in the x-direction
% (u) as a function of vertical distance(y) 
%
% y and u are both one-dimensional arrays 
%
% This function is just like getstrain_5pt, except it does a 2 point least
% squares fit on the first point (i.e., a forward difference calculation), a 
% three point least squares fit on the second point, and a three point least 
% squares fit on the (n-1)th point.  The strain at the other n-4 points is
% calculated via a five point least squares fit. 
% 
% Unlike getstrain_lsq, this function can successfully deal with data with
% NaNs
%
function slope = SlopeFindera(y,u)
slope=double(zeros(length(y),1));
isok =~isnan(u);                % boolean array of points with values
points = find(isok);    % array of locations with values

% Set slope for points with NaN as NaN
slope(~points) = NaN;

% Find slope of first and last point with forward and backward finite
% differences
if length(points)>1
    slope(points(1)) = diff(u(points(1:2)))./diff(y(points(1:2)));
    slope(points(end)) = diff(u(points(end-1:end)))./diff(y(points(end-1:end)));
end

% Find slope of the rest of the points using centered finite differences
for i = 2:length(points)-1
    slope((points(i))) = diff(u(points(i-1:2:i+1)))./diff(y(points(i-1:2:i+1)));
end



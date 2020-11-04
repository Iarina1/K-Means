function [cost] = compute_cost_pc(points, centroids)
  [N, D] = size(points);
  [NC, D] = size(centroids);
  cost = 0;
  for i =1:N
    for j =1:NC
      sum = 0;
      for k =1:D
        sum = sum + (points(i,k) - centroids(j,k)) * (points(i,k) - centroids(j,k));
      endfor
      dist(j) = sqrt(sum);
    endfor
    [dmin] = min(dist);
    cost = cost + dmin;
  endfor
endfunction


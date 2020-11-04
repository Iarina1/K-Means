function [centroids] = clustering_pc(points,NC)
  [n, d] = size(points);
  centroids = [];
  clusters = [];
  % size_clusters retine lungimea curenta a fiecarei linii din clusters
  size_clusters = n / NC;
  % creez clusterele 
  for i =1:NC
    clusters = [clusters; points(i:NC:n,1:d)'];
  endfor
  % creez primii centroids
  centroids_init = sum(clusters');
  centroids_init(1:d*NC) = centroids_init(1:d*NC) ./ size_clusters;
  % pasii 2,3,4
  egal = 0;
  while egal == 0
    egal = 1;
    % fac grupurile
    groups = [centroids_init'];
    groups = [groups, zeros(NC*d,n/NC)];
    size_groups(1:NC*d,1) = 1;
    for i =1:n % pt fiecare pct
      k = 0;
      for j=1:d:NC*d
        k = k + 1;
        gr = [groups(j:j+d-1,1)'];        
        dist(k) = norm(gr - points(i,1:d));
      endfor
      [dmin, imin] = min(dist);
      size_groups((imin-1)*d+1:imin*d) = size_groups((imin-1)*d+1:imin*d) .+ 1;
      groups((imin-1)*d+1:imin*d,size_groups((imin-1)*d+1)) = points(i,1:d)';
    endfor
    % fac centroids
    centroids_final = sum(groups');
    centroids_final(1:NC*d) = centroids_final(1:NC*d) - groups(1:NC*d,1)';
    centroids_final(1:d*NC) = centroids_final(1:d*NC) ./ (size_groups(1:d*NC)' .- 1);
    if norm(centroids_init - centroids_final) > 1e-6
        egal = 0;
    endif
    if egal == 0
      centroids_init = [centroids_final];
    endif
  endwhile
  for i =1:d:NC*d
    centroids = [centroids, centroids_final(i:i+d-1)'];  
  endfor
  centroids = centroids';
endfunction
function p=plot_ellipsoid(v,data)
    x=data(:,1);
    y=data(:,2);
    z=data(:,3);
    mind = min( [ x y z ] );
    maxd = max( [ x y z ] );
    nsteps = 100;
    step = ( maxd - mind ) / nsteps;
    [ x, y, z ] = meshgrid( linspace( mind(1) - step(1), maxd(1) + step(1), nsteps ), linspace( mind(2) - step(2), maxd(2) + step(2), nsteps ), linspace( mind(3) - step(3), maxd(3) + step(3), nsteps ) );
    model_polt = v(1) *x.*x +   v(2) * y.*y + v(3) * z.*z + ...
              2*v(4) *x.*y + 2*v(5)*x.*z + 2*v(6) * y.*z + ...
              2*v(7) *x    + 2*v(8)*y    + 2*v(9) * z+v(10);
    p = patch(isosurface( x, y, z, model_polt, 0 ) );
    hold on;
    set( p, 'FaceColor', 'g', 'EdgeColor', 'none' );
    view( 40, 40 );
    axis vis3d equal;
    camlight;
    lighting phong;
    alpha(0.6);
end
x=linspace(-3, 2, 100);
y=linspace(0, 2, 100);
[X,Y]=meshgrid(x,y);
plot3(X,Y,(X+Y)*sin(X));

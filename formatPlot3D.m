function formatPlot3D(plotTitle)
axis equal
grid on
view(45, 30)

xlim([-1.2 1.2])
ylim([-1.2 1.2])
zlim([-1.2 1.2])

xlabel('X')
ylabel('Y')
zlabel('Z')

title(plotTitle)
axis([0 3 0 3]);
plot([0 0 0 0],[0:3],'k-');
hold on;
plot([1 1 1 1],[0:3],'k-');
plot([2 2 2 2 ],[0:3],'k-');
plot([3 3 3 3 ],[0:3],'k-');
plot([0:3],[0 0 0 0],'k-');
plot([0:3],[2 2 2 2 ],'k-');
plot([0:3],[3 3 3 3],'k-');
plot([0:3],[1 1 1 1],'k-');
axis([1 3 1 3]);
p = plot(row,col,'or','MarkerSize',5,'MarkerFaceColor','r');
grid on;
pause(1)
delete(p);
dsNumber = 2;
folderNames = {'brain','chest','retina'};
folderName = folderNames{dsNumber};
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
FigHandle = FigList(iFig);
FigHandle.set('units','normalized','outerposition',[0 0 1 1])
FigName   = num2str(get(FigHandle, 'Number')+ 20);
saveas(FigHandle, fullfile([cd '/' folderName], [FigName '.png']));
end
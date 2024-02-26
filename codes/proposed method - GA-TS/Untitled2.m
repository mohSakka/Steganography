%  Get all PDF files in the current folder
files = dir('D:\Rachis Projects\Stegnography\data\Our Data');
% Loop through each
for id = 3:length(files)
    % Get the file name (minus the extension)
    [~, f] = fileparts(files(id).name);
      % Convert to number
      num = (f);
      if ~isnan(num)
          % If numeric, rename
          movefile(files(id).name, num2str(id));
      end
end
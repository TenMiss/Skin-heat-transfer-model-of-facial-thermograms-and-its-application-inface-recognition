function I = reload_template(varargin)
% This function is to convert normalized images into mat file
% The M-file can
%            (1)read one image (indicate specific image via input)
%         or (2)read many images from an image folder (indicated by input)
% Input:
%        (1)If empty, load images from default folder
%     or (2)show the specific image/fold (pathname is necessary)
% 
% Output:
%         I -- image data. Its size is height*width by n, where n is the 
%              number of images 
%         height, width -- size of the image(s)
sig=0;
if nargin <=1
    if nargin==0
        pathname='C:\cap_tomodify\Template';     %%%%% default folder
        sig=1;
    else
        if ischar(varargin{1}) & exist(varargin{1},'dir')
            pathname=varargin{1};
            sig=1;
        elseif ischar(varargin{1}) & exist(varargin{1},'file')
            I=imread(varargin{1});
            I=double(I)/255;
            [height,width]=size(I);            
        else
            errordlg('Cannot find the file or the pathname is incorrect',...
                'read_image file')
            return
        end        
    end
else
    errordlg('There are too many inputs','read_image file')
	return
end
if sig==1
    cd (pathname);
    dir_struct = dir(pathname);
    %%% (1)name, (2)date, (3)bytes and (4) isdir
    [sorted_names,sorted_index]=sortrows({dir_struct.name}');
    a=[dir_struct.isdir];
    a(1:2)=[];             %%% Delete the dot dir
    sorted_names(1:2)=[]; 
    [n,m]=size(sorted_names);
    if any(a)==1
        errordlg('Not a valid file, because contain directory',...
            'read_image file')
        return
    end
    for i=5:n
        [pathstr,name,ext,versn] = fileparts(sorted_names{i});
        % Validate the Image-file
        s={'.bmp','.jpg','hdf','pcx','tiff','xwd'};
        b=strcmp(s,ext);
        if all(b==0) 
            errordlg('Not a valid file, because contain non-image files',...
                'read_image file')
            return
        end    
    end
    I=[];
    for i=1:n
        select_file=fullfile(pathname,sorted_names{i});
        A=imread(select_file);
        A=double(A)/255;
        I=cat(3,I,A);
    end
end
save('c:\cap_tomodify\Matlab\template.mat','I');
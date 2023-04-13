clear
load('D:\Data\rawImages\results\results.mat');
for i=2 : length(testResults)
    a=testResults(i).normalizedImages;
    figure,imshow(mat2gray(a))
    raw(i,:)=testResults(i).rawDataResults;
    bio(i,:)=testResults(i).bioDataResults;
    keyboard
    close all
end

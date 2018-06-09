function randomfor = train(images,masks)

for i=1:30
    features(((i-1)*8+1):(i*8),1:(size(image,1)*size(image,2)))=computeFeatures(cell2mat(images(i)));
end

end


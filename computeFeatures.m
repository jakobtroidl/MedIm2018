function [ features] = computeFeatures(image)

%image in doublewerte
imaged=double(image);

%gradienten in x- und y- Richtung
[FX,FY]=gradient(imaged);

%gradient magnitude und gradient direction
[Imgradmag,Imgraddir]=imgradient(imaged);

%Haar-Like Feature(1) berechnet auf dem Grauwertbild, Pixel spaltenweise
%abgespeichert, darum transformation in Matrix
hlimag=computeHaarLike(imaged);
hlimage=vec2mat(hlimag(1,:),size(imaged,1))';

%Haar-Like Feature(1) berechnet auf der Gradientenstärke, Pixel spaltenweise
%abgespeichert, darum transformation in Matrix
hlgra=computeHaarLike(Imgradmag);
hlgrad=vec2mat(hlgra(1,:),size(imaged,1))';

hilfsmat=repmat((1:size(imaged,1))',1,size(imaged,2));%Hilfsmatrix für y-Koordinaten
%feature-matrix: Matrizen in Zeilenvektoren umgespeichert. (Spaltenvektoren
%sind alle Features zu einem Pixel)
for i=1:size(imaged,1)
    features(1,((i-1)*size(imaged,2)+1):(i*size(imaged,2)))=imaged(i,:); %grau werte
    features(2,((i-1)*size(imaged,2)+1):(i*size(imaged,2)))=FX(i,:); %Gradient in x-Richtung
    features(3,((i-1)*size(imaged,2)+1):(i*size(imaged,2)))=FY(i,:); %Gradient in y-Richtung
    features(4,((i-1)*size(imaged,2)+1):(i*size(imaged,2)))=Imgradmag(i,:); %Gradientenstärke
    features(5,((i-1)*size(imaged,2)+1):(i*size(imaged,2)))=hlimage(i,:);%HL Feature des Grauwertbildes
    features(6,((i-1)*size(imaged,2)+1):(i*size(imaged,2)))=hlgrad(i,:);%HL Feature der Gradientenstärke    
    features(8,((i-1)*size(imaged,2)+1):(i*size(imaged,2)))=hilfsmat(i,:); %y-Koordinate des Pixels
end

features(7,:)=repmat(1:size(imaged,2),1,size(imaged,1)); %x-Koordinate des Pixels

end
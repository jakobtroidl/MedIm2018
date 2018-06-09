function [ features ] = computeFeatures(image)

%image in doublewerte
imaged=double(image);

%gradienten in x- und y- Richtung
[FX,FY]=gradient(imaged);

%gradient magnitude und gradient direction
[Imgradmag,Imgraddir]=imgradient(image);

%Haar-Like Feature berechnet auf dem Grauwertbild
hlimage=computeHaarLike(image);

%Haar-Like Feature berechnet auf der Gradientenstärke
hlgrad=computeHaarLike(Imgradmag);

hilfsmat=repmat((1:size(image,1))',1,size(image,2));%Hilfsmatrix für y-Koordinaten
%feature-matrix:
for i=1:size(image,1)
    features(1,((i-1)*size(image,2)+1):(i*size(image,2)))=image(i,:); %grau werte
    features(2,((i-1)*size(image,2)+1):(i*size(image,2)))=FX(i,:); %Gradient in x-Richtung
    features(3,((i-1)*size(image,2)+1):(i*size(image,2)))=FY(i,:); %Gradient in y-Richtung
    features(4,((i-1)*size(image,2)+1):(i*size(image,2)))=Imgradmag(i,:); %Gradientenstärke
    features(8,((i-1)*size(image,2)+1):(i*size(image,2)))=hilfsmat(i,:); %y-Koordinate des Pixels
end

features(5,:)=hlimage(1,:); %Haar-like Feature(1) des Grauwertbildes
features(6,:)=hlgrad(1,:); %Haar-like Feature(1) der Gradientenstärke
features(7,:)=repmat(1:size(image,2),1,size(image,1)); %x-Koordinate des Pixels
end


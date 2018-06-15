function [label,score,imagefeat] = predictsegmentation(rf,image)
imagefeat = computeFeatures(image); %Features von Image berechnen
[labelcell,score]=predict(rf,double(imagefeat)'); %Ausführung der matlab implementierten Funktion predict in der TreeBagger Klasse
label=cellfun(@str2num,labelcell);
end


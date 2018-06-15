function [label,score,imagefeat] = predictsegmentation(rf,image)
imagefeat = computeFeatures(image); %Features von Image berechnen
[labelcell,score]=predict(rf,double(imagefeat)'); %Ausf�hrung der matlab implementierten Funktion predict in der TreeBagger Klasse
label=cellfun(@str2num,labelcell);
end


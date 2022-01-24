% Stellar Motion - Part 2
% Instructions are in the task pane to the left. Complete and submit each task one at a time.
% 
% This code loads the data from the previous project.
load starData

%Task 1
[sHa,idx] = min(spectra); %calcul vitesses de toutes les étoiles
lambdaHa = lambda(idx);
z = lambdaHa/656.28 - 1;
speed = z*299792.458;

%Tasks 2 - 4
for v = 1:7
    s = spectra(:,v); %extraction spectres de toutes les étoiles

    if speed(v) <= 0
        loglog(lambda,s,"--") %faire graph log des étoiles en bleushift
    else
        loglog(lambda, s, "LineWidth",3) %faire graph log étoiles en redshift
    end
    hold on %on garde le graph ouvert pour mettre tous les graph sur le meme
end
hold off %on ferme  le graph

%Task 5
legend(starnames) %on ajoute une légende avce le nom des differentes étoiles

%Task 6
movaway = starnames(speed>0); %affiche le nom des étoiles en redshift



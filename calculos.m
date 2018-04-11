function [d,Y0] = calculos(ROE , desf) %desf viene en numero de longitudes de onda  

mod_r = (ROE-1)/(ROE+1) ;
r = mod_r * exp(-i*(4*pi*desf+pi)) ;

Zl = (1+r) / (1-r)  ; 

Yl = 1/Zl ; 

Y1 = 1 + i*(2 * mod_r/ sqrt(1-mod_r^2) ) ; 

Y0 = imag(Y1)  %Este es el valor del eje x de la tablita del libro

ryl = (1-Yl) / (1+Yl) ; 
ry1 = (1-Y1) / (1+Y1) ; 

d = ( angle(ryl) - angle(ry1) ) / (4*pi) %distancia en la que se ubica el tornillo, viene dado en numero de longitudes de onda


      




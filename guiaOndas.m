%% Leo los multimetros 
multV = visa('ni','USB0::0x1AB1::0x0C94::DM3O163050349::0::INSTR');
multR = visa('ni','USB0::0x1AB1::0x0C94::DM3O163050354::0::INSTR'); 
fopen(multR);
fopen(multV);

%% Leo el arduino con el puerto serial.
s = serial('/dev/tty.wchusbserial14120');
set(s,'DataBits',8);
set(s,'StopBits',1);
set(s,'BaudRate',9600);
set(s,'Parity','none');
fopen(s);

name = 'Nombre_de_archivo.csv';
 %% Loop de medicion de v y r 
 
 arch = fopen(name,'w');

 endRoad = 1060;
 r1 = 0;
 r2 = 23000 ;
 Ohm = 0.5 ;
 
fprintf(s,'%s','a\n');                                 % El carrito avanza


 while( r1 < endRoad )
     pause(0.005);
     fprintf(multR,'MEAS:RES?');
     r2 = str2num( fscanf(multR,'%s',1024) );
     
    if(abs(r1-r2) > Ohm)
         fprintf(s,'%s','s\n');                        % El carrito se detiene 
         pause(0.1);
         fprintf(multR,'MEAS:RES?');
         r2 = str2num( fscanf(multR,'%s',1024) );      % leo resistencia    
         fprintf(multV,'MEAS?');
         v = str2num( fscanf(multV,'%s',1024) );
         fprintf(arch,'%f,%f,\n',r2,v);
         r1 = r2 ;                                     % permite continuar con el while.
         fprintf(s,'%s','a\n');                        % El carrito avanza
    end
 end
 
fprintf(s,'%s','s\n');   % El carrito se detiene 
 
fclose(arch)

% fclose(multR)
% delete(multR)
% clear multR 
% 
% fclose(multV)
% delete(multV)
% clear multV

%clear (s) ;

data  = csvread(name);
R = data(:,1);
V = data(:,2);
plot(R,V)

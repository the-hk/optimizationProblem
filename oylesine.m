clc;
clear all;
x=[1,5];
totalLoad=0;
%% Modeling PV
irr=xlsread('irradiation.xlsx'); %solar irradiance %W/m^2
tamb=xlsread('ambient.xlsx');
wind=xlsread('windspeed.xlsx');
demand=xlsread('demand.xlsx');
Prated=x(1);   %rated power of PV "W"
alfat=-4*10^(-3);  %1/degreeCelcius
TC_STC=25;   %degree Celcius

for i=1:8760
    PPV_output(i)=(Prated.*irr(i)/1000).*(1+alfat.*((tamb(i)+0.0256.*irr(i))-TC_STC));
    %output power of PV "W"
end
pv_total = sum(PPV_output);

%% Modeling wind
Pr=x(2);  %W
Vcut_in=1; % cut in speed "m/s"
Vrated=10;  %rated speed  "m/s"
Vcut_out=25; %cut out speed "m/s)
for i=1:8760
    if (wind(i)<Vcut_in) || (wind(i)>Vcut_out)
        PWT(i)=0;
    elseif (wind(i)>=Vcut_in) && (wind(i)<Vrated)
        PWT(i)=((wind(i).^3).*(Pr/(Vrated.^3-Vcut_in.^3)))-(Pr.*(Vcut_in.^3/(Vrated.^3-Vcut_in.^3)));
    elseif  (wind(i)>=Vrated) && (wind(i)<=Vcut_out)
        PWT(i)=Pr; 
    end
end
wind_total = sum(PWT);
%% 
renewable_total = pv_total + wind_total;

%%
netload = totalLoad - renewable_total;
clc;
clear all;

year = '2013'

keySet =   [1:12];
valueSet = {'January','February','March','April','May','June','July','August','September','October','November','December'};
month = containers.Map(keySet,valueSet);

%% Historical Data Water (hydro + pumping)
water = [];
i = 1;
while i <= 12
    file_f = ['Generation_Produced_Historical_',year,'-',sprintf('%02d', i),'-',month(i),'.xls'];
    [num,txt,raw] = xlsread(file_f,6);
    water = [water; num(:,7:102)];
    i = i+1;
end

water(isnan(water)) = 0; 

E_water = sum(sum(water))*0.25 %Compensatie voor kwarturen

%% Historical Data Wind
wind = [];
i = 1;
while i <= 12
    file_f = ['Generation_Produced_Historical_',year,'-',sprintf('%02d', i),'-',month(i),'.xls'];
    [num,txt,raw] = xlsread(file_f,7);
    wind = [wind; num(:,7:102)];
    i = i+1;
end

wind(isnan(wind)) = 0; 

E_wind = sum(sum(wind))*0.25 %Compensatie voor kwarturen

%% Historical Data Total
total = [];
i = 1;
while i <= 12
    file_f = ['Generation_Produced_Historical_',year,'-',sprintf('%02d', i),'-',month(i),'.xls'];
    [num,txt,raw] = xlsread(file_f,1);
    total = [total; num(:,7:102)];
    i = i+1;
end

total(isnan(total)) = 0; 

E_total = sum(sum(total))*0.25 %Compensatie voor kwarturen

save(['Historical',year,'.mat'], 'water', 'E_water', 'wind', 'E_wind', 'total', 'E_total');
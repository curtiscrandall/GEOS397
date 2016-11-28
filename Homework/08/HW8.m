% Homework 08     Javier Colton & Curtis Crandall
%% Part 1

clc
clear all

allGPS

% Do the histograms make sense?
% The histograms do make sense. They have a degree of fit trends with the
% different movement directions. North has the best fit and Vertical has
% the least best fit. The stacked bar representation makes this easy to
% see.

% Is there anthing strage in the histograms?
% The only strange thing is how poorley fit the vertical moevement is
% compared to North and East

% Would it be usefull to change the histogram bin size?
% The bin size is almost reflective of the error size within the fit. Yes,
% the bins can visually represent the residual data.

% What kind of model represents the residual data?
% The residual data follos gausian distribution. 

%% Part 2

load('cavecreek.txt')
%caveCreekArray=importdata('cavecreek.txt');
timeArray=datetime(1953,10,01):calmonths(1):datetime(1971,09,30);

figure;
plot(timeArray,cavecreek,'k')
xlabel('Time [monthly]');
ylabel('Runoff [inches/100]');
title('Cave Creek Runoff');

% Why do we need t sort the data?
% This is becuase it is water year format. So, in order to plot in annual
% or chronological order, the data has to be in annual or chronological
% order.

timeArrayCol= transpose(cavecreek);
T = reshape(cavecreek,[12,18]);
Tnew = transpose(T);

h2=figure;
imagesc(Tnew)
c=colorbar;
colormap('jet')
xlabel('Time [month]');
ylabel('Time [year]');
title('Matrix Representation of Streamflow Data');
xticks = 1:2:12;
xticksLabels = {'Oct','Dec','Feb','Apr','Jun','Aug'};
set(gca,'xtick',xticks,'xticklabels',xticksLabels);
yticks = 2:2:18;
yticksLabels = {'1954','1956','1958','1960','1962','1964','1966','1968','1970'};
set(gca,'ytick',yticks,'yticklabels',yticksLabels);



meanArray = mean(Tnew,1);

medianArray = median(Tnew);

h3 = figure;

x = 1:12;
plot(x,meanArray,'*');
axis([0,13,0,500]);
hold on;
plot(x,medianArray,'o');
title('Median and Mean');
ylabel('Runoff [inches/100]')
xticks = 1:12;
xticksLabels = {'Oct','Nov','Dec','Jan','Feb','Mar','Apr','May','Jun','July','Aug','Sept'};
set(gca,'xtick',xticks,'xticklabels',xticksLabels);
legend('Mean','Median')

% Why do the mean and median not match?
% The mean is the average and the median is the middle sample value. They
% are completely different. They would only be the same if data was
% distributed the perfectly.

hold on
h4 = boxplot(Tnew);
set(gca,'xtick',xticks,'xticklabels',xticksLabels);
ylabel('Runoff [inches/100]');
title('Box and Whisker Plot');

% Explain information in boxplot.
% The box and whisker plot is just a visual representation of frequency or
% concentration, with the whiskers representing the extremes. The red
% indicators show outliers (abnormal values). In this data set, outliers
% could refer to a higher than normal water storage year, resulting in
% higher or lower streamflow numbers. The data representing streamflow
% numbers coresponds to what you would expect to see in a given water year;
% higher runoff numbers located in the Spring, when water is melting, when
% alternately water is frozen in the winter months, showing little to no
% streamflow.

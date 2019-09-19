close all;
M = importdata('FixationGroupResultsCSV.csv');

% subject = {'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H'};
% subject = categorical(subject);

subject = M(:,1);

RBX = M(:,2);
RBY = M(:,3);
BRX = M(:,4);
BRY = M(:,5);

figure; hold on
b = bar(subject, RBX , 0.4);
yline(1);
axis([0.5 8.5 0 10]);
xticklabels({'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' ''});
set(gca, 'YScale', 'log');
axis square;
xlabel('Subject');
ylabel('Fixation Amplitude/Calibration Amplitude');
xtips1 = b(1).XEndPoints(1:8);
ytips1 = b(1).YEndPoints(1:8);
labels1 = string(round(b(1).YData(1:8),2))
text(xtips1, ytips1, labels1, 'HorizontalAlignment', 'center',...
    'VerticalAlignment', 'bottom')


% figure; hold on;
% scatter(subject,RBX,'MarkerFaceColor', 'r')
% yline(1);
% axis([0.5 8.5 ylim]);
% set(gca, 'YScale', 'log');
% xticklabels({'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H'});
% yticks([0.214 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 1.1 1.2 1.3 1.4 1.5 2 3 4 5 6 7 8 9.13]);
% axis square;
% xlabel('Subject')
% ylabel('Fixation/Calibration Amplitude');

%{
figure; hold on;
scatter(subject,RBY,'MarkerFaceColor', 'r')
% yline(1);
axis square;
xlabel('Subject')
ylabel('Fixation/Calibration Amplitude');

figure; hold on;
scatter(subject,BRX,'MarkerFaceColor', 'r')
% yline(1);
axis square;
xlabel('Subject')
ylabel('Fixation/Calibration Amplitude');

figure; hold on;
scatter(subject,BRY,'MarkerFaceColor', 'r')
% yline(1);
axis square;
xlabel('Subject')
ylabel('Fixation/Calibration Amplitude');
%}
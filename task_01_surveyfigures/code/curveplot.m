function curveplot(datadir,datafile)

% makes curveplots of stats on survey

%datafile = '../data/Figure-04-a_Modeling experience of respondents - Split by modeler type.csv'

TT = readtable(fullfile(datadir,datafile));

AnswerVals = TT.Properties.VariableNames(2:end);


figure('Position',[379   435   893   420])

[Nrow,Ncol] = size(TT);

hh = plot([1:Ncol-1],TT{:,2:Ncol}','LineWidth',2); hold on

for j = 1:Nrow
    text(Ncol-1,TT{j,Ncol},[' ' TT.Subset{j}],'Color',get(hh(j),'Color'))
end

set(gca,'Xtick',(1:Ncol-1),'XtickLabel',AnswerVals)
Ylimold = get(gca,'Ylim');
Ylimnew = Ylimold + [-5 5];
set(gca,'Xlim',[0.5 Ncol],'Ylim',Ylimnew)
ylabel('% of responses')
grid on
ststart = strfind(datafile,'_')+1;
ststop = strfind(datafile,'.csv')-1;

title(datafile(ststart:ststop))
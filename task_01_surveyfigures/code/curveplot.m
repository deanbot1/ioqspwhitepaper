function curveplot(datadir,datafile,ignoreall,savefigs)


if nargin < 3
    ignoreall = 0
end

if nargin < 4
    savefigs = 0
end

TT = readtable(fullfile(datadir,datafile));

AnswerVals = TT.Properties.VariableNames(2:end);

if ignoreall
    TT = TT(find(~strcmpi(TT.Subset,'All respondents')),:);
end


figure('Position',[379   435   893   420])

[Nrow,Ncol] = size(TT);



for j = 1:Nrow
    hh = plot([1:Ncol-1],TT{j,2:Ncol}','LineWidth',3,'Color',cfun(TT.Subset{j})); hold on
    text(Ncol-1,TT{j,Ncol},[' ' TT.Subset{j}],'Color',get(hh,'Color'))
end

for k = 1:length(AnswerVals) % vincent wants spaces
        AnswerVals{k} = strrep(AnswerVals{k},'Contribution',' Contribution');
end

set(gca,'Xtick',(1:Ncol-1),'XtickLabel',AnswerVals)
if length(AnswerVals)==5
    set(gca,'XtickLabel',{'1(Least)','2','3','4','5(Most)'})
end
Ylimold = get(gca,'Ylim');
Ylimnew = Ylimold + [-5 5];
set(gca,'Xlim',[0.5 Ncol],'Ylim',Ylimnew)
ylabel('% respondents')
grid on
ststart = strfind(datafile,'_')+1;
ststop = strfind(datafile,'.csv')-1;

title(datafile(ststart:ststop))

if savefigs
%    print(['../out/' datafile(ststart:ststop) '.fig'],'-dpdf');
%    print(['../out/' datafile(ststart:ststop) '.png'],'-dpng');
%    print(['../out/' datafile(ststart:ststop) '.emf'],'-dmeta');
    savefig(['../out/' datafile(ststart:ststop) '.fig'])
end


function RGB = cfun(s)
persistent colordat
if isempty(colordat)
    colordat = readtable('./colorscheme.csv')
end
igood = find(strcmp(colordat.Thing,s));
RGB = [colordat.R(igood),colordat.G(igood),colordat.B(igood)]/255;
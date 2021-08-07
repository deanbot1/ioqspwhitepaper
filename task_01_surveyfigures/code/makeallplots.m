%% makeallplots makes all plots
clear all; close all
foo = dir('../data/*.csv')

for j = 1:length(foo)
    curveplot(foo(j).folder,foo(j).name,1);
end
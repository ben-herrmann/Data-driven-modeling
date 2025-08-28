clearvars; close all; clc;

A = [0 1; 1 -0.01];
B = [0;1];
C = A;
D = B;
sys = ss(A,B,C,D);
pzplot(sys)
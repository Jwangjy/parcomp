clear;
clc;

rng(2021) % Setting seed
g = 20;
tcon = zeros(g,1);

% Running iterations for conventional computing
for j = 1:g
    n = 1000000*(2/5)*j;
    y = zeros(n,1);
    tic
    for i = 1:n
        x = rand;
        y(i) = sin(3*x)+cos(pi*x)+((x^5)/5)+sqrt(x)*(acos(x))+8*x*exp(x);
    end
    yexp = sum(y);
    tcon(j) = toc;
end

%%
rng(2021) % Setting seed
g = 20;
tpar = zeros(g,1);

% Running iterations for parallel computing
for j = 1:g
    n = 1000000*(2/5)*j;
    y = zeros(n,1);
    tic
    parfor i = 1:n
        x = rand;
        y(i) = sin(3*x)+cos(pi*x)+((x^5)/5)+sqrt(x)*(acos(x))+8*x*exp(x);
    end
    yexp = sum(y);
    tpar(j) = toc;
end

%%
spar = zeros(g,1);
epar = zeros(g,1);

for i = 1:g
    spar(i) = tcon(i)/tpar(i);
end

for i = 1:g
    epar(i) = tcon(i)/tpar(i)/4;
end

ntest = zeros(g,1);

for i = 1:g
    ntest(i) = 1000000*(2/5)*i;
end

figure(1);
plot(ntest,spar);
hold on
plot(ntest,epar);
title 'Speedup and Efficiency against n';
legend('Speedup','Efficiency');
xlabel('n');
ylabel('Speedup / Efficiency');
hold off

% As we can see, parallel computing has speedup over conventional serial
% computing that generally increases with n. Efficiency also increases 
% with n. However, the efficiency is lower than 1 as there are transfer 
% costs between cores. Further, even with 4 cores, 
% speedup does not reach 4. 
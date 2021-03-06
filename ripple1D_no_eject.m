% this code is used simulate ripple 1D
% version 1: no eject rule
% by Hang Deng
% inpsired by Anderson, 1990, earth-science reviews

clear all
figure(1)
clf

%% initialize
% parameter used
D = 0.00020; % upper fine sand grain diameter
phi = 0.35; % porosity
rhog = 2600; % grain density 2.6*1000kg/m3
a = 10; % angle of impact
tana = 0.18; % impact angle is 10 degree, tangent(a) = 0.18
imprate = 10e7; % impact rate of grains per sec

% time step and space step
dx = 1;
xmax = 1000; % distance of simulation
x = 0:dx:xmax;
dt = 0.1;
tmax = 100; % simulate 1000s
t = 0:dt:tmax;

% random elevation for impact velocity, angle of velocity = tangent(a)
%zimp = 100*rand(1,length(t));
Vim = 2.5; % impact speed m/s
%Ahor = zimp/tana; % impact location, use same symbol from Anderson, 1993
%A = round(Ahor);

% creating arrays
% total elevation = initial elevation + grain elevation
%z = 0; % initial topography
%Z = z + H;
z = zeros(size(x));% z array is the elevation of grains, initial topography
% is zero.

% ejecta
%n = 2;
%N = tmax*0.1*10e7*xmax*D; % number of impacts modeled
%Vej = 0.1*Vim; % ejection speed m/s
%tanb = 1.19 % ejecta angle 50 degree

% initial topography is set to be flat

% plotting
nplots = 50;
tplot = tmax/nplots;

%% simulating
for i = 1:length(t)
    zimp(i) = 100*rand;
    A = round(zimp(i)/tana);
    
    % inpterpolate H to cell edges
    %Hedge = H(1:end-1)+0.5*diff(H);
    %Hedge = [Hedge 0];
    
    % z = (3.14*imprate*D^2)/(4*(1-0.35)*dx);
    % dQdx = (rhog/4)*3.14*D^2*imprate/dx;
    % flux calculation
    find(A==0) = 1; %#ok<SAGROW>
    % elevation update
    z(A) = z(A) + (3.14*imprate*dt*D^2)/(4*(1-phi)*dx)
    
    
    if rem(t(i),tplot)==0
        disp(['Time: ' num2str(t(i))]);
        figure(1)
        plot(x,z,'r','linewidth',1);
        hold on
        %plot(t,zimp,'g--','linewidth',1);
        xlabel('Distance [m]','Fontsize',12)
        ylabel('Elevation [m]','Fontsize',12)
        ylim([0 10]);
        xlim([0 100/tana]);
        legend('Ripple height');
        %M(:,nframe) = getframe(gcf);
        pause(0.02)  
        hold off

    end
    
end

%% plotting figure 2
figure(2);
plot(t,zimp,'g--','linewidth',1);
xlabel('Time [sec]','Fontsize',12)
ylabel('Elevation [m]','Fontsize',12)
legend('grain gun position at source point (x=0)');
format long;    %Mi serve per mantenere un buon numero di cifre significative
clc, clearvars, close all;  %Chiudo tutto ciò che potrebbe essere rimasto 
%e cancello le vecchie variabili salvate in memoria.

% Parametri iniziali    (Caso generale tesi)
G = 6.67*10^-11;  % Costante gravitazionale
m1 ; m2 ; m3 ;  % Masse dei tre corpi

% Posizioni iniziali [x; y]
r1 = [r1x; r1y];
r2 = [r2x; r2y];
r3 = [r3x; r3y];

% Velocità iniziali [vx; vy]
v1 = [v1x; v1y];
v2 = [v2x; v2y];
v3 = [v3x; v3y];

t=0; %tempo inizializzato a 0
t_end = 500;%tempo finale
dt = 0.0005; % Passo iniziale
tol = 1e-6; % Tolleranza per l'errore

%Mi salvo le velocità iniziali per il plot successivo
v1_0=v1;
v2_0=v2;
v3_0=v3;

%Inizializzo i vettori che userò per il plot con coordinata x e y
%Dopo ogni iterazione mi salvo tutti i risultati in questi vettori
%Inserisco subito i valori iniziali così da averli pronti insieme agli altri alla fine
r1_x_vals=[r1(1)];
r1_y_vals=[r1(2)];

r2_x_vals=[r2(1)];
r2_y_vals=[r2(2)];

r3_x_vals=[r3(1)];
r3_y_vals=[r3(2)];

%Inizializzo i vettori in cui conserverò l'energia totale dei singoli corpi e dell'intero sistema a tre corpi
E1=[Energia(1, m1, m2, m3, r1, r2, r3, v1, v2, v3, G)];
E2=[Energia(2, m1, m2, m3, r1, r2, r3, v1, v2, v3, G)];
E3=[Energia(3, m1, m2, m3, r1, r2, r3, v1, v2, v3, G)];
E_tot=[Energia_Totale(m1, m2, m3, r1, r2, r3, v1, v2, v3, G)];

%Inizializzo il vettore in cui inserire tutti gli istanti discreti di tempo t
t_vec=[0];

while t<t_end       %ripeto le iterazioni finchè non arrivo al tempo finale scelto
    if t + dt > t_end
        dt = t_end - t; % Adatta l'ultimo passo se necessario
    end
    %Inizializzo i vettori in cui inserire i risultati delle singole iterazioni (sia per velocità che per posizioni)
    v1_next=[];
    v2_next=[];
    v3_next=[];
    r1_next=[];
    r2_next=[];
    r3_next=[];
    dt_new=[];
    
    %richiamo le funzioni che mi calcolano le velocità successive con il metodo di RKF45 con una singola iterazione
    [v1_next(1), dt_new(1)]=RKF_velocita(v1, 1, 'x', r1, r2, r3, m1, m2, m3, G, dt, tol);
    [v1_next(2), dt_new(2)]=RKF_velocita(v1, 1, 'y', r1, r2, r3, m1, m2, m3, G, dt, tol);
    
    [v2_next(1), dt_new(3)]=RKF_velocita(v2, 2, 'x', r1, r2, r3, m1, m2, m3, G, dt, tol);
    [v2_next(2), dt_new(4)]=RKF_velocita(v2, 2, 'y', r1, r2, r3, m1, m2, m3, G, dt, tol);
    
    [v3_next(1), dt_new(5)]=RKF_velocita(v3, 3, 'x', r1, r2, r3, m1, m2, m3, G, dt, tol);
    [v3_next(2), dt_new(6)]=RKF_velocita(v3, 3, 'y', r1, r2, r3, m1, m2, m3, G, dt, tol);
    
    %faccio lo stesso per le posizioni
    [r1_next(1), dt_new(7)]=RKF_posizione(r1, 1, 'x', v1, dt, tol);
    [r1_next(2), dt_new(8)]=RKF_posizione(r1, 1, 'y', v1, dt, tol);
    
    [r2_next(1), dt_new(9)]=RKF_posizione(r2, 2, 'x', v2, dt, tol);
    [r2_next(2), dt_new(10)]=RKF_posizione(r2, 2, 'y', v2, dt, tol);
    
    [r3_next(1), dt_new(11)]=RKF_posizione(r3, 3, 'x', v3, dt, tol);
    [r3_next(2), dt_new(12)]=RKF_posizione(r3, 3, 'y', v3, dt, tol);

    %Faccio l'iterazione 12 volte, cioè per ogni equazione del primo ordine scalare che ottengo dal problema iniziale (quindi componente per componente)
    %Ogni funzione mi ritorna sia il valore successivo sia il il nuovo passo (il passo è adattivo)

    %Inserisco i valori successivi nelle variabili iniziali (alle funzioni mando ri e vi) così da ripere le iterazioni
    v1=v1_next;
    v2=v2_next;
    v3=v3_next;
    
    r1=r1_next;
    r2=r2_next;
    r3=r3_next;
   
    %Con i nuovi valori di posizioni e velocità mi calcolo le nuove energie e le inserisco nei vettori precedentemente inizializzati
    E1(end+1)=Energia(1, m1, m2, m3, r1, r2, r3, v1, v2, v3, G);
    E2(end+1)=Energia(2, m1, m2, m3, r1, r2, r3, v1, v2, v3, G);
    E3(end+1)=Energia(3, m1, m2, m3, r1, r2, r3, v1, v2, v3, G);
    E_tot(end+1)=Energia_Totale(m1, m2, m3, r1, r2, r3, v1, v2, v3, G);

    %Aggiorno anche il vettore discreto del tempo
    t_vec(end+1)=t+dt;

    %Aggiungo i valori ottenuti nel vettore totale che userò dopo per il
    %plot
    r1_x_vals(end+1)=r1(1);
    r1_y_vals(end+1)=r1(2);

    r2_x_vals(end+1)=r2(1);
    r2_y_vals(end+1)=r2(2);
    
    r3_x_vals(end+1)=r3(1);
    r3_y_vals(end+1)=r3(2);
    
    t=t+dt;     %faccio avanzare il tempo
    dt=min(dt_new);     %ogni funzione mi ritorna il passo riadattato.
    %Tra tutti i 12 che vengo ritornati prendo il più piccolo per la prossima iterazione
end

%Apro la finestra e plotto
%Prima plotto i punti iniziali con un punto '.' per mostrare da dove parte ogni corpo
figure (1);
axis equal;
hold on;
plot(r1_x_vals(1), r1_y_vals(1), '.r', 'MarkerSize', 40);
hold on;
plot(r2_x_vals(1), r2_y_vals(1), '.g', 'MarkerSize', 40);
hold on;
plot(r3_x_vals(1), r3_y_vals(1), '.b', 'MarkerSize', 40);
hold on;

%Plotto le velocità iniziali come vettori per visualizzare dove il corpo dovrebbe andare
quiver(r1_x_vals(1), r1_y_vals(1), v1_0(1), v1_0(2), 7, LineWidth=1.5, Color='black');
hold on;
quiver(r2_x_vals(1), r2_y_vals(1), v2_0(1), v2_0(2), 7, LineWidth=1.5, Color='black');
hold on;
quiver(r3_x_vals(1), r3_y_vals(1), v3_0(1), v3_0(2), 7, LineWidth=1.5, Color='black');
hold on;

%Dopo plotto i 3 corpi con tutte le posizioni occupate nell'intero processo
plot(r1_x_vals, r1_y_vals, 'r', 'LineWidth', 1.5);
hold on;
plot(r2_x_vals, r2_y_vals, 'g', 'LineWidth', 1.5);
hold on;
plot(r3_x_vals, r3_y_vals, 'b', 'LineWidth', 1.5);
grid on;
legend('','','','','','','m1','m2','m3');

%Metto il nome agli assi e il titolo al plot
xlabel('x [m]');
ylabel('y [m]');
title('Il problema dei tre corpi risolto con il metodo di RKF45');

%Plotto l'energia meccanica totale in un'altra finestra
figure (2);
plot(t_vec, E_tot, 'LineWidth', 1.5);

%Mi salvo energia iniziale e finale per calcolare l'errore
E_tot_0=E_tot(1);
E_tot_max=E_tot(end);
delta_y=abs(E_tot_max-E_tot_0)/10;
delta_y_label=-delta_y/E_tot_0*100;
grid on;

%Calcolo le tacche verticali (10) da inserire nel grafico con gli errori percentuali
y_ticks_values = E_tot_0:delta_y:E_tot_max;
y_ticks_char = strcat('+',string( round(delta_y_label*(0:numel(y_ticks_values)-1),2)),'%');
yticks(y_ticks_values);
yticklabels(y_ticks_char);

%Metto il nome agli assi e il titolo al plot
xlabel('Tempo [s]');
ylabel('Energia meccanica [J]');
title('Grafico dell energia meccanica totale del sistema al variare del tempo');

%Plotto le energie meccaniche dei singoli corpi
figure(3);
plot(t_vec, E1, 'r', 'LineWidth', 1.5);
hold on;
plot(t_vec, E2, 'g', 'LineWidth', 1.5);
hold on;
plot(t_vec, E3, 'b', 'LineWidth', 1.5);
grid on;

%Metto il nome agli assi e il titolo al plot
legend(["m1","m2","m3"]);
xlabel('Tempo [s]');
ylabel('Energia meccanica [J]');
title('Grafico dell energia meccanica dei tre corpi al variare del tempo');


%Con questa funzione trovo la velocità successiva (fa solo un'iterazione)
function [v_next_cappuccio,dt_new]=RKF_velocita(v, ind, componente, r1, r2, r3, m1, m2, m3, G, dt, tol)
    
    %In input dò v che è un vettore, ma uso solo una delle sue 2 componenti
    %Questo if mi serve per capire quale delle 2 grazie alla variabile "componente" in input
    if componente == 'x'
        comp=1;
    elseif componente =='y'
        comp=2;
    end

    %coefficienti RKF45
    a=[0 , 0.25, 3/8, 12/13, 1.0, 0.5]; %non verranno usati ma per completezza sono stati messi
    
    b=zeros(6);
    b(2,1)=0.25;
    b(3,1)=3/32; b(3,2)=9/32;
    b(4,1)=1932/2197; b(4,2)=-7200/2197; b(4,3)=7296/2197;
    b(5,1)=439/216; b(5,2)=-8; b(5,3)= 3680/513; b(5,4)=-845/4104;
    b(6,1)=-8/27; b(6,2)=2; b(6,3)=-3544/2565; b(6,4)= 1859/4104; b(6,5)=-11/40;
    
    gamma_cappuccio=[16/135, 0, 6656/12825, 28561/56430, -9/50, 2/55];
    gamma=[25/216, 0, 1408/2565, 2197/4104, -1/5, 0];
    c=[1/360, 0, -128/4275, -2197/75240, 1/50, 2/55];
    %Ci sono tutti i coefficienti con la stessa notazione usata nell'Atkinson
    
    % Stima RKF45
    %Mi calcolo i coefficienti k nello stesso modo in cui vengono calcolati nel libro
    k=[];
    k(1) = accelerazione(ind, componente, r1, r2, r3, m1, m2, m3, G);
    for j=2:6
        sum=0;
        for i=1:j-1
            sum=sum+b(j,i)*k(i);
        end
        sum=sum*dt;
        k(j)=accelerazione(ind, componente, r1+sum, r2+sum, r3+sum, m1, m2, m3, G);
    end
    
    %Calcolo v_next di ordine 4
    v_next=v(comp);
    for i=1:5
        v_next=v_next+dt*gamma(i)*k(i);
    end
    
    %E v_next di ordine 5
    v_next_cappuccio=v(comp);
    for i=1:6
        v_next_cappuccio=v_next_cappuccio+ dt*gamma_cappuccio(i)*k(i);
    end
    
    %Stimo l'errore
    error=abs(v_next_cappuccio-v_next);

    %Riadatto il passo
    if error > tol
        % Riduci il passo
        dt_new = dt * 0.9 * (tol / error)^(1/4);
    else
        % Accetta la soluzione e mantieni il passo
        dt_new=dt;
    end
end

%Funzione che mi calcola l'accelerazione di gravità date le distanze e masse
function value=accelerazione(i, componente, r1, r2, r3, m1, m2, m3, G)

    %Anche quì mi serve solo una delle componenti
    if componente == 'x'
        j=1;
    elseif componente =='y'
        j=2;
    end
    switch i
        case 1
            value=G*((m2*(r2(j)-r1(j))/((norm(r2-r1))^3))+ (m3*(r3(j)-r1(j))/((norm(r3-r1))^3)));
        case 2
            value=G*((m1*(r1(j)-r2(j))/((norm(r1-r2))^3))+ (m3*(r3(j)-r2(j))/((norm(r3-r2))^3)));
        case 3
            value=G*((m1*(r1(j)-r3(j))/((norm(r1-r3))^3))+ (m2*(r2(j)-r3(j))/((norm(r2-r3))^3)));
    end
end

%Calcolo la posizione successiva nello stesso modo in cui ho calcolato la velocità successiva
function [r_next_cappuccio,dt_new]=RKF_posizione(r, ind, componente, v, dt, tol)

    if componente == 'x'
        comp=1;
    elseif componente =='y'
        comp=2;
    end

    %coefficienti RKF45
    a=[0 , 0.25, 3/8, 12/13, 1.0, 0.5]; %non verranno usati ma per completezza sono stati messi
    
    b=zeros(6);
    b(2,1)=0.25;
    b(3,1)=3/32; b(3,2)=9/32;
    b(4,1)=1932/2197; b(4,2)=-7200/2197; b(4,3)=7296/2197;
    b(5,1)=439/216; b(5,2)=-8; b(5,3)= 3680/513; b(5,4)=-845/4104;
    b(6,1)=-8/27; b(6,2)=2; b(6,3)=-3544/2565; b(6,4)= 1859/4104; b(6,5)=-11/40;
    
    gamma_cappuccio=[16/135, 0, 6656/12825, 28561/56430, -9/50, 2/55];
    gamma=[25/216, 0, 1408/2565, 2197/4104, -1/5, 0];
    c=[1/360, 0, -128/4275, -2197/75240, 1/50, 2/55];
    
    % Stima RKF45
    k=[];
    k(1) = velocita(v, componente);
    for j=2:6
        sum=0;
        for i=1:j-1
            sum=sum+b(j,i)*k(i);
        end
        sum=sum*dt;
        k(j)=velocita(v+sum, componente);
    end

    r_next=r(comp);
    for i=1:5
        r_next=r_next+dt*gamma(i)*k(i);
    end

    r_next_cappuccio=r(comp);
    for i=1:6
        r_next_cappuccio=r_next_cappuccio+ dt*gamma_cappuccio(i)*k(i);
    end
    
    error=abs(r_next_cappuccio-r_next);

    if error > tol
        % Riduci il passo
        dt_new = dt * 0.9 * (tol / error)^(1/4);
    else
        % Accetta la soluzione e mantieni il passo
        dt_new=dt;
    end
end

%L'unica differenza è che quì calcolo la posizione successiva con la velocità. Questa funzione mi calcola la velocità
function value=velocita(v, componente)

    if componente == 'x'
        j=1;
    elseif componente =='y'
        j=2;
    end
    value=v(j);
end

%Funzione per il calcolo dell'energia totale del singolo corpo i
function value=Energia(i, m1, m2, m3, r1, r2, r3, v1, v2, v3, G)
    switch i
        case 1
            U=-G*((m1*m2/(norm(r2-r1))+(m1*m3/(norm(r3-r1)))));
            K=1/2*m1*norm(v1)^2;
        case 2
            U=-G*((m1*m2/(norm(r2-r1))+(m2*m3/(norm(r3-r2)))));
            K=1/2*m2*norm(v2)^2;
        case 3
            U=-G*((m1*m3/(norm(r3-r1))+(m2*m3/(norm(r3-r2)))));
            K=1/2*m3*norm(v3)^2;
    end
    value=K+U;
end

%Funzione per il calcolo dell'energia totale del sistema
function value=Energia_Totale(m1, m2, m3, r1, r2, r3, v1, v2, v3, G)
    U=-G*((m1*m2/(norm(r1-r2)))+ (m1*m3/(norm(r1-r3)))+(m2*m3/(norm(r2-r3))));
    K=1/2*m1*norm(v1)^2+1/2*m2*norm(v2)^2+1/2*m3*norm(v3)^2;
    value=K+U;
end
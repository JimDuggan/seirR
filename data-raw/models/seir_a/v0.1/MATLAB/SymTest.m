Q = 0.157925;
AverageContacts = 8;
L =3.7;
C = 5;
D = 4;
f  =0.23354;
h =0.516;
Beta =AverageContacts * Q;

M = [1/L           0                       0       0;
        -1/L  1/(C-L)                      0       0;
        0        -f/(C-L)        1/(D-C+L)     0;
        0       -(1-f)/(C-L)               0     1/(D-C+L)];
    
    
%For plotting the data as a surface the following functions can be useful: 

%linspace
%meshgrid
%mesh
%TriScatteredInterp
%In particular, in the help of the last function you can find a very clear example.

%Also, to force your network to use specific training, validation and test set you can use the following approach: 

%change net.divideFcn = 'divideind'
%remember to update the corresponding attribute net.divideParam.
%We suggest you check the corresponding help to understand how to proceed.
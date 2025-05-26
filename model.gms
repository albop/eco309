$title A Simple CGE Model in Ch. 5 (SPLCGE,SEQ=275)

$onText
No description.


Hosoe, N, Gasawa, K, and Hashimoto, H
Handbook of Computible General Equilibrium Modeling
University of Tokyo Press, Tokyo, Japan, 2004

Keywords: nonlinear programming, general equilibrium model, social accounting
          matrix, utility maximization problem
$offText

Set
   u    'SAM entry' / BRD, MLK, CAP, LAB, HOH /
   i(u) 'goods'     / BRD, MLK                /
   h(u) 'factor'    /           CAP, LAB      /;

Alias (u,v), (i,j), (h,k);

Table SAM(u,v) 'social accounting matrix'
         BRD   MLK   CAP   LAB   HOH
   BRD                            15
   MLK                            35
   CAP     5    20
   LAB    10    15
   HOH                25    25      ;

* Loading the initial values
Parameter
   X0(i)   'household consumption of the i-th good'
   F0(h,j) 'the h-th factor input by the j-th firm'
   Z0(j)   'output of the j-th good'
   FF(h)   'factor endowment of the h-th factor';

X0(i)   = SAM(i,"HOH");
F0(h,j) = SAM(h,j);
Z0(j)   = sum(h, F0(h,j));
FF(h)   = SAM("HOH",h);

display X0, F0, Z0, FF;

* Calibration
Parameter
   alpha(i)  'share parameter in utility function'
   beta(h,j) 'share parameter in production function'
   b(j)      'scale parameter in production function';

alpha(i)  = X0(i)/sum(j, X0(j));
beta(h,j) = F0(h,j)/sum(k, F0(k,j));
b(j)      = Z0(j)/prod(h, F0(h,j)**beta(h,j));

display alpha, beta, b;

Variable
   X(i)   'household consumption of the i-th good'
   F(h,j) 'the h-th factor input by the j-th firm'
   Z(j)   'output of the j-th good'
   px(i)  'demand price of the i-th good'
   pz(j)  'supply price of the i-th good'
   pf(h)  'the h-th factor price'
   UU     'utility [fictitious]';

Equation
    eqX(i)   'household demand function'
    eqpz(i)  'production function'
    eqF(h,j) 'factor demand function'
    eqpx(i)  'good market clearing condition'
    eqpf(h)  'factor market clearing condition'
    eqZ(i)   'price equation'
    obj      'utility function [fictitious]';

eqX(i)..   X(i)   =e= alpha(i)*sum(h, pf(h)*FF(h))/px(i);

eqpz(j)..  Z(j)   =e= b(j)*prod(h, F(h,j)**beta(h,j));

eqF(h,j).. F(h,j) =e= beta(h,j)*pz(j)*Z(j)/pf(h);

eqpx(i)..  X(i)   =e= Z(i);

eqpf(h)..  sum(j, F(h,j)) =e= FF(h);

eqZ(i)..   px(i)  =e= pz(i);

obj..      UU     =e= prod(i, X(i)**alpha(i));

* Initializing variables
X.l(i)   = X0(i);
F.l(h,j) = F0(h,j);
Z.l(j)   = Z0(j);
px.l(i)  = 1;
pz.l(j)  = 1;
pf.l(h)  = 1;

* Setting lower bounds to avoid division by zero
X.lo(i)   = 0.001;
F.lo(h,j) = 0.001;
Z.lo(j)   = 0.001;
px.lo(i)  = 0.001;
pz.lo(j)  = 0.001;
pf.lo(h)  = 0.001;

pf.fx("LAB") = 1;

Model splcge / all /;

solve splcge maximizing UU using nlp;
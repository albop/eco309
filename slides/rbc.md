# Real Business Cycles model

## Introduction

- Context: 
  - Neoclassical growth model is nice, but doesn't explain business cycles frequency variations.
  - Traditional keynesian models were designed for short-term fluctuations but were not micro-founded...

- Contributions from the RBC model (Kydland and Prescott)
    - source of fluctuations are technological shocks only (no demand shock)
    - no need for money
    - fully micro-founded: agents choose rationnally:
      - labour supply
      - investment
    - matches some moments of the data

---

## Model

Capital $k_t$ is combined with labour $l_t$ to produce:

$$y_t = e^{a_t} k_t^{\alpha} l_t^{1-\alpha}$$

where tfp shock $A_t$ follows an AR1 with mean 0 and standard deviation $\sigma$

The capital is accumulated according to:

$$k_{t+1} = (1-\delta) k_t + i_t$$

where $i_t$ is the invested amount. Consumption is what remains after investment decision that is:

$$c_t = y_t - i_t$$

Intratemporal felicity is $U(c,l)=\frac{c^{1-\gamma}}{1-\gamma} + \chi \frac{ \left( 1- l\right)^{1-\psi} }{1-\psi}$ where $\gamma>1$ and $\psi>1$

*Representative agent* maximizes $E_0 \sum_t \beta^t U(c_t, l_t)$ by choosing $l_t\in]0,1[$ and $i_t\in[0,y_t[$

---

## Model : representative agent

- *Representative agent* maximizes $E_0 \sum_t \beta^t U(c_t, l_t)$
  - so now the economy officially consists in one single agent?
  - not exactly

- A simplification assumption
- Under some conditions all agents can be aggregated and will behave in the same way.
  - two flavours of the same model: central planner, decentralized equilibrium
  - same results
  - for now we look at the central planner / single agent case

---

### Analyse the model

What is the states: $a_t, k_t$
What are the controls: $c_t, l_t, i_t$

---

### First order conditions: be brave

To limit the number of lagrangians, we substitute $y_t$ to form the lagrangian. Also we actualize the lagragian with the discount of date $t$.

$$\mathcal{L} = E_0\left\{ \sum_t \beta^t U(c_t,l_t) + \sum_t \beta^t \lambda_t (y_t - c_t - i_t) \right.$$

$$\left. + \sum_t \beta^t \mu_t (e^{a_t} k_t^{\alpha} l_t^{1-\alpha} - y_t) + \sum_t \beta^t q_t \left( k_t(1-\delta) + i_t - k_{t+1} \right)\right\}$$

We get the first order conditions:

$$ \frac{\partial \mathcal{L}}  {\partial c_t}=0=\beta^t U^{\prime}_c(c_t, l_t) - \beta^t \lambda_t$$

$$ \frac{\partial \mathcal{L}}  {\partial l_t}=0=\beta^t \mu_t U^{\prime}_l(c_t, l_t) + \beta^t \mu_t e^{a_t} \left(1-\alpha\right) k_t^{\alpha} l_t^{-\alpha}$$


$$ \frac{\partial \mathcal{L}}  {\partial y_t}=0=\beta^t \left( \lambda_t - \mu_t \right) $$

$$ \frac{\partial \mathcal{L}}  {\partial i_t}=0=\beta^t \left( - \lambda_t - q_t \right) $$

$$ \frac{\partial \mathcal{L}}  {\partial k_{t+1}}=0=\beta^{t+1} E_t \left[ \mu_{t+1} \alpha e^{a_{t+1}}k_{t+1}^{\alpha}l_{t+1}^{1-\alpha} +q_{t+1}\right] - \beta^t q_t$$

---

### Simplify:

We get the first order conditions:

- $ 0=\beta^t U^{\prime}_c(c_t, l_t) - \beta^t \lambda_t$ becomes: 
$$U^{\prime}_c(c_t, l_t) =\lambda_t$$   
    - $\lambda_t$ is the value of an additional unit of consumption

- $0= \beta^t U^{\prime}_l(c_t, l_t) + \beta^t \mu_t e^{a_t} \left(1-\alpha\right) k_t^{\alpha} l_t^{-\alpha}$ becomes:
$$-U^{\prime}_l(c_t, l_t) = e^{a_t} \left(1-\alpha\right) k_t^{\alpha} l_t^{-\alpha}$$
    - optimal labour supply


- $0=\beta^t \left( \lambda_t - \mu_t \right)$ becomes:
$$\lambda_t = \mu_t$$
    - value of additional unit of production is equal to the value of one additional unit of consumption

- $0=\beta^t \left( -\lambda_t + q_t \right)$ becomes:
$$\lambda_t = q_t$$
    - value of additional unit of investment is equal to the value of one additional unit of consumption


- $0=\beta^{t+1} E_t \left[ \mu_{t+1} \alpha e^{a_{t+1}}k_{t+1}^{\alpha}l_{t+1}^{1-\alpha} + \left(1-\delta\right)q_{t+1}\right] - \beta^t q_t$ becomes:
$$q_t = \beta E_t \left[ \mu_{t+1} \alpha e^{a_{t+1}}k_{t+1}^{\alpha}l_{t+1}^{1-\alpha} + \left( 1-\delta \right) q_{t+1}\right]$$
    - $q_t$ is the value of installed capital (Tobin's q)

---

### Keep the essential parts:

After replacing $q_t$, $\mu_t$ and $\lambda_t$ we get a model where the unknowns are $k_t$ (a state), $l_t$ and $n_t$ (note that in general it is not possible to get rid of all lagrangians):

- Euler Conditions:

  - Optimal investment
$$U^{\prime}_c(c_t, l_t) = \beta E_t \left[ U^{\prime}_c(c_{t+1}, l_{t+1}) \left( \alpha e^{a_{t+1}}k_{t+1}^{\alpha}l_{t+1}^{1-\alpha} + \left( 1-\delta \right) \right) \right]$$

  - Optimal labour supply
$$-U^{\prime}_l(c_t, l_t) = e^{a_t} \left(1-\alpha\right) k_t^{\alpha} l_t^{-\alpha}$$

- Transition equation

$$k_{t+1} = (1-\delta) k_t + (e^{a_t}k_t^{\alpha} l_t^{1-\alpha} - c_t)$$

---

### Alternative formulation


If we had kept the other variables we would have an equivalent model:

$$U^{\prime}_c(c_t, l_t) = \beta E_t \left[ U^{\prime}_c(c_{t+1}, l_{t+1}) \left(  \alpha e^{a_{t+1}}k_{t+1}^{\alpha}l_{t+1}^{1-\alpha} + \left( 1-\delta \right) \right) \right]$$

$$-U^{\prime}_l(c_t, l_t) = e^{a_t} \left(1-\alpha\right) k_t^{\alpha} l_t^{-\alpha}$$


$$y_t = c_t + i_t$$

$$y_t = e^{a_t}k_t^{\alpha} l_t^{1-\alpha}$$

$$k_{t+1} = (1-\delta) k_t + i_t$$

There are still 5 equations for 5 unknowns.

---

### Calibrating the parameters

- $\alpha=1/3$: capital share
- $\delta=0.1$: depreciation rate
- $\frac{1}{\gamma}=1/2$: E.I.S.
- $\frac{1}{\psi}=0.4$: Frisch Elasticity
- $\chi?$


---

### Deterministic Steady-State

The deterministic steady-state satisfies: $v_t = v_{t+1} = \overline{v}$ for all variable $v$. The exogenous shock is set at $a_t=0$. This yields the equations:

$$1 = \beta \left(  \alpha \overline{k}^{\alpha}\overline{l}^{1-\alpha} + \left( 1-\delta \right) \right) $$

$$-U^{\prime}_l(c_t, l_t) = \red{\chi} (1-\overline{l})^{1-\psi} =  \left(1-\alpha\right) \overline{k}^{\alpha} \overline{l}^{-\alpha}$$


$$\overline{y} = \overline{c} + \overline{i}$$

$$\overline{y} = \overline{k}^{\alpha} \overline{l}^{1-\alpha}$$

$$\overline{k} = (1-\delta) \overline{k} + \overline{i}$$


There is no closed form if we take ${\chi}$ as given but, if we set $\overline{l}=1/3$ (for instance) it gets pinned down.


---

### Deterministic Steady-State (2)

After some simplifications:

$$\overline{l} = 1/3$$

$$\overline{k} = \left( \frac{1/\beta - (1-\delta)}{\alpha \overline{l}^{1-\alpha}} \right)^{\frac{1}{\alpha-1}}$$

$$\red{\chi} = \frac{ \left(1-\alpha\right) \overline{k}^{\alpha} \overline{l}^{-\alpha} }{ (1-\overline{l})^{1-\psi} }$$

$$\overline{i} = \delta \overline{k}$$

$$\overline{y} = \overline{k}^{\alpha} \overline{l}^{1-\alpha}$$


$$\overline{c} = \overline{y} - \overline{i}$$



---

### Dolo.jl

- Dolo.jl is a software to compute the solution of rational expections models
    - models are coded using special syntax in "yaml" files
    - many algorithms are available to solve a given model: linear, nonlinear, ...
    - the first order solution is obtained with function `perturb`.

- check doc: http://www.econforge.org/Dolo.jl/latest/

---

### Formulating the model in Dolo.jl (1): calibration section

The calibration section contains all the values for the parameters and the steady-state variables. It must be possible to solve the whole system by solving for one variable at a time (triangular system).


---

### Formulating the model in Dolo.jl (2): equations

Since we have kept the conventions that variables indexed by $t$ are known at date $t$, we can rewrite the equations in the following way:

$$U^{\prime}_c(c_t, l_t) = \beta E_t \left[ U^{\prime}_c(c_{t+1}, l_{t+1}) \left( \mu_{t+1} \alpha e^{a_{t+1}}k_{t+1}^{\alpha}l_{t+1}^{1-\alpha} + \left( 1-\delta \right) \right) \right]$$

$$U^{\prime}_l(c_t, l_t) = e^{a_t} \left(1-\alpha\right) k_t^{\alpha} l_t^{-\alpha}$$


$$y_t = c_t + i_t$$

$$y_t = e^{a_t}k_t^{\alpha} l_t^{1-\alpha}$$

$$k_t = (1-\delta) k_{t-1} + i_{t-1}$$

Then it doesn't change anything if all equations are surrounded by $E_t \left[ \right]$

---

### What to do with the solution:

Solution is a __decision rule__ $\varphi$, such that $(i_t,l_t)=\varphi(k_t, a_t)$
What can we do with it ?

- plot decision rule
- simulate
    - measure moments
    - make forecasts
- compute response to shocks

---

### Simulations

Given decision rule $\varphi$, such that $(i_t,l_t)=\varphi(k_t, a_t)$) one can simulate the economy 


Simulate: 
- Start from any initial state $(k_0, z_0)$.
- Given state $k_t, z_t$
    - Compute controls:
  \[(i_t,l_t)=\varphi(k_t, a_t)\]
    - Compute random innovations  $\epsilon_{t+1}$ and use transition equations:
  \[k_{t+1} = (1-\delta) k_t + i_t\]
  \[a_{t+1} = \rho a_t + \epsilon_{t+1}\]
- Compute all other variables afterwards $y_t, w_t, r_t, ...$

Variants:
    - __deterministic__ simulation, keep $\epsilon_t=0$
    - __impulse response funtion__: start from steady state, then $\epsilon_1>0$ and $\epsilon_2 = ... = \epsilon_n = ... = 0$


---

### Deterministic simulation:



<!-- Show graph, with risky steady-state -->

---

### Impulse Response Function


<!-- Show graph, with risky steady-state -->

---

### Stochastic Simulations

Compute many draws.

Plot average

Add standard deviations

Compute moments

---

### Compare moments with the data

Contrary to model, data $(x_t)$ is not stationary. Decompose $x_t$ between trend and cycle: $x_t = \tau_t + c_t$.
Cyclical component is the one that should be compared with the model.

HP filter:

\[\min_{\tau_1, ...\tau_T} \left( \sum_{t=1}^T \left( x_t - \tau_t\right)^2) + \lambda \sum_{t=2}^{T-1} \left[ (\tau_{t+1} - \tau_t) - (\tau_t - \tau_{t-1}) \right] ^2 \right)\]

Choose $\lambda$:
  - higher $\lambda$, smoother cycle
  - in practice: $\lambda=6.25$ for annual data, $\lambda=1600$ for quarterly data
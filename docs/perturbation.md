# Perturbation

---

## First order conditions and time-iteration

---
### General formulation

General model formulation:
    
- States:  $s_t \in R^{n_s}$
- Controls/actions:  $x_t \in R^{n_x}$
- Transitions: $g$ such that

$$\require{color}s_t = g(s_{t-1}, x_{t-1}, \epsilon_t)\in R^{n_s}$$

- Optimality conditions (Euler): 

$$E_t \left[ f(s_t, x_t, s_{t+1}, x_{t+1}) \right] \in R^{n_x}$$

---

### General formulation, deterministic version

General model formulation:
    
- States:  $s_t$
- Controls/actions:  $x_t = \varphi(s_t)$ with $\varphi$ to be determined
- Transitions: $g$ such that

$$s_t = g(s_{t-1}, x_{t-1}, 0)$$

- Optimality conditions (Euler): 

$$f(s_t, x_t, s_{t+1}, x_{t+1})$$

---

### Example: Deterministic Neoclassical model

State: $k_t$
Control: $c_t = \varphi(k_t)$

Transition:

\[k_{t+1} = (1-\delta) k_t + (k_{t}^\alpha-c_t)\]

Optimality:

\[U^{\prime}(c_t) = \beta U^{\prime}(c_{t+1}) \left( \alpha k_{t+1}^{\alpha-1} + (1-\delta) \right) \]

---


### Example: Deterministic Neoclassical model

State: $k_t$
Control: $c_t = \varphi(k_t)$

Transition:

\[k_{t+1} = (1-\delta) k_t + (k_{t}^\alpha-{\color{red}\varphi}(k_t))\]

Optimality:

\[U^{\prime}({\color{red}\varphi}(k_t)) = U^{\prime}\left( {\color{green}\varphi}\left( k_{t+1} \right) \right) \left( \alpha \left(k_{t+1}\right)^{\alpha-1} + (1-\delta) \right) \]

---



### Example: Deterministic Neoclassical model

One single functional equation:


\[\Phi(\varphi)(k) = - U^{\prime}({\color{red}\varphi}(k_t)) + U^{\prime}\left( {\color{green}\varphi}\left( (1-\delta) k_t + (k_{t}^\alpha-{\color{red}\varphi}(k_t))\right) \right) \left( \alpha \left((1-\delta) k_t + (k_{t}^\alpha-{\color{red}\varphi}(k_t))\right)^{\alpha-1} + (1-\delta) \right) \]

\[\forall k, \Phi(\varphi)(k) = 0\]

- Note the composition of $\varphi$ "by itself".

---

### Example: Deterministic Neoclassical model

We must have $\forall k$


\[\Phi(\varphi, \tilde{\varphi})(k)  = - U^{\prime}({\color{red}\varphi}(k)) = U^{\prime}\left( \tilde{\varphi} \left( k^{\prime} \right) \right) \]
\[ \left( \alpha \left(k^{\prime}\right)^{\alpha-1} + (1-\delta) \right)\]
with \[k^{\prime} = (1-\delta) k + (k^\alpha-{\color{red}\varphi}(k))\]

---

### Back to general formulation:


\[s_t = g(s_{t-1}, x_{t-1}, \epsilon_t)\]
\[f(s_t, x_t, s_{t+1}, x_{t+1})\]

becomes:
\[\forall s, \Phi(\varphi, \tilde{\varphi})(s) = E_{\epsilon} f(s, \varphi(s), s', \tilde{\varphi}(s'))\]
with \[s'=g(s,\varphi(s),\epsilon)\]


---

### Time iteration algorithm

A solution must satisfy:

$$\Phi(\varphi, \varphi)= 0$$

Time-iteration operator: $T(\varphi)$ such that \[\Phi(T(\varphi), \varphi)= 0\]

- Computing $T(\varphi)$ implies finding the zero of $u \rightarrow \Phi(u,\varphi)$

Time-iteration algorithm:

- initial guess $\varphi_0$
- iterate on $\varphi_{n+1} = T(\varphi_{n})$ until convergence (i.e. $|\varphi_{n+1} - \varphi_{n}| <\eta$)
- converges linearly in general

---


### Example (1)

- risk neutral price valuation with discount rate $\beta$

    - fundamental: $z_t = \rho z_{t-1} + \epsilon_t$
    - dividend: $d_t = d(z_t)$, $d()$ given
    - find the risk neutral price: $p_t = E_t \left[ \sum_{s\geq t} \beta^{s-t} d_{s} \right]$
    - what is the functional equation satisfied by $p()$?

\[\forall z, p(z) = d(z) + \beta E_{\epsilon} p \left( \rho z + \epsilon \right)\]
- time iteration operator $T: p\rightarrow T(p)$ such that: 

\[\forall z, \space T(p)(z) = d(z) + \beta E_{\epsilon} p \left( \rho z + \epsilon \right)\]

---


### Example (2)

- neoclassical growth model:

\[U^{\prime}({\color{red}\varphi}(k)) = U^{\prime}\left( {\color{green}\tilde{\varphi}}\left( k^{\prime} \right) \right) \left( \alpha \left(k^{\prime}\right)^{\alpha-1} + (1-\delta) \right) \]

with \[k^{\prime} = (1-\delta) k + (k^\alpha-{\color{red}\varphi}(k))\]

- in general there isn't an explicit formula linking $\tilde{\varphi}()$ to $\varphi()$

---

### Bonus: Improved Time Iterations

Consider Newton-Kantarovitch iterations (Newton applied to $u \rightarrow \Phi(u) - u$)
\[\varphi_{n+1} = \varphi_n - \underbrace{\left(I- T^{\prime}(\varphi) \right)^{-1}.\left(\overbrace{\varphi_n-T(\varphi_{n})}^{-\delta_n}\right)}_{-\Delta_n}\]

In this expression, denoting by $\mathcal{D}$ the space of decision rules:
- $I$ is the identity operator: $I(\varphi) = \varphi$
- $T^{\prime}(\varphi)$ is a linear operator $\mathcal{D}\rightarrow \mathcal{D}$, $u \rightarrow T^{\prime}(\varphi).u$

If $\sup_{|\varphi|=1} | T^{\prime}(\varphi)|<1$ (*backward stability*) then $\left(I- T^{\prime}(\varphi) \right)^{-1}$ exists and 
\[\left(I- T^{\prime}(\varphi) \right)^{-1} = \sum_{k=0}^{\infty}\left(T^{\prime}\right)^k(\varphi)\]

---

### Bonus: Improved Time Iterations Algorithm

$$\varphi_{n+1} = \varphi_n + \underbrace{\left(T(\varphi_{n})-\varphi_n\right)}_{\delta_n} + \underbrace{T^{\prime}(\varphi).\delta_n + T^{\prime}(\varphi)^2.\delta_n + ...}_{\textit{improvements}}$$

- "Optimistic" improvements: $\sum_{k=1}^K T^{\prime}(\varphi)^k.\delta_n$ with $K<\infty$
- Improvements require only the knowledge of how to compute $T^{\prime}(\varphi).d\varphi$ for any $d \varphi$
    - if $u_k = T^{\prime}(\varphi)^k.\delta_n$ then $u_{k+1}= T^{\prime}(\varphi) u_k$

---

### Bonus 2: Backward Stability

Application $T^{\prime}$ should be a contraction mapping: small deviations in the future decision rules should not affect decision rules today.

- It is a desirable feature of a well-specified economic model: expectations are stable.
- How do you measure *operator norm* $\sup_{|x|=1 } | T^{\prime}(x)|$ ?

Use the *power iteration* method.  For a given linear application $L.u\rightarrow u$

- Start with *random* $v_0$ and compute $u_0=\frac{v_0}{|v_0|}$
- Given $u_n$, compute 
    - $v_{n+1} = L.u_n$
    - $\lambda_{n+1}=|v_{n+1}|$
    - $u_{n+1} = \frac{v_{n+1}}{| v_{n+1}|}$
- $\lambda_n$ converges to $\sup_{|x|=1 } |L.x|$

---

## Perturbation analysis

---

### Preamble: Implicit Function Theorem

With all the right assumptions, suppose function $F(x,y)$ is known. We can define a function $\varphi$ implicitly by the relation:

$\forall x, F(x,\varphi(x))=0$

If $F(\overline{x}, \overline{y}) = 0$, we can recover a Taylor expansion of $\varphi$ around $\overline{x}$ as 
\[\varphi(x) = \overline{y} + X (x-\overline{x}) + o(x-\overline{x})\]

- Differentiate w.r.t. x around $\overline{x}$ to get:
\[F^{\prime}_x(\overline{x},\overline{y}).dx + F^{\prime}_y(\overline{x},\overline{y}).\varphi^{\prime}(x) .dx = o(dx), 
\space \forall dx\]
- Unknown coefficient $X$ is a solution of the *linearized* system in $X$:

\[F^{\prime}_x(\overline{x},\overline{y}) + F^{\prime}_y(\overline{x},\overline{y}).X = 0\]

---

### Perturbation

$$s_{t+1} = g(s_t, x_t, \sigma \epsilon_t)$$

$$E_t \left[ f(s_t, x_t, s_{t+1}, x_{t+1}) \right]$$

Note risk-scaling parameter $\sigma$:
- solution is parameterized by $\sigma$: $x = \varphi(s,\sigma)$
- deterministic solution: $s\rightarrow \varphi(s,0)$
- actual solution: $s\rightarrow \varphi(s,1)$

Recover actual solution:

\[\varphi(s) = \varphi(s, 0) + \varphi^{\prime}_{\sigma}(s, 0) \sigma + ...  \]

- Certainty equivalence: $\varphi^{\prime}_{\sigma}(s, 0) = 0$
    - we focus on the deterministic model (i.e. set $\sigma=0$)

---

### Perturbation: deterministic model

$$s_{t+1} = g(s_t, x_t, 0)$$

$$f(s_t, x_t, s_{t+1}, x_{t+1})$$

Steady-state: $\overline{s}, \overline{x}$ such that: 

$$\overline{s} = g(\overline{s}, \overline{x}, 0)$$

$$f(\overline{s}, \overline{x}, \overline{s}, \overline{x})$$

We look for a Taylor expansion:
\[\varphi(s) = \overline{x} + X(s-\overline{s}) + o(s-\overline{s}) \]

What pins down $X\in R^{n_x} \times R^{n_s}$ ?

---

### Perturbation: linear model

- perturb transition equation:

$$x_t-\overline{x} = X(s_t-\overline{s}) + o(s_t-\overline{s})$$

$$s_{t+1}-\overline{s} = g^{\prime}_s(s_t - \overline{s}) + g^{\prime}_x X(s_t - \overline{s}) + o(s_t-\overline{s})$$

$$x_{t+1}-\overline{x} = X(g^{\prime}_s + g^{\prime}_x X) (s_t - \overline{s}) + o(s_t-s)$$

---

### Perturbation: linear model (2)

- perturb arbitrage equation

\[0 = f(s_t, x_t, s_{t+1}, x_{t+1}) = f^{\prime}_s(s_t-\overline{s})+f^{\prime}_x(x_t-\overline{x})+f^{\prime}_S(s_{t+1}-\overline{s})+f^{\prime}_X(x_{t+1}-\overline{x})\]

- replace to get:

\[0 = f^{\prime}_s (s_t - \overline{s}) + f^{\prime}_x  X(s_t - \overline{s}) +  f^{\prime}_S  (g_s + g_x X) (s_t - \overline{s}) +  f^{\prime}_X  X (g_s + g_x X)  (s_t - \overline{s}) + o(s_t - \overline{s})\]

Must be 0 for any $s_t$

---

### Perturbation: linear model (2)


\[0 = f^{\prime}_s  + f^{\prime}_x  X +  f^{\prime}_S  (g_s + g_x X) +  f^{\prime}_X  X (g_s + g_x X)   \]

- Comments:
    - matrix equation in $X$
    - quadratic terms: not easy to solve
    - multiple solutions: which one to choose?
- System satisfies __Blanchard-Kahn criterium__ if there is a *unique* solution $X$ such that:
    - $g_s + g_x X$ is convergent.
    - $X$ satisfies equation above

---

### Example: neoclassical model


- Two roots: (cf exercise)
    

---

### Perturbation: linear time iteration (1)

There is a simple numerical procedure to solve the system: *linear time iteration*

Define:

\[F(X,Y) = f^{\prime}_s  + f^{\prime}_x  X +  f^{\prime}_S  (g_s + g_s X) +  f^{\prime}_X  Y (g_s + g_x X)\]

- Matrix $Y$ corresponds to future decision rule
- Solution $X$ must satisfy $F(X,X) = 0$


---

### Perturbation: linear time iteration (2)

Linear Time Iteration algorithm

- choose random $X_0$
- given $X_n$ find $X_{n+1}$ such that $F(X_{n+1}, X_n)=0$
    - implicitly defined $T$ such that $F(T(X),X)=0$ is *time iteration* operator
- iterate until $| X_n-X_{n+1}| < \eta$

By construction the limit X satisfies $F(X,X)=0$


---


### Perturbation: linear time iteration (3)

So we have a solution $X$. How do we know it is stable? Can we know whether it is unique?

Blanchard-Kahn condition is exactly equivalent to:

- $P(X) = g_s + g_x X$ is stable (i.e. $sup_{|u|=1} |P.u| \leq 1$)
- time-iteration is a strict contraction, that is $sup_{|u|=1} |T^{\prime}(X).u| < 1$

---
### Power iterations method

Given linear operation $L$. You want to compute $\sup_{|x|=1} |L.x|=\sup_{|x|\neq 0} \frac{|L.x|}{|x|}$.

Start with *random* $v_0$, compute $u_0 = \frac{v_0}{|v_0|}$

Given $u_n$ (of norm 1):
- $v_{n+1} = L.u_n$
- $\lambda_{n+1} = |v_{n+1}|$
- $u_{n+1} = \frac{v_{n+1}}{|v_{n+1}|}$

You get $\lambda_n \rightarrow \sup_{|x|=1} |L.x|$


---

### Perturbation: linear time iteration (4)

How do we measure numerical radius:  $sup_{|u|=1} |P.u| \leq 1$ and $sup_{|u|=1} |T^{\prime}(X).u| < 1$ ?

- using power iterations method
- $P.u$ is simple a simple matrix multiplication but $T^{\prime}(X).u$ looks hairy...
    - not at all

Differentiate: $F(T(X), X) = 0$
\[F^{\prime}_X T^{\prime} (X) . u+ F^{\prime}_Y.u = 0\]

Note that $F$ is actually linear in X and Y so: 
- $F^{\prime}_X: u\rightarrow + f^{\prime}_x  u +  f^{\prime}_S  Y g_x u +  f^{\prime}_X  X g_x u = \left( f^{\prime}_x  +  f^{\prime}_S  Y g_x  +  f^{\prime}_X  X g_x\right).u$
    - basic matrix multiplication: easy to invert
- $F^{\prime}_Y: u \rightarrow f^{\prime}_X  u (g_s + g_s X)$
    - clearly linear in $u$

Finally: 
\[T^{\prime}(X).u = \left( f^{\prime}_x  +  f^{\prime}_S  Y g_x  +  f^{\prime}_X  X g_x\right)^{-1} f^{\prime}_X  u (g_s + g_s X)\]



---

## Application: New keynesian model

---

### New-keynesian model

- Building bricks:
    - rational agent (like RBC)
    - market imperfection:
        - firms retain monopolistic power (and charge markups) because of price stickiness 

- Nominal prices matter
    - model offers a theory of inflation
    - central bank chooses (optimally or not) nominal interest rate

- Model is fully micro founded
    - reduced form has just 3 equations

---

### New-keynesian model (reduced form)

Phillips Curve:

$$\pi_t = \beta E_t \left[ \pi_{t+1} \right] + \kappa y_t $$

IS Curve:

- closed economy: $c_t=y_t$
- euler equation ${c_t}^{-\sigma} = \beta c_{t+1}^{-\sigma} (i_{t} - \pi_{t+1})$

$$y_t = y_{t+1} + \frac{1}{\sigma}(i_t - E_t\left[ \pi_{t+1}\right] ) + \nu_t$$

Taylor Rule:

$$i_t = \pi_t + r^{\star}_t + \alpha_{\pi} \left( \pi_t - \pi_t^{\star} \right) + \alpha_y (y_t - y^{\star}_t)$$

---

### New-keynesian model (2)

Variables:

- $\pi_t$: inflation
- $y_t$: production (log-deviation)
- $i_t$: inflation

Meaning of the parameters:

- $\beta=1.01$: discount rate
- targeted values (all 0 here): $r^{\star}_t$, $\pi^{\star}_t$, $y_t^{\star}$
- $\kappa$: response of inflation to output (depends on price adjustment)
    - $\kappa = \frac{h(1-(1-h)\beta)}{1-h}$
    - $h$ is probability of price adjustment (flexibility)

---

### Taylor rule

- Taylor *rule*: just two parameters $\alpha_{\pi}$ and $\alpha_{y}$:
    - usual values: $\alpha_{\pi}=\alpha_{y}=0.5$ !
    - suboptimal but not that much (in the linear model and in the world)
    - "close" to what CBs have been doing
- Taylor principle:
    -  $\alpha_{\pi}>0$: for the model do be well defined
    -  interest rate react more than 1 to 1 to inflation

---
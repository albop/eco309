# Push-ups

list some functions here

__Consider the logistic function $f(x)=a x (1-x)$. __

---



__Write a function `fixed_point(f::Function, x0::Float64)` which computes the fixed point of `f` starting from initial point `x0`. Test with ...__

__Write a function `bisection(f::Function, a::Float64, b::Float64)` which computes a zero of function `f` within `(a,b)` using a bisection method.__

__Write a function `golden(f::Function, a::Float64, b::Float64)` which computes a zero of function `f` within `(a,b)` using a golden ratio method.__

__Write a function `zero_newton(f::Function, x0::Float64)` which computes the zero of function `f` starting from initial point `x0`. __

__Add an option `zero_newton(f::Function, x0::Float64, backtracking=true)` which computes the zero of function `f` starting from initial point `x0` using backtracking in each iteration. __

__Write a function `min_gd(f::Function, x0::Float64)` which computes the minimum of function `f` using gradient descent. Assume `f` returns a scalar and a gradient.__

__Write a function `min_nr(f::Function, x0::Float64)` which computes the minimum of function `f` using Newton-Raphson method. Assume `f` returns a scalar, a gradient, and a hessian.__

---

# Profit optimization by a monopolist

A monopolist produces quantity $q$ of goods X at price $p$. Its cost function is $c(q) = 0.5 + q (1-qe^{-q})$

The consumer's demand for price $p$ is $x(p)=2 e^{-0.5 p}$ (constant elasticity of demand to price).

__Write down the profit function of the monopolist and find the optimal production (if any). Don't use any library except for plotting.__

---


# (modified) Solow model

This model tries to explain long-term productivity, its relation to productivity and the speed of convergence.

The setup is the following:

- a country accumulates capital $k_t$
- population $n_t$ grows at rate $g$
- capital and labour are combined to produce $y_t = A F(k_t, n_t)$ where $A$ is total factor productivity.
- capital depreciates at rate $\delta$. Its law of motion is $k_{t+1}=k_{t}+i_{t}$ where $i_t$ is the amount invested at time $t$
- production is either consumed or invested: $y_t = c_t + i_t$

We choose a Cobb-Douglas specification with constant returns to scale $F(k_t, n_t) = k_t^{\alpha} n_t^{1-\alpha}$.

In the Ramsey–Cass–Koopmans  model (also called neoclassical growth model), a representative agent would choose $c_t$ in every period so as to maximize an intertemporal utility like $\sum_{t \geq 0} \beta^t U(c_t)$ where $\beta \in [0,1[$ is a time discount and $U(x)=\frac{x^{1-\gamma}}{1-\gamma}$ is the instantaneous felicity.

Here we follow the Solow-Swan specification and assume instead there is a fixed fraction $s\in[0,1[$ of income in every period, which is saved and invested in every period. In other words:

$$i_t = s y_t$$

As a result, the dynamic of capital and all other variables will be backward looking and can be simulated easily.

__Calibrate parameters $\beta$, $\delta$ and $g$, that is, propose plausible values for them, from the litterature, or by matching some observable fact.__

__Detrend the equations of the model w.r.t. population growth. Denote the detrended variables with a hat (in the code we assume all variables are detrended and ignore the hat).__


Our goal is to compute the steady-state and assess its stability.

__Compute a function `f` which returns the capital $\hat{k}_{t+1}$ as a function of $\hat{k_t}$__

__Starting from an initial level $\hat{k}_0$ compute successive iterates of $f$ to find the long-run level $\overline{k}$ of capital per capita. (Bonus: produce a nice plot of the convergence)__

__What factors affect the steady-state level of capital?__

__Study the stability of $f$ around $\overline{k}$. Which factors affect the speed of convergence towards the steady-state?__

__Compute the steady-state directly using a Newton method and compare convergence speed.__

__Suppose one tries to maximize steady-state consumption by choosing saving rate $s$. Which value would one choose?__

__(Bonus) Suppose an agent is given the intertemporal utility from the Ramsey–Cass–Koopmans model but chooses saving rate once for all. Which saving rate would one choose? Is it the same for all initial levels of capital?__

---

# Consumption optimization

A consumer has preferences $U(c_1, c_2)$ over two consumption goods $c_1$ and $c_2$.

Given a budget $I$, consumer wants to maximize utility subject to the budget constraint $p_1 c_1 + p_2 c_2 \leq I$.

We choose a Stone-Geary specification where

$U(c_1, c_2)=\beta_1 \log(c_1-\gamma_1) + \beta_2 \log(c_2-\gamma_2)

__Write the Karush-Kuhn-Tucker necessary conditions for the problem.__

__Verify the KKT conditions are sufficient for optimality.__

__Derive analytically the demand functions, and the shadow price.__

__Interpret this problem as a complementarity problem and solve it using NLSolve__

__Produce some nice graphs with isoutility curves, the budget constraint and the optimal choice.__

---

# Exercise: constrained optimization

Consider the function $f(x,y) = 1-(x-0.5)^2 -(y-0.3)^2$.

- use Optim.jl to minimize $f$ without constraint

- now, consider the constraint $x<0.3$ and maximize $f$ under this new constraint.

- reformulate the problem as a root finding with lagrangians. Write the complementarity conditions.

- solve using NLSolve.jl

## Cake Eating problem and Euler equation

### Cake eating problem

Initial size of the cake is $C_0>0$. In each period $t$ if the remaining size of the cake is $C_t$ you can choose to consume an amount $c_t \in [0, C_t]$ of the cake and leave $C_{t+1} = C_t-c_t$ for the next period.

In each period you get felicity $U(x)=\frac{x^{1-\gamma}}{{1-\gamma}}$ (with $\gamma>1$) and your goal is to maximize:
$$\sum_{t = 0}^{\infty} \beta^{t} U(c_t)$$
where $\beta>0$ is the discount factor.

---

### Cake eating problem (2)

It is a constrained maximization problem:

$$\max_{c_0, \cdots, c_k, ...} \sum_{t = 0}^{\infty} \beta^{t} U(c_t)$$

subject to:

$$\sum_{t = 0}^{\infty} c_t \leq C_0$$
$$c_0 \geq 0, c_1 \geq 0, ..., c_k \geq 0, ...$$

- First constraint is quite intuitive, right?
- Because $U^{\prime}(0)=\infty$, it is never optimal to choose $c_k=0$
    - proof?
    - constraint can be ignored when looking at first conditions

---

### Cake eating problem (3)

Denote 

$$V(c_0, \cdots, c_t, ...) = \sum_{t = 0}^{\infty} \beta^{t} U(c_t)$$

A unit of cake can be consumed in any period. Marginal value of consuming it in period $k$ must be the same as in period $0$ or in period $l$. This translate into:

$$\forall t, \space \frac{\partial}{\partial c_k} V= K$$

for some constant $K$ or equivalently:

$$\forall t, \beta^t U^{\prime}(c_t) = K$$

This pins down $c_t$

---

### Cake eating problem (4)

We must have at the optimum:
$$\forall t, \beta^t \frac{c_t^{1-\gamma}}{1-\gamma} = K$$

Or $c_t = \left( \frac{1-\gamma}{\beta^t} K \right)^{\frac{1}{1-\gamma}}$

What is the value of $K$ then? Use the budget constraint:

 $C_0 = \sum_t c_t =  \sum_t \left(\frac{1}{\beta^{\frac{1}{1-\gamma}}}\right)^t \left( \frac{1-\gamma} K \right)^{\frac{1}{1-\gamma}}$

 To get $K$.

---

### Cake eating problem (5)

We can get the same result using the lagrangian?

$$\max_{c_0, ..., c_t, ...} \mathcal{L} = \left( \sum_{t\geq 0} \beta^t U(c_t) \right) + \lambda \left(  C_0 - \sum_{t\geq 0} c_t\right)$$

- Check signs:
  - $\lambda \geq 0$ (increase in $C_0$ increases value)
  - $C_0 - \sum_{t\geq 0} c_t \geq 0$
  - Complementarity: $\lambda \left(C_0 - \sum_{t\geq 0} c_t \right) = 0$

---

### Cake eating problem (6)


$$\mathcal{L} = \left( \sum_{t\geq 0} \beta^t U(c_t) \right) + \lambda \left(  C_0 - \sum_{t\geq 0} c_t\right)$$


Maximize the lagrangian. First order conditions:

$$\forall t, \frac{ \partial \mathcal{L} }{\partial c_t} = 0$$

$$\forall t, \beta^t U^{\prime}(c_t) = \lambda$$

F.O.C. pins down $c_t$ up to the value of $\lambda$, which is determined using the budget constraint.

---


### Cake eating problem (7)


$\forall t, \beta^t U^{\prime}(c_t) = \lambda$ vs $\forall t, \beta^t U^{\prime}(c_t) = K$

So $K$ was the lagrangian ?

![](cat.jpg)


---

### Euler conditions

- Problem with the budget constraint: $C_0=\sum_t c_t$ involves all variables. Not ideal if you want to "simulate" a model. Can we use instead a constraint which links $c_{t}$ and $c_{t+1}$ only?



Consider the formulation

$$\max_{\begin{bmatrix} c_0 \leq C_0\\  \cdots \\ c_t \leq C_t \\ \cdots \\ C_1 = C_0-c_0 \\ \cdots \\C_{t+1} = C_t-c_t \\ \cdots \end{bmatrix}} \sum_{t = 0}^{\infty} \beta^{t} U(c_t)$$

- Formulation exactly equivalent to original problem.
- Now we are maximizing w.r.t. $c_t$ (the control) and $C_t$ (the predetermined state): their relationship is included in the constraints.

---


### Euler conditions (2)


$$\max_{\begin{bmatrix} c_0 \leq C_0\\  \cdots \\ c_t \leq C_t \\ \cdots \\ C_1 = C_0-c_0 \\ \cdots \\C_{t+1} = C_t-c_t \\ \cdots \end{bmatrix}} \sum_{t = 0}^{\infty} \beta^{t} U(c_t)$$

- Write the lagrangian:
$$\mathcal{L} = \sum_{t = 0}^{\infty} \beta^{t} U(c_t) + \sum_{t = 0}^{\infty} \mu_t \left( C_t - c_t\right) + \sum_{t = 0}^{\infty} \lambda_t \left( C_t - C_{t+1} - c_t \right)$$

  - many more lagrange multipliers: $\lambda_t\geq0$, $\mu_t\geq0$
  - because $U^{\prime}(0)=\infty$, $\forall t, \space c_t<C_t$, hence $\forall t, \mu_t=0$

---

### Euler conditions (3)


$$\mathcal{L} = \sum_{t = 0}^{\infty} \beta^{t} U(c_t) + \sum_{t = 0}^{\infty} \mu_t \left( C_t - c_t\right) + \sum_{t = 0}^{\infty} \lambda_t \left( C_t - C_{t+1} - c_t \right)$$

Differentiate the lagrangian

- w.r.t. to each $c_t$: 
$$\frac{\partial}{\partial c_t} \mathcal{L} = \beta^t U^{\prime} (c_t) - \lambda_t = 0$$
    
    - so $\lambda_t$ marginal utility of one more unit of consumption in $t$? hmm
- w.r.t. to each $C_{t+1}$ ($C_0$ is fixed):
    $$-\lambda_t + \lambda_{t+1} = 0$$
    - $\forall t\space \lambda_t = \lambda_0$ (a.k.a $K$, $\lambda$, ...)

---

### Euler conditions (4)

First order conditions:

$$\beta^t U^{\prime} (c_t) = \lambda_t$$
$$\lambda_{t+1} = \lambda_t$$

These conditions are called __Euler equations__.

*An Euler equation is a difference or differential equation that is an intertemporal first-order condition for a dynamic choice problem.*

Here, we can get rid of the lagrangian:

$${U^{\prime} ( c_t )} = \beta U^{\prime} (c_{t+1})$$

---

### Euler equations and stochastic process

So far, the process, was fully deterministic. What if it is stochastic ?

- For instance, replace the cake law of motion by:

$$C_{t+1} = (C_t-c_t)\xi_{t}$$

where $\xi_t\in]0,1]$ is an i.i.d random process

- Then we have: (check)

$$\xi_t {U^{\prime} ( c_t )} = \beta E_t \left[ \xi_{t+1 }U^{\prime} (c_{t+1}) \right]$$



---

### Formalisation

- Set $s_t=(\xi_0, \cdots, \xi_t)$ the history of the exogenous process up to date $t$.


- If $s_t\subset s_{t+1}$, there is a probability of going from $s_t$ to $s_{t+1}$ (successor)

- Then $(s_t)$ replaces $(t=0, t=1, ...)$ as the exogenous state-space. 

- The unknown variables are (fully indexed) $c_{s_t}$, $C_{s_t}$ (and $\lambda_{s_t}$) for all $s_t$.

- The Euler equation would be written:


$$\xi_{s_t} {U^{\prime} ( c_{s_t} )} = \beta E_{s_{t+1}|s_t} \left[ \xi_{s_{t+1} }U^{\prime} (c_{s_{t+1}}) \right]$$

---

### Illustration


---

### Recursivity

So far have looked for an optimal consumption rule $c_t$ different for each $t$ (or $s_t$).

Can we formulate a *decision rule* that depends only on the state today?

- i.e. $c()$ such that $c_t = c(C_t)$

*Yes* if the problem is time-homogenous. In this case, there is a value function $V$ satisfying the Bellman equation:

$$V(C) = \max_{c(C)\in[0,C]} U(c(C)) + \beta V(C-c(C))$$

We have seen techniques to solve this Bellman equation.

- Euler equations can also be used to solve for the "decision rule".
  - time-iteration
  - perturbation analysis around the steady-state


---

### Summary

- The solution to dynamic optimization problem can be characterized by intertemporal first order conditions also known as *Euler conditions*.

- For time-homogenous problems, they characterize a decision rule, where controls to be determined at date $t$ are a function of predetermined states

- Upcoming:
  
    - Real Business Cycles Model: first order conditions
    - Solving first order conditions numerically



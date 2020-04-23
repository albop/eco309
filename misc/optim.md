# Optimization

Optimization algorithms are ubiquitous in economics.

Many economic models are naturally formulated in terms of the optimization of a given objective with respect to the choice of some variable.

- a firm maximizes profit $\pi$ as a function of quantities $q$: $$\max_{q} \pi(q)$$
- a consumer maximizes satisfaction $U(c_1, c_2)$ from consuming two goods $c_1$ and $c_2$

Usually, this maximization problem is associated to a constraint set.
The full consumer problem is then reformulated as

$$\max_{(c_1,c_2)\in\mathcal{B}} U(c_1, c_2)$$

where the budget set is $\mathcal{B} = \left\{ (c_1, c_2) |  p_1 c_1 + p_2 c_2 \leq B \right\}$ where $B$ is the available income.

---

---

## Two main kinds of optimization problem:

- root finding

$$\text{find  $x$ in $X$ such that $f(x)=0$}$$

- minimization/maximization

$$\min_{x\in X} f(x)$$

  - first order condition is a root finding problem but not equivalent
  - kind of equivalent to $f^{\prime}(x)=0$ (with $f^{\prime\prime}(x)>0$

## Variants

- $x$ lives in a continuous state]s
- $x$ lives in a non-convex state
  - mixed programming

-




##


Math formulation:

given a Banach $\mathcal{B}$, given a smooth function $f(x): \mathcal{B}\rightarrow \mathcal{B}$ and a choice set $X\in\mathcal{B}$, we consider the maximization problem:

$$\max_{x\in \mathcal{B}} f(x)$$

We call it a maximization problem because:
1. the notation is not necessarily well defined (if $B$ is not compact for instance)
2. the maximand (where the maximum is attained) is not necessarily unique



Simple case: real

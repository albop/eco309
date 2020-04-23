# Primer on optimization

---

## Introduction

---

### Introduction

Optimization is everywhere in economics:

- to model agent's behaviour: what would a rational agent do?
    - consumer maximizes utility from consumption
    - firm maximizes profit
- an economist tries to solve a model:
    - find prices that clear the market

---

### Two basic kinds of optimization problem:

- root finding: $\text{find  $x$ in $X$ such that $f(x)=0$}$

- minimization/maximization $\min_{x\in X} f(x)$

- often a minimization problem can be reformulated as a root-finding problem

    $$x_0 = {argmin}_{x\in X} f(x) \overbrace{\iff}^{??} f^{\prime} (x_0) = 0$$

---

### Plan

- general consideration about optimization problems
- convergence of recursive series
- one-dimensional root-finding
- one-dimensional optimization  (*)
- local root-finding
- local optimization

---


## General considerations

---

### Optimization tasks come in many flavours

  - continuous versus discrete optimization
  - constrained and unconstrained optimization
  - global and local
  - stochastic and deterministic optimization
  - convexity

---
### Continuous versus discrete optimization


Where is the choice picked from $x\in X$? It can be

- continuous: choose amount of debt $b_t \in [0,\overline{b}]$, of capital $k_t \in R^{+}$
- discrete: choose whether to repay or default $\delta\in{0,1}$, how many machines to buy ($\in N$), at which age to retire...
- a combination of both: mixed integer programming

---

### Continuous versus discrete optimization (2)

Discrete optimization requires a lot of combinatorial thinking. We don't cover it.

Sometimes a discrete choice can be approximated by a mixed strategy (i.e. a random strategy).
Instead of $\delta\in{0,1}$ we choose $prob(\delta=1)=\sigma(x)$ where we determine $x$ and $\sigma(x)=\frac{2}{1+\exp(-x)}$

---

### Constrained and Unconstrained optimization

Unconstrained optimization: $x\in R$

Constrained optimization: $x\in X$

- budget set: $p_1 c_1 + p_2 c_2 \leq I$
- positivity of consumption: $c \geq 0$.

In good cases, the optimization set is *convex*...

- pretty much always in this course

---

### Stochastic vs Determinstic

Common case, especially in machine learning

  $$f(x) = E_{\epsilon}[ \xi (\epsilon, x)]$$

One wants to maximize (resp solve) w.r.t. $x$ but it is costly to compute expectation precisely using Monte-Carlo draws (there are other methods).

A *stochastic* optimization method allows to use noisy estimates of the expectation, and will still converge in expectation.
For now we focus on *deterministic* methods. Maybe later...

---

### Local vs global Algorithms

- In principle, there can be many roots (resp maxima) within the optimization set.

- Alorithm that converge to all of them are called "global". For instance:
  - grid search
  - simulated annealing

- We will deal only with local algorithm, and consider local convergence properties.
  - ->then it might work or not
  - to perform global optimization just restart from different points.

---

### Math vs theory

- The full mathematical treatment will typically assume that $f$ is smooth ($\mathcal{C}_1$ or $\mathcal{C}_2$ depending on the algorithm).

- In practice we often don't know about these properties
  - we still try and check we have a local optimal

- So: fingers crossed

---

### Math vs theory

Here is the surface representing the objective that a deep neural network training algorithm tries to minimize.

![non smooth minimization](graphs/nonsmooth.png){width:50%}

And yet, neural networks do great things!

---

### What do you need to know?

- be able to handcode simple algos (Newton, Gradient Descent)
- understand the general principle of the various algorithms to compare them in terms of
  - robustness
  - efficiency
  - accuracy
- then you can just switch the various options, when you use a library...
  - we'll do that in the tutorial session

---

## Convergence of recursive series

---

### Recursive series

Consider a function $f: R\rightarrow R$ and a recursive series $(x_n)$ defined by $x_0$ and $x_n = f(x_{n-1})$.

We want to compute a fixed point of $f$ and study its properties.

---

### Recursive series

Wait: does a fixed point exist?
- we're not very concerned by the existence problem here

We can assume there is an interval such that $f([a,b])\subset[a,b]$. Then we know there exists $x$ in $[a,b]$ such that $f(x)=x$. But there can be many such points (graph)

---

### Convergence

How do we characterize behaviour around $x$ such that $f(x)=x$?

  - if $|f^{\prime}(x)|>1$: series is unstable and will not converge to $x$ except by chance
  - if $|f^{\prime}(x)|<1$: $x$ is a stable fixed point
  - if $|f^{\prime}(x)|=1$: ??? (look at higher order terms)

---

### Change the problem

Sometimes, we are interested by tweaking the convergence speed:

  $$x_{n+1} = (1-\lambda) x_n + \lambda f(x_n)$$

- $\lambda$ is the learning rate:
  - $\lambda>1$: acceleration
  - $\lambda<1$: dampening

We can also replace the function by another one $g$ such that $g(x)=x\iff f(x)=x$, for instance: $g(x)=x-\frac{f(x)-x}{f^{\prime}(x)-1}$

---

### Dynamics around a stable point
We can write:

$$|x_t - x_{t-1}| \sim |f^{\prime}(x_{t-1})| |x_{t-1} - x_{t-2}| $$


How do we derive an error bound? Suppose that we have $\overline{\lambda}>f^{\prime}(x_k)$ for all $k\geq k_0$:

$$|x_t - x| \leq |x_t - x_{t+1}| + |x_{t+1} - x_{t+2}| + |x_{t+2} - x_{t+3}| + ... $$

$$|x_t - x| \leq \frac{\overline{\lambda}} {1-\lambda} | x_t - x_{t+1} |$$

---

###  How do we improve convergence ?

$$\frac{|x_{t-1} - x_{t-2}|} {|x_t - x_{t-1}|} \sim |f^{\prime}(x_{t-1})|  $$

corresponds to the case of __linear__ convergence (kind of slow).

---
### Aitken's extrapolation

note that

$$\frac{ x_{t+1}-x}{x_t-x} \sim \frac{ x_{t}-x}{x_{t-1}-x}$$

Take $x_{t-1}, x_t$ and $x_{t+1}$ as given and solve for $x$:

$$x = \frac{x_{t+1}x_{t-1} - x_{t}^2}{x_{t+1}-2x_{t} + x_{t-1}}$$

---
### Aitken's extrapolation (2)

or after some reordering

$$x = x_{t-1} - \frac{(x_t-x_{t-1})^2}{x_{t+1}-2 x_t + x_{t-1}}$$

---
### Steffensen's Method:

1. start with a guess $x_0$, compute $x_1=f(x_0)$ and $x_2=f(x_1)$
2. use Aitken's guess for $x^{\star}$.
  If required tolerance is met, stop.
3. otherwise, set $x_0 = x^{\star}$ and go back to step 1.

It can be shown that the sequence generated from Steffensen's method converges __quadratically__, that is

$\lim_{t\rightarrow\infty} \frac{x_{t+1}-x_t}{(x_t-x_{t-1})^2} \leq M$

---

## One-dimensional optimization

---
### Bisection

- Find $x \in [a,b]$ such that $f(x) = 0$. Assume $f(a)f(b) <0$.

- A global algorithm:
  1. Start with $a_n, b_n$. Set $c_n=(a_n+b_n)/2$
  2. Compute $f(c_n)$
    - if $f(c_n)f(a_n)>0$ then set $(a_{n+1},b_{n+1})=(a_n,c_n)$
    - else set $(a_{n+1},b_{n+1})=(c_n,b_n)$
  3. If $f(c_n)<\epsilon$ and/or $(b-a)/2^n<\delta$ stop. Otherwise go back to 1.

---

### Bisection (2)

- $\delta$ is a guaranteed accuracy on $x$
- $\epsilon$ is a measure of how good the solution is
- think about your tradeoff: ($\delta$ or $\epsilon$ ?)

---


### Newton algorithm

Find $x$ such that $f(x) = 0$. Use $x_0$ as initial guess.

- $f$ must be $\mathcal{C_1}$ and we assume we can compute its derivative $f^{\prime}$

- General idea: observe that the zero $x^{\star}$ must satisfy $f(x^{\star})=0=f(x_0)+f^{\prime}(x_0)(x^{\star}-x_0) + o(x-x_0)$. Hence a good approximation should be $x^{\star}\approx = x_0- f(x_0)/f^{\prime}(x_0)$

---

### Newton algorithm (2)

- Algorithm:
  - start with $x_n$
  - compute $x_{n+1} = x_n- f(x_n)/f^{\prime}(x_n)=f^{\text{newton}}(x_n)$
  - stop if $|x_{n+1}-x_n|<\eta$ or $|f(x_n)| < \epsilon$

- Convergence: __quadratic__

---

## Quasi-Newton

- What if we can't compute $f^{\prime}$ or it is expensive to do so?

- Idea: try to approximate $f^{\prime}(x_n)$ from the last iterates

- secant method: $f^{\prime}(x_n)\approx \frac{f(x_n)-f(x_{n-1})}{x_n-x_{n-1}}$
$x_{n+1} = x_n- f(x_n)\frac{x_n-x_{n-1}}{f(x_n)-f(x_{n-1})}$
  - requires two initial guesses

- superlinear convergence: $\lim \frac{x_t-x^{\star}}{x_{t-1}-x^{\star}}\rightarrow 0$

---

- How could Newton method fail?
  - bad guess
    - -> start with a better guess
  - overshoot
    - -> dampen the update
    - -> backtrack
  - stationary point  
    - -> if root of multiplicity $m$ try  $x_{n+1} = x_n- m f(x_n)/f^{\prime}(x_n)$

---

### Backtracking

Simple idea:
  - at stage $n$ given $f(x_n)$ compute Newton step $\Delta=-f(x_n)/f^{\prime}(x_n)$
  - find the smallest $k$ such that $f(x_n-\Delta/2^k)<f(x_n)$
  - set $x_{n+1}=x_n-\Delta/2^k$


---

## One dimensional root-finding

---

### Golden section search

- Minimize $f(x)$ for  $x \in [a,b]$
- Choose $\Phi \in [0,0.5]$

- Algorithm:
  - start with $a_n < b_n$ (initially equal to $a$ and $b$
  - define $c_n = a_n+\Phi(b_n-a_n)$ and $d_n = a_n+(1-\Phi)(b_n-a_n)$
    - if $c_n<d_n$ set $a_{n+1},b_{n+1}=a_n, d_n$
    - else set $a_{n+1}, b_{n+1}= c_n, b_n$

---

### Golden section search (2)

- This is guaranteed to converge to a local minima
- In each step, the size of the interval is reduce by a factor $\Phi$
- By choosing $\Phi=\frac{\sqrt{5}-1}{2}$ one can save one evaluation by iteration.

- Remark that bisection is not enough

---

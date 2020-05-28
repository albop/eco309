# Discretization

---

## Introduction



---

### Several kinds of Discretization


- approximate operator with a finite number of iterations:
    - compute $\int_a^b f(x) dx$
    - compute $E_\omega f(\omega)$
- represent an infinite dimensional object with a finite set of parameters:
    - $f \equiv (f(x_i))_{i=1:N}$ with $x_i=a+\frac{i-1}{N-1}(b-a)$
      - discretize arguments
    - $\omega \equiv (\mu_i, \omega_i)_{i=1:N}$ such that $E_\omega f(\omega) \approx \sum_i \mu_i f(\omega_i)$ (quantization)
- discretize continous process by a discrete one: (today)
  - continuous markov chain to discrete markov Chain

---

## Discretizing an AR1

---

### Discretizing an AR1

- Take $AR1$ process $$x_t = \rho x_{t-1} + \epsilon_t$$
    - with $|\rho| <1$ and $\epsilon \sim N(0,\sigma)$
- Can we replace $(x_t)$ by a discrete markov chain?
    - approximate version:
      - good time $x^g$ and bad time $x^b$. Probability $\pi$ of staying in the same, $1-\pi$ of switching.
    - two systematic methods (available in *QuantEcon.jl*)
        - Tauchen
        - Rouwenhorst

---

### AR1: Tauchen

- The unconditional distribution of an AR1 is a normal law $N(0,\frac{\sigma}{\sqrt{1-\rho^2}})$

- Choose $m>0$, typically $m=3$
- Bound the process: $\underline{x} = -m \frac{\sigma}{\sqrt{1-\rho^2}}$ and $\overline{x} = m \frac{\sigma}{\sqrt{1-\rho^2}}$
- Define the $N$ discretized points ($i\in[1,n]$): $y_i = \underline{x} + \frac{i-1}{N-1}(\overline{x}-\underline{x})$
- Define the transitions:
   $$\begin{aligned}
   \pi_{ij} & = & prob(y_{t+1}=y_j|y_t=y_i)\\
            & = & prob( |y_{t+1}-x_j| = \inf_k |y_{t+1}-x_k| |y_t=y_i)
   \end{aligned}$$


---

### AR1: Tauchen (2)

- Formulas $\delta=(\overline{x}-\underline{x})/N$:

    - if $1<k<N-1$

        $$\pi_{jk} = F(\frac{y_k + \delta/2-\rho y_j}{\sigma_{\epsilon}}) - F(y_k + \delta/2-\rho y_j)$$

    - if $k=1$

        $$\pi_{j} = F(\frac{y_k + \delta/2-\rho y_j}{\sigma_{\epsilon}}) $$

    - if $k=N$

        $$\pi_{j} = 1- F(\frac{y_k - \delta/2-\rho y_j}{\sigma_{\epsilon}}) $$

---

### How to gauge the quality of approximation ?

- compare generated stationary moments between discretized process and true AR1:
  - E(), Var(), ACor()

- by looking at the exact ergodic distribution or by doing some simulations

- not very precise when then process is very persistent $\rho\approx 1$

---

### Rouvenhorst method (1)

- N = 2
  - choose $y_1=-\psi$, $y_2=\psi$
  - define transition matrix:
$$\Theta_2 = \begin{bmatrix}
p & 1-p\\
1-q & q
\end{bmatrix}$$
  - choose $p$, $q$ and $\psi$ to match some moments: $E()$, $Var()$, $ACor()$
    - they can be computed analytically for AR1 and for discretized version.

---

### Rouvenhorst method (2)

- N >2

$$\Theta_N =
p \begin{bmatrix}  
\Theta_{N-1}  & 0\\
0 & 0
\end{bmatrix} +
(1-p) \begin{bmatrix}  
0 & \Theta_{N-1} \\
0 & 0
\end{bmatrix} +
(1-q) \begin{bmatrix}  
0 & 0\\
\Theta_{N-1} & 0
\end{bmatrix} +
q \begin{bmatrix}  
0 & 0\\
0 & \Theta_{N-1}
\end{bmatrix}
$$

- Normalize all lines

---

### Rouvenhorst method (3)

- Procedure converges to Bernouilli distribution.

- Moments can be computed in closed form:

    - $E() = \frac{(q-p)\psi}{2-(p+q)}$
    - $Var() = \psi^2 \left[ 1-4 s (1-s) + \frac{4s(1-s)}{N-1}\right]$
    - $Acor()= p+q-1$

- Rouwenhorst method performs better for highly correlated processes


---

## Discretizing an iid law

---

### Common problem:

- Given $f$, and an iid process $\epsilon \sim N(0,\sigma^2)$, how to approximate
 $E_{\epsilon} f(\epsilon)$ ?

- Ideas:
    - draw *lots* of random $(\epsilon_n)_{n=1:N}$ and compute $$\frac{1}{N}\sum_{n=1}^N f(\epsilon_n)$$
        - aka Monte-Carlo simulations
    - given a method to approximate integrals, compute $$\int_{u=-\infty}^{\infty} f(u) \mu(u) du$$ with $\mu(u)=\frac{1}{\sigma\sqrt{2 \pi}}e^{-\frac{u^2}{2\sigma^2}}$
    - *discretize* (or *quantize*) the signal $\epsilon$ as 
$(w_i, \epsilon_i)_{i=1:N}$ and compute:

$$\frac{1}{N} \sum_n w_n f(\epsilon_n)$$ 

---

### What's wrong with Monte-Carlo Simulations?

- Let's take an exemple: consumption is $C(\epsilon)=U(e^{\epsilon})$ with ${\sigma}_{\epsilon}=0.05$ and $U(x)=\frac{x^{1-\gamma}}{1-\gamma}$ and $\gamma=40$. Let's compute $E_{\epsilon}(C(\epsilon))$ precisely.

- Discuss value of $\gamma$: is it crazy? (risk return)

---

### What's wrong with Monte-Carlo Simulations?

---

### What's wrong with Monte-Carlo Simulations?

Compute distribution


```julia
\sigma = 0.05
\gamma = 40
U(x)=(x^(-γ))/(-γ)
C(e) = U(exp(e))
dis = Normal(0,\sigma)      
E_ϵ(f;N=1000) = sum(f(rand(dis)) for i=1:N)/N
```

---

### What's wrong with Monte-Carlo Simulations?

```
vals = [E_e(C; N=i) for i=1:10000]

stdev(f; N, K) = std(E_e(f; N=N) for k=1:K)
Nvec = [1000, 5000, 10000, 15000, 20000]
sdvals = [stdev(C; N=n, K=10000) for n=[1000, 5000, 10000, 15000, 20000]]
```
---

### Improve the significance of the graphs:

- meaningful units (consumption equivalent)

- choose right axis for the graphs: log, semi-log

---

### Quick theory (1)

- Fact: the sum of several independent gaussian variables is a gaussian  variable

- So $T_N =\frac{1}{N}\sum_{n=1}^N \epsilon_n$ is  gaussian variable. Its mean is 0 (unbiased).  Let's compute its variance:

$$E(T_N^2) = \frac{1}{N^2} \sum_{n=1}^N E\left[ \epsilon_n^2 \right]$$

- The standard deviation is:

$$s_N = \sigma(T_N^2) = \frac{1}{\sqrt{\red{N}}} \sigma_{\epsilon}$$

- Conclusion: the precision of (basic) Monte-Carlo decreases only as a square root of the number of experiments.

---

### Quick theory (2)

- In the general case Monte-Carlo estimator is:

$$T^{MC}_N =\frac{1}{N}\sum_{n=1}^N f(\epsilon_n)$$

- It is unbiased:

$$E(T_N^{MC}) = E\left[f(\epsilon) \right]$$

- It's variance is 
$$E(T_N^{MC}) \propto \frac{1}{\sqrt{N}}$$
    - slow
    - on the plus side: independent on the dimension of $\epsilon$

---

### Quantization using quantiles

- Works for any distribution with pdf and cdf.
- Split the space into equal $N$ quantiles:
  $(I_i=[a_i,a_{i+1}])_{i=1:N}$ such that $prob(\epsilon \in I_i)=\frac{1}{N}$
- Choose the nodes as the median of each interval: $prob(\epsilon\in[a_i,x_i]) = prob(\epsilon\in[x_i,a_{i+1}])$
- The quantization is $(1/N, x_i)_{i=1:N}$

---

### Quantization using quantiles (graph)

[graph]

---

<!-- ### Quadrature rule

Idea:
- $f\in \mathcal{F}$ a Banach space
  - $I: f\rightarrow E_{\epsilon} f(\epsilon)$ is a linear application
- suppose there is a dense family of polynomials $P_n$, spanning $\mathcal{F}_n$
  - $I$ restricted to $\mathcal{F}_N$ is a $N$-dimensional linear form
- take $N$ points $(a_n)_{n\in[1,N]}$. The set $\{f\rightarrow\sum_{n=1}^N w_n f(a_n) | w_1, ... w_N\}$ is a vectorial space.
  - one element matches exactly $\left.I\right|_{\mathcal{F}}$
- so the quadrature rule $(w_n, a_n)$ is exactly accurate for polynomials of order $n<N$.
  - how to choose the points $a_n$?

--- -->

### Gauss-Hermite

- $f\in \mathcal{F}$ a Banach space, $\epsilon$ a gaussian variable
  - $I: f\rightarrow E_{\epsilon} f(\epsilon)$ is a linear application
- suppose there is a dense family of polynomials $P_n$, spanning $\mathcal{F}_n$
  - $I$ restricted to $\mathcal{F}_N$ is a $N$-dimensional linear form
  
- Gauss quadrature magic
  - a way to choose $\epsilon_i$ *and* $w_i$ such that $$\left(f\rightarrow\sum_{n=1}^N w_n f(\epsilon_i) \right)= \left.I\right|_{\mathcal{F}_{2N}}$$

---

### Gauss-*

- Very accurate if a function can be approximated by polynomials
- Bad:
  - imprecise if function $f$ has kinks or non local behaviour
    - points $\epsilon_n$ can be very far from the origin (graph)
  - not super easy-peasy to commute weights and nodes (but there are good libraries)
----

### Gauss-*

- Same logic can be applied to compute integration with weight function $w(x)$: 
  $$\int_a^b f(x) w(x)$$

- Gauss-Hermite:
  - $w(x) = e^{-x^2}$, $[a,b] = [-\infty, \infty]$

- Gauss-Legendre:
  - $w(x) = 1$

- Gauss-Chebychev:
  - $w(x)=\sqrt{1-x^2}$,  $[a,b] = [-1, 1]$
  - for periodic functions

---

### In practice

Beware that weight is not the density of the normal law:

$$\frac{1}{\sqrt{2 \pi \sigma^2}}\int f(x) e^{-\frac{x^2}{2\sigma^2}}dx = \red{\frac{1}{\sqrt{\pi}}}\int f(u \red{\sigma \sqrt{2}}) e^{-{u^2}}du $$
$$\red{\frac{1}{\sqrt{\pi}}}\sum_n w_n f(\epsilon_n \red{\sigma \sqrt{2}})$$

```julia
using FastGaussQuadrature

x, w = gausslegendre( 10 );
x = x.*\sigma*sqrt(2) # renormalize nodes
s = sum( w_*U(exp(x_)) for (w_,x_) in zip(x,
w))
s /= sqrt(\pi) # renormalize output
```


# Convergence of recursive series

## Computational Economics  2021 (ECO309)

Pablo Winant

---

### Life of a computational economist

<div class="r-stack">

<img src="computational_economist.png" class="fragment current-visible">
<video class="fragment" data-autoplay src="waiting_for_convergence.mp4" height=600></video>

</div>

- <!-- .element: class="fragment" --> We spend <strong>a lot</strong> of time waiting for algorithms to converge!
    - <!-- .element: class="fragment" -->solution 1: program better
    - <!-- .element: class="fragment" -->solution 2: better algorithms
    - <!-- .element: class="fragment" -->even better: understand convergence properties (information about the model)


---

### Recursive sequence

Consider a function $f: R^n\rightarrow R^n$ and a recursive sequence $(x_n)$ defined by $x_0$ and $x_n = f(x_{n-1})$.

We want to compute a fixed point of $f$ and study its properties.

---

### Example: growth model

<div class="container">

<div class="col">

- Solow growth model:
  - production:
      $$y_t = k_t^\alpha$$
  - constant saving rate:
    ${\color{red}s_t}$ \in [0,1]
  - consumption:
      $$c_t = (1-{\color{red}s_t})y_t$$
  - capital accumulation:
      $$k_t = {\color{red}s} y_{t-1}$$


<div class="fragment" data-fragment-index="3">

- Solow hypothesis: saving rate is invariant (${\color{red}{s_t}}={\color{red}s}$)
  $$k_t = f(k_{t-1}, {\color{red}s} )$$
- __backward-looking__ iterations

</div>


</div>

<div class="col">

<img class="fragment" src="solow.png" width=60% data-fragment-index=2>

<div class="fragment">

- Economic Questions: 
  - What is the steady-state?
  - Can we characterize the transition back the steady-state?
  - Characterize the dynamics close to the steady-state?
    - next session
  - what is the optimal $s$ ?

</div>

</div>

</div>

---

### Another example: asset pricing

- Consider an asset yielding dividends $d_0, ... , d_n, ...$
- With discount rate $\frac{1}{r}$, the value of holding this asset is:
  $$p_0 = \mathbb{E}\_{0} \sum\_{t \geq 0} \frac{1}{r^t} d_t$$
- We can rewrite for any $t$
$$p\_t = d\_t + \frac{1}{r} \mathbb{E}\_t p\_{t+1}$$
  - price of an asset depends on its immediate divident and its resell value
- The price today depends on the price tomorrow $p_t = \mathcal{T}(p_{t+1})$
  - $\mathcal{T}$ is the __time iteration operator__ a.k.a. __Coleman iterator__
  - we will iterate back-in-time $p_{n+1} = f(p_n) = \mathcal{T}(p_n)$


---


### Recursive series (2)



<div class= "container">

<div class="col">

<!-- TODO: rephrase -->
- Wait: does a fixed point exist?
    - we're not very concerned by the existence problem here
    - if the algorithm converges, we'll take it as a "computational proof" of existence
- In theory, we can assume there is an interval such that $f([a,b])\subset[a,b]$. Then we know there exists $x$ in $[a,b]$ such that $f(x)=x$. 
    - for advanced applications the trick is to find the right fixed-point theorem...
- But there can be many such points.
- As for unicity it depends on the applicaitions:
  - in some particular cases, we can prove it
  - we'll be happy with local conditions (existence, uniqueness) *around* a solution
- 
</div>

<div class="col">


- In the growth model, if we change the production function: $y=k^{\alpha}$
for a nonconvex/nonmonotonic one, we can get multiple fixed points.


![](growth_multiple_equilibria.jpg)

</div>

</div>

---


### Local Stability

- How do we characterize behaviour of sequence $x_n = f(x_{n-1})$ around $x$ such that $f(x)=x$?
    - <!-- .element class="fragment" data-fragment-index="2" --> if $|f^{\prime}(x)|>1$: series is unstable and will not converge to $x$ except by chance
    - <!-- .element class="fragment" data-fragment-index="2" --> if $|f^{\prime}(x)|<1$: $x$ is a stable fixed point
    - <!-- .element class="fragment" data-fragment-index="2" --> if $|f^{\prime}(x)|=1$: ??? (look at higher order terms)
- <!-- .element class="fragment" data-fragment-index=2 -->This is true for real valued sequences
- <!-- .element class="fragment" data-fragment-index=2 -->Also for vector valued sequences
  - if $|f^{\prime}(x)|$ is replaced by $\rho(f^{\prime}(x))$ ...
  - ... where $\rho(x)$ is the spectral radius of x (or the biggest eigenvalue)


---



### Dynamics around a stable point

- We can write successive approximation errors:
$$\begin{eqnarray}|x_t - x_{t-1}| & = &  | f(x_{t-1}) - f(x_{t-2})| \\\\
|x_t - x_{t-1}| & \sim & |f^{\prime}(x_{t-1})| |x_{t-1} - x_{t-2}|\end{eqnarray}$$
- Ratio of successive approximation errors
$$\lambda_t =  \frac{ |x_{t} - x_{t-1}| } { |x_{t-1} - x_{t-2}|}$$
$$\lambda_t \rightarrow f^{\prime}(\overline{x})$$
- Successive approximation errors decrease geometrically

---

### Dynamics around a stable point (2)

- How quickly do we approach the target?
- Can we derive an error bound?
- Suppose that we have $\overline{\lambda}>|f^{\prime}(x_k)|$ for all $k\geq k_0$:
$$\begin{eqnarray}
|x_t - x| & \leq & |x_t - x_{t+1}| + |x_{t+1} - x_{t+2}| + |x_{t+2} - x_{t+3}| + ... \\\\
|x_t - x| & \leq & |x_t - x_{t+1}| + |f(x_{t}) - f(x_{t+1})| + |f(x_{t+1}) - f(x_{t+2})| + ... \\\\
|x_t - x| & \leq & |x_t - x_{t+1}| + \overline{\lambda} |x_t - x_{t+1}| + \overline{\lambda}^2 |x_t - x_{t+1}| + ... \\\\
|x_t - x| & \leq & \frac{1} {1-\overline{\lambda}} | x_t - x_{t+1} |
\end{eqnarray}$$
- Convergence is geometric

---

### Convergence speed

- Rate of convergence of series $x_t$ towards $x^{\star}$ is said to be:
    - __linear__ (aka geometric) if
    $${\lim}\_{t\rightarrow\infty} \frac{|x_{t+1}-x^{\star}|}{|x_{t}-x^{\star}|} = \mu \in R^+$$
    - __superlinear__ if
    $${\lim}\_{t\rightarrow\infty} \frac{|x_{t+1}-x^{\star}|}{|x_{t}-x^{\star}|} = 0$$
    - __quadratic__ if
    $${\lim}\_{t\rightarrow\infty} \frac{|x_{t+1}-x^{\star}|}{|x_{t}-x^{\star}|^{\color{red}2}} = \mu \in R^+$$

- In practice: linear is *slow*, while quadratic is *fast*

---

### Convergence speed

Remark: in the case of linear convergence:

$${\lim}\_{t\rightarrow\infty} \frac{|x\_{t+1}-x\_t|}{|x\_{t}-x\_{t-1}|} = \mu \in R^+ \iff {\lim}\_{t\rightarrow\infty} \frac{|x\_{t+1}-x^{\star}|}{|x\_{t}-x^{\star}|}=\frac{1}{1-\mu}$$


---

### Change the problem

- Sometimes, we are interested in tweaking the convergence speed:
$$x_{n+1} = (1-\lambda) x_n + \lambda f(x_n)$$
  - $\lambda$ is the learning rate:
      - $\lambda>1$: acceleration
      - $\lambda<1$: dampening
- We can also replace the function by another one $g$ such that $g(x)=x\iff f(x)=x$, for instance:
$$g(x)=x-\frac{f(x)-x}{f^{\prime}(x)-1}$$
- These transformation 
  - can improve / slow-down convergence
  - or change convergence properties (here $g$ is the Newton-Raphson step)
- There are some other specialized methods for the 1d case

---

### Aitken's extrapolation

- Consider a convergent recursive sequence $x_t = f(f_{t-1})$
- Note that
$$\frac{ x_{t+1}-x}{x_t-x} \sim \frac{ x_{t}-x}{x_{t-1}-x}$$
- Take $x_{t-1}, x_t$ and $x_{t+1}$ as given and solve for $x$:
$$x = \frac{x_{t+1}x_{t-1} - x_{t}^2}{x_{t+1}-2x_{t} + x_{t-1}}$$
- or after some reordering

$$x = x_{t-1} - \frac{(x_t-x_{t-1})^2}{x_{t+1}-2 x_t + x_{t-1}}$$

---

### Aitken's Steffensen's Method:


- Aitken-Steffensen method to compute the limit of a sequence:
  1. start with a guess $x_0$, compute $x_1=f(x_0)$ and $x_2=f(x_1)$
  2. use Aitken's guess for $x^{\star}$.
    If required tolerance is met, stop.
  3. otherwise, set $x_0 = x^{\star}$ and go back to step 1.
- It can be shown that, if $x_n$ converges *geometrically* the sequence generated from Steffensen's method converges *quadratically*, that is
$$\lim_{t\rightarrow\infty} \frac{x_{t+1}-x_t}{(x_t-x_{t-1})^2} \leq M$$

---

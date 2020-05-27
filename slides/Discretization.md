# Discretization

---


## Several kinds of Discretization


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

- Take $AR1$ process $$x_t = \rho x_{t-1} + \epsilon_t$$
    - with $|\rho| <1$ and $\epsilon \sim N(0,\sigma)$
- Can we replace $(x_t)$ by a discrete markov chain?
    - two methods
        - Tauchen
        - Rouwenhorst

---

## AR1: Tauchen

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

## AR1: Tauchen (2)

- Formulas $\delta=(\overline{x}-\underline{x})/N$:

    - if $1<k<N-1$

        $$\pi_{jk} = F(\frac{y_k + \delta/2-\rho y_j}{\sigma_{\epsilon}}) - F(y_k + \delta/2-\rho y_j)$$

    - if $k=1$

        $$\pi_{j} = F(\frac{y_k + \delta/2-\rho y_j}{\sigma_{\epsilon}}) $$


    - if $k=N$

        $$\pi_{j} = 1- F(\frac{y_k - \delta/2-\rho y_j}{\sigma_{\epsilon}}) $$

---

## How to gauge the quality of approximation ?

- compare generated stationary moments between discretized process and true AR1:
  - E(), Var(), ACor()

- by looking at the exact ergodic distribution or by doing some simulations

- not very precise when then process is very persistent $\rho\approx 1$

---

## Rouvenhorst method (1)

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

## Rouvenhorst method (2)

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

## Rouvenhorst method (3)

- Procedure converges to Bernouilli distribution.

- Moments can be computed in closed form:

    - $E() = \frac{(q-p)\psi}{2-(p+q)}$
    - $Var() = \psi^2 \left[ 1-4 s (1-s) + \frac{4s(1-s)}{N-1}\right]$
    - $Acor()= p+q-1$

- Rouwenhorst method performs better for highly correlated processes

---

# Interpolation

---

##

---

### Basics

Two continuous sets $X\in R^p$, $Y \in R^q$.


Data set: $(x_i, y_i)_{i\in[1,N]} \in X \times Y$

Take $\tilde{x} \in X \setminus \{x_i\}_{i\in[1,N]}$. What should be the matching $\tilde{y}$ ?


Discover implicit relation $y=f(x)$ (the model) then compute $\tilde{y}=f(\tilde{x})$.

$f$ is chosen from a family $\mathcal{F} =\{f(.:\theta)\}_\theta$, the approximation family.


---

### Interpolation vs. Regression

- _Interpolation_: $f$ is chosen such that $\forall n, y_n=f(x_n)$
    - family ${f_{\theta}}$ is interpolating if $\forall n, \exists f \in \mathcal{F}, f(x_n)= y_n$
- _Regression_: $f$ is chosen so as to minimize a fitness criterium such as
    - $\min_f \sum_n \left( y_n-f(x_n) \right)^2$
    - or $\min_{\theta} \sum_n \left( y_n-f(x_n;\theta) \right)^2 + \lambda  || \theta ||^2$ with $\lambda>0$
- Remarks:
    - some applied mathematicians tend to mix the two (interpolate=evaluate f outside of X)

---

### Examples (1): Linear Interpolation

1d Graph. Join the dots. Linear/Spline

2d Graph: Regression

Conclusion: interpolate only if $f$ is known precisely on $X$

---

### Example (2): 

---

### Why do we need it?


In economics, we often solve a problem $\Phi(f)=0$ where $f$ is a function. Or $\forall s, \Phi(f)(s) = 0$

To represent a function by a finite number of parameters: approximation space $

---

### Local vs Spectral
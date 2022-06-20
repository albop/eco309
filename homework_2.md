# Homework 2


- Choose a country. Download data for production, investment, consumption at quarterly frequency using dBnomics or any other method.
- Describe the data briefly (source, the spanning period, ...)
- Detrend the data using the HP filter with the appropriate smoothing parameter $\lambda$. For each series $y_t$ it yields a decomposition between the trend $\tau_t$ and the cycle $c_t$.
- Plot for each series, the decomposition between trend and cycle.
- For each series compute the log-deviation $d_t =log(c_t/ \tau_t)$.
- Compute standard-deviations and correlations, between all three detrended series. Compute the ratio between the standard deviation of consumption (resp investment) and that of output. These two statistics are the ones that will be compared with the predictions of the model.


## Solving the RBC model

We consider the RBC model as in the lectures. The representative agent maximizes utility from consumption $c_t$ and labour $l_t$:

$$\max \sum_t \beta^t  \left( \frac{c^{1-\gamma}}{1-\gamma} + \chi \frac{(1-l_t)^{1-\eta}}{1-\eta} \right)$$

The capital is accumulated according to the following law of motion:

$$k_t = (1-\delta) k_{t-1} + i_{t-1}$$

where $\delta$ is the depreciation rate and $i_t$ is the investment.
The productive sector combines labour and capital to produce:

$$y_t = \exp(z_t) k_t^{\alpha} l_t^{1-\alpha}$$

with $z_t = \rho z_{t-1} + \epsilon_t$ being an autoregressive productivity process driven by i.i.d. shock $\epsilon_t$ (with standard deviation $\sigma_\epsilon$).

The budget constraint is 

$$y_t = c_t + i_t$$


__Math: What are the states (s) ? The controls (x) ? The shocks (e) ?__


__Math: Write down the first order conditions for the model. What are the two transition (g) equations such that $s_t = g(s_{t-1},x_{t-1},e_t)$ ? The two arbitrage (f) equations such that $f(s_t, x_t, s_{t+1}, x_{t+1})=0$ ?__


__Math: Write down the conditions pinning down the steady-state of the model, given that $\chi$  in order to satisfy: $\overline{l}=\frac{1}{3}$.__


In the following questions you are expected to take the code from the `neoclassical.ipynb` notebook in order to adapt it to your need. In doing so, feel free to add comments and docstrings to the code.


__Create a structure holding the parameters and the steady-state values of the model. Choose and justify briefly a *quarterly* parameterization.__

__Define the transition and arbitrage functions. Check that they are compatible with steady-state values.__

__Differentiate all equations to get the first order representation of the model.__

__Apply the time-iteration algorithm to find a solution $X$ for the controls. It approximates controls as a function of the states $\Delta x_t = X \Delta s_t$ (where $\Delta$ is the deviation from the steady-state). Check that $X$ satifsfies indeed the first order model.__


__Compute matrices $P$ and $Q$ for the states so that the evolution of states is given by $\Delta s_t = P \Delta s_{t-1}  + Q e_t$__

__Check that the model is well defined, that is, that it satisfies the forward and backward stability conditions.__

__Write a method to make stochastic simulations of the model starting from the steady-state. Your function should use, the calibration structure and the matrices `P` and `Q` defined above. Add an option to compute the series either in deviations to the steady-state or in levels.__

__Compute 200 random draws of the model over a 40 periods horizon. For each draw, perform the same steps as in the first part (hp filter, computation of the correlations). Compare the ratio of volatility investment/output and consumption/output both in the data and in the simulated model. Comment?__









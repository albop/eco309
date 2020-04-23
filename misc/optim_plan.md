

#  Fixed point methods and convergences measures

- idea for exercise:
  -
  - fractal


# Duality optimization/root-finding

- equivalence
- from constrained maximization to complementarity problems
  - can be reformulated as smooth problem
  - with Fisher-Burmeister functions (or min/max)


# Root-finding problem

- global
- local
  - Newton method
  - quasi-Newton
  - Newton + back-step
  - Newton + line-search
- constrained
  - LCP
  -


# One dimensional minimization

- bisection
- golden search





# Optimization: introduction

- optimization flavours
  - continuous versus discrete optimization
  - constrained and unconstrained optimization
  - global and local
  - stochastic and deterministic optimization
  - convexity

- algorithms
  - robustness
  - efficiency
  - accuracy

- fundamentals of unconstrained optimization
  - types of minimizers
    - global minimizer
    - local minimizer
    - strict local minimizer

  - recognizing a local minimum:
    - first order condition
    - second order condition

  - nonsmooth problems
    - theory complicated : subgradient or generalized gradient
    - we do it in practice (cf NN graph)

- unconstrained line search

  - all unconstrained algorithms require initial point $x_0$
  - two strategies:
    - line-search
      - optimal direction
      - then 1d search
    - trust-region
      - choose region and local model
      - minimize under constraint

  - scaling

- line search methods

  - basically 1d minimization
  - not needed to be optimal
    - weaker conditions: Wolfe, Armijio
  - convergence properties:
    - general theorem
  - rate of convergence
    - steepest descent (a.k.a. Gradient descent)
      - linear
      - but not to be discarded so easily...
    - Newton's method
      - quadratic
    - quasi-Newton
      - a bit less than quadratic
    - modified Newton

- trust-region methods
  ...
  ... not covered

- optimization (1)
- stochastic gradient

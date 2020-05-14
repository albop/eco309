# Differentiation

---

## Main approaches

0. Manual
1. Finite Differences
2. Symbolic Differentiation
3. Automatic Differentiation

---

## Manual Differentiation

- Trick:
    - never use $\frac{d}{dx} \frac{u(x)}{v(x)} = \frac{u'(x)v(x)-u(x)v'(x)}{v(x)^2}$
    - use instead $$\frac{d}{dx} {u(x)v(x)} = {u'(x)v(x)+u(x)v'(x)}$$ and $$\frac{d}{dx} u(x) = \frac{1}{u(x)^2}$$
- Just kidding. 

---



<!-- pandoc -t beamer differentiation.md --pdf-engine=xelatex -s -o differentiation.pdf -->

## Finite Differences

- Choose small $\epsilon>0$, typically $\sqrt{ \textit{machine eps}}$

- Forward Difference scheme:
    -  $f'(x) \approx \frac{f(x+\epsilon) - f(x)}{\epsilon}$
    - precision: $o(\epsilon)$
    - bonus: if $f(x+\epsilon)$ can compute $f(x)-f(x-\epsilon)$ instead (Backward)

- Central Difference scheme:
    -  $f'(x) \approx \frac{f(x+\epsilon) - f(x-\epsilon)}{2\epsilon}$
    - average of forward and backward
    - precision: $o(\epsilon^2)$

---

## Finite Differences: Higher order 

- Central formula:
$$\begin{aligned}
f''(x) & \approx & \frac{f'(x)-f'(x-\epsilon)}{\epsilon} \approx \frac{(f(x+\epsilon))-f(x))-(f(x)-f(x-\epsilon))}{\epsilon^2}  \\ & = & \frac{f(x+\epsilon)-2f(x)+f(x-\epsilon)}{\epsilon^2}
\end{aligned}$$
    - precision: $o(\epsilon)$
- Generalizes to higher order but becomes more and more innacurate

---

## Symbolic Differentiation

- manipulate the tree of algebraic expressions
    - implements various simplification rules
- requires mathematical expression
- can produce mathematical insights
- sometimes inaccurate:
  - cf: $\left(\frac{1+u(x)}{1+v(x)}\right)$

---

## Julia Packages:


- *Calculus.jl*:
    - pure julia
    - finite difference
    - symbolic calculation
- *FiniteDiff.jl*, *FiniteDifferences.jl*, *SparseDiffTools.jl*
    - careful implementation of finite diff
- *SymEngine.jl*
    - fast symbolic calculation

---

## Automatic Differentiation

- does not provide mathematical insights but solves the other problems

- can differentiate any piece of code
- two flavours
    - forward accumulation
    - reverse accumulation

---

## Simple example:

```julia
function f(x::Float64, y::Float64)
    a = x + 1
    b = y^2
    c = sin(a) + a + b
end
```
---

## Automatic rewrite: source code transform

```julia
function f(x::Float64)
    
    # x is an argument
    x_dx = 1.0

    a = x + 1
    a_dx = x_dx

    b = x^2
    b_dx = 2*x*x_dx

    t = sin(a)
    t_x = cos(a)*a_dx

    c = t + b
    c_x = t_dx + b_dx

    return (c, c_x)
end
```

---

## Dual numbers: operator overloading

```julia
struct DN
    x::Float64
    dx::Float64
end

+(a::DN,b::DN) = DN(a.x+b.x, a.dx+b.dx)
-(a::DN,b::DN) = DN(a.x-b.x, a.dx-b.dx)
*(a::DN,b::DN) = DN(a.x*b.x, a.x*b.dx+a.dx*b.x)
/(a::DN,b::DN) = DN(a.x/b.x, (a.dx*b.x-a.x*b.dx)/b.dx^2)

...
```

---

## Compatible with control flow 

```julia
import ForwardDiff: Dual

x = Dual(1.0, 1.0)
a = 0.5*x
b = sum([(x)^i/i*(-1)^(i+1) for i=1:5000])
# compare with log(1+x)
```
  - generalizes nicely to gradient computations

```julia
x = Dual(1.0, 1.0, 0.0)
y = Dual(1.0, 0.0, 1.0)
exp(x) + log(y)
```

---

## Forward Accumulation Mode

- Forward Accumulation mode: isomorphic to dual number calculation
  - compute tree with values and derivatives at the same time
  - efficient for $f: R^n\rightarrow R^m$, with $n<<m$
    - (keeps lots of empty gradients when $n>>m$)

---

## Reverse Accumulation Mode

- Reverse Accumulation / Back Propagation
    - efficient for $f: R^n\rightarrow R^m$, with $m<<n$
    - requires data storage (to keep intermediate values)
    - graph / example

- Very good for machine learning:
   - $\nabla_{\theta} F(x;\theta)$ where $F$ can be an objective

---


## Libraries for AutoDiff

- See JuliaDiff: http://www.juliadiff.org/
  - *ForwardDiff.jl*
  - *ReverseDiff.jl*
- *Zygote.jl*
- Deep learning framework:
  - higher order diff w.r.t. any vector -> tensor operations
  - Flux.jl, MXNet.jl, Tensorflow.jl

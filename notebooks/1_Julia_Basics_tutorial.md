---
jupyter:
  jupytext:
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.2'
      jupytext_version: 1.4.2
  kernelspec:
    display_name: Julia 1.3.1
    language: julia
    name: julia-1.3
---

# Computational Economics  (ECO288)

## Julia Basics


### What is Julia

- developped at MIT on top of opensource technologies
    - linux / git / llvm
- syntax inspired by Matlab but:
    - more consistent
    - lots of features from high level languages
- everything is JIT-compiled
    - interpreted vs compiled treadeoff
    - -> very fast
    - most of the base library is written in Julia
- opensource/free + vibrant community



Some useful links from QuantEcon:

* [Julia cheatsheet](https://cheatsheets.quantecon.org/julia-cheatsheet.html)
* [Julia-Matlab comparison](https://cheatsheets.quantecon.org/index.html)
* [Julia essentials](https://lectures.quantecon.org/jl/julia_essentials.html)
* [Vectors, arrays and matrices](https://lectures.quantecon.org/jl/julia_arrays.html)

Excellent resources at: [julialang](https://julialang.org/learning/)
- checkout JuliaAcademy, it's free


### an example of what you shouldn't do in Matlab

How I learnt: interpreted code is slow, so vectorize your coe.

```julia
function stupid_loop(I,J,K)
    t = 0.0
    for i=1:I
        for j=1:J
            for k = 1:K
                t += 1.0
            end        
        end
    end
    return t
end
@time [ stupid_loop(1000,1000,i) for i =1:10]
```

Code is translated to LLVM code then to instructions for the processor. Note that processor instructions are shorter than LLVM code.

```julia
@code_llvm stupid_loop(10,10,10)
```

```julia
@code_native stupid_loop(10,10,10)
```

### Syntax Review


#### Variable assignment

Assignement operator is = (equality is ==, identity is ===)

```julia
# Assign the value 10 to the variable x
x = 10
```

```julia
2 == 3
```

```julia
# Variable names can have Unicode characters
# To get ϵ in the REPL, type \epsilon<TAB>
ϵ = 1e-4
```

Default semantic is pass-by-reference:

```julia
a = [1,2,3,4]
b = a
a[1] = 10
b
```

To work on a copy: `copy` or `deepcopy`

```julia
a = [1,2,3,4]
b = copy(a)
a[1]=10
b
```

```julia
a .== b
```

```julia
a === b
```

```julia

```

#### Basic types

```julia

```

```julia
# for any object `typeof` returns the type
?typeof
```

```julia
typeof(a)
```

#### Numbers

```julia
y = 2 + 2
```

```julia
-y
```

```julia
0.34*23
```

```julia
3/4
```

```julia
# Scalar multiplication doesn't require *
3(4 - 2)
```

```julia
x = 4
2x
```

```julia
typeof(x)
```

```julia
sizeof(a)
```

#### Booleans


Equality

```julia
0 == 1
```

```julia
2 != 3
```

```julia
3 <= 4
```

Identity

```julia
a = [34, 35]
b = [34, 35]
c = a
```

```julia
c === a
```

```julia
b === a
```

Boolean operator

```julia
true && false
```

```julia
true || false
```

```julia
!true
```

#### Strings

```julia
# Strings are written using double quotes
str = "This is a string"
```

```julia
ch = 'k' # this is a character
```

```julia
# Strings can also contain Unicode characters
fancy_str = "α is a string"
```

```julia
# String interpolation using $
# The expression in parentheses is evaluated and the result is 
# inserted into the string
a = 2+2
"2 + 2 = $(a)"
```

```julia
println("It took me $(a) iterations")
```

```julia
# String concatenation using *
"hello" * "world"
```

```julia
println("hello ", "world")
```

#### Arrays


Julia has one-dimensional arrays. They are also called Vector.

```julia
A = [1, 2]
```

```julia
typeof(A) == Vector{Int64}
```

```julia
A''
```

2d arrays are also called matrices... and can be used for matrix multiplications.

```julia
a1 = [1,2,3,4]
a2 = [1,2,3,4].+4
[a1; a2]
cat(a1, a2; dims=1)
```

```julia
b = [1 0.6 0]
```

```julia
B = [0.1 0.2 0.3; 4 5 6]
```

```julia
B*B'
```

Vectorized operations take a ., even comparisons:

```julia
B.*B .< B
```

```julia
f(x) = x^2+1
```

```julia
f(43)
```

```julia
f.(B)
```

Elements are always accessed with square brackets:

```julia
B[:,1]
```

```julia
B[:,1:end-1]
```

#### Control flow


Conditions

```julia
x = -3
if x < 0
    println("x is negative")
elseif x > 0 # optional and unlimited
    println("x is positive")
else         # optional
    println("x is zero")
end
```

While

```julia
i = 3
while i > 0
    println(i)
    i = i - 1
end
```

For loops

```julia
# Iterate through ranges of numbers
for i = 1:3
    println(i)
end
```

```julia
# Iterate through arrays
cities = ["Boston", "New York", "Philadelphia"]
for city in cities
    println(city)
end
```

```julia
cities
```

```julia
states
```

```julia
collect( zip(cities, states) )
```

```julia
# Iterate through arrays of tuples using zip
states = ["MA", "NY", "PA"]
for (city, state) in zip(cities, states)
    println("$city, $state")
end
```

```julia
# Iterate through arrays and their indices using enumerate
for (i, city) in enumerate(cities)
    println("City $i is $city")
end
```

#### List comprehensions

```julia
[i^2 for i=1:10]
```

```julia
[i^2 for i=1:10 if mod(i,2)==0]
```

### Data Types and multiple dispatch


#### Composite types

A **composite type** is a collection of named fields that can be treated as a single value. They bear a passing resemblance to MATLAB structs.

All fields must be declared ahead of time. The double colon, `::`, constrains a field to contain values of a certain type. This is optional for any field.

```julia
# Type definition
struct Parameter
    value::Float64
    transformation::Function # Function is a type!
    tex_label::String
    description::String
end
```

When a type with $n$ fields is defined, a constructor (function that creates an instance of that type) that takes $n$ ordered arguments is automatically created. Additional constructors can be defined for convenience.

```julia
# Creating an instance of the Parameter type using the default
# constructor
β = Parameter(0.9, identity, "\beta", "Discount rate")
```

```julia
# Alternative constructors end with an appeal to the default
# constructor
function Parameter(value::Float64, tex_label::String)
    transformation = identity
    description = "No description available"
    return Parameter(value, transformation, tex_label, description)
end

α = Parameter(0.5, "\alpha")
```

Now the function `Parameter` has two different `methods` with different signatures:

```julia
methods(Parameter)
```

```julia
fun(x::Int64, y::Int64) = x^3 + y
```

```julia
fun(x::Float64, y::Int64) = x/2 + y
```

```julia
fun(2, 2)
```

```julia
fun(2.0, 2)
```

```julia
# Find the fields of an instance of a composite type
fieldnames(α)
```

```julia
α.tex_label
```

```julia
# Access a particular field using .
α.value
```

```julia
# Fields are modifiable and can be assigned to, like 
# ordinary variables
α.value = 0.75
```

### Parameterized Types

**Parameterized types** are data types that are defined to handle values identically regardless of the type of those values.

Arrays are a familiar example. An `Array{T,1}` is a one-dimensional array filled with objects of any type `T` (e.g. `Float64`, `String`).

```julia
# Defining a parametric point
struct Duple{T} # T is a parameter to the type Duple
    x::T
    y::T
end
```

This single declaration defines an unlimited number of new types: `Duple{String}`, `Duple{Float64}`, etc. are all immediately usable.

```julia
sizeof( Duple(3.0, -15.0) )
```

```julia
Duple("Broadway", "42nd St")
```

```julia
# What happens here?
Duple(1.5, 3)
```

We can also restrict the type parameter `T`:

```julia
# T can be any subtype of Number, but nothing else
struct PlanarCoordinate{T<:Number}
    x::T
    y::T
end
```

```julia
PlanarCoordinate("4th Ave", "14th St")
```

```julia
PlanarCoordinate(2//3, 8//9)
```

### Why Use Types?


You can write all your code without thinking about types at all. If you do this, however, you’ll be missing out on some of the biggest benefits of using Julia.

If you understand types, you can:

- Write faster code
- Write expressive, clear, and well-structured programs (keep this in mind when we talk about functions)
- Reason more clearly about how your code works

Even if you only use built-in functions and types, your code still takes advantage of Julia’s type system. That’s why it’s important to understand what types are and how to use them.

```julia
# Example: writing type-stable functions
function sumofsins_unstable(n::Integer)  
    sum = 0  
    for i in 1:n  
        sum += sin(3.4)  
    end  
    return sum 
end  

function sumofsins_stable(n::Integer)  
    sum = 0.0  
    for i in 1:n  
        sum += sin(3.4)  
    end  
    return sum 
end

# Compile and run
sumofsins_unstable(Int(1e5))
sumofsins_stable(Int(1e5))
```

```julia
@time sumofsins_unstable(Int(1e5))
```

```julia
@time sumofsins_stable(Int(1e5))
```

In `sumofsins_stable`, the compiler is guaranteed that `sum` is of type `Float64` throughout; therefore, it saves time and memory. On the other hand, in `sumofsins_unstable`, the compiler must check the type of `sum` at each iteration of the loop. Let's look at the LLVM [intermediate representation](http://www.johnmyleswhite.com/notebook/2013/12/06/writing-type-stable-code-in-julia/).


### Multiple Dispatch


So far we have defined functions over argument lists of any type. Methods allow us to define functions “piecewise”. For any set of input arguments, we can define a **method**, a definition of one possible behavior for a function.

```julia
# Define one method of the function print_type
function print_type(x::Number)
    println("$x is a number")
end
```

```julia
# Define another method
function print_type(x::String)
    println("$x is a string")
end
```

```julia
# Define yet another method
function print_type(x::Number, y::Number)
    println("$x and $y are both numbers")
end
```

```julia
# See all methods for a given function
methods(print_type)
```

Julia uses **multiple dispatch** to decide which method of a function to execute when a function is applied. In particular, Julia compares the types of _all_ arguments to the signatures of the function’s methods in order to choose the applicable one, not just the first (hence "multiple").

```julia
print_type(5)
```

```julia
print_type("foo")
```

```julia
print_type([1, 2, 3])
```

#### Other types of functions

Julia supports a short function definition for one-liners

```julia
f(x::Float64) = x^2.0
f(x::Int64) = x^3
```

As well as a special syntax for anonymous functions

```julia
u->u^2
```

```julia
map(u->u^2, [1,2,3,4])
```

### Writing Julian Code

As we've seen, you can use Julia just like you use MATLAB and get faster code. However, to write faster and _better_ code, attempt to write in a “Julian” manner:

- Define composite types as logically needed
- Write type-stable functions for best performance
- Take advantage of multiple dispatch to write code that looks like math
- Add methods to existing functions


### Just-in-Time Compilation


How is Julia so fast? Julia is just-in-time (JIT) compiled, which  means (according to [this StackExchange answer](http://stackoverflow.com/questions/95635/what-does-a-just-in-time-jit-compiler-do)):

> A JIT compiler runs after the program has started and compiles the code (usually bytecode or some kind of VM instructions) on the fly (or just-in-time, as it's called) into a form that's usually faster, typically the host CPU's native instruction set. _A JIT has access to dynamic runtime information whereas a standard compiler doesn't and can make better optimizations like inlining functions that are used frequently._

> This is in contrast to a traditional compiler that compiles all the code to machine language before the program is first run.

In particular, Julia uses type information at runtime to optimize how your code is compiled. This is why writing type-stable code makes such a difference in speed!


## Additional Exercises

Taken from QuantEcon's [Julia Essentials](https://lectures.quantecon.org/jl/julia_essentials.html) and [Vectors, Arrays, and Matrices](https://lectures.quantecon.org/jl/julia_arrays.html) lectures.

1. Consider the polynomial $$p(x) = \sum_{i=0}^n a_0 x^0$$ Using `enumerate`, write a function `p` such that `p(x, coeff)` computes the value of the polynomial with coefficients `coeff` evaluated at `x`.

2. Write a function `solve_discrete_lyapunov` that solves the discrete Lyapunov equation $$S = ASA' + \Sigma \Sigma'$$ using the iterative procedure $$S_0 = \Sigma \Sigma'$$ $$S_{t+1} = A S_t A' + \Sigma \Sigma'$$ taking in as arguments the $n \times n$ matrix $A$, the $n \times k$ matrix $\Sigma$, and a number of iterations.

# Advanced Julia

---

## Code Management, Modules, Packages

- julia script files
- `include` command

---

### Module

- declaration
- import
- overload

---

### Modules and submodules

---

### Package

- a module in `src/

- a `Project.toml` file:
    - lists software dependencies
- install scripts

---

### Project management

- `Project.toml`: not restricted to packages
- `Julia] activate .`: activate project (in current directory)
    - will fetch dependencies
    - will record added dependencies
- Very useful for reproducible research.


---

### Package management

---

## Type system

---

### Basic Type

- numbers: Int64, Float64
- characters:
- string:
- symbols: 

---

### Basic Parametric Types

- list
- tuple
- dict
- OrderedDict

---

### Abstract vs Concrete Type

- one cannot derive from a concrete type
- there is an abstract type hierarchy
- sometimes, if you want to subclass you need to create an abstract type first

---

### Inheritance

Variant vs contravariant

---

## Metaprogramming

---

### Symbolic Tree

---

### Abstract Symbolic Tree

- a program is a special kind of tree
    - example with `Meta.parse, dump`: expression, function, for loop

---

### Manipulating AST with Julia

- AST can be represented with Julia structures: Julia is "homoiconic"
- to manipulate an expression: `quote`, `:()`
- to vizsualize: `dump`
- to unquote: `$(...)` (like in a string)
- to evaluate an expression: `eval()`

---

### Examples

---

### Macros

- macros take a block of code, manipulate it and evaluate the result
- they are defined with:
    ```macro dosomething(block1, block2)
    ```
- the must return an expression


---

### Macros: classical macros

- classical examples

- `@time ...`: 
- `@show ...`: shows an object and return the result
- `@eval ...`: evaluates some code
- `@generate ...`: write new code 
- `@code_llvm ...`
- `@code_warntype ...`: help detect type instability
- `@macroexpand ...`: get the result of a macro without executing it

---

### Macros: more examples

- sometimes macros are used by packages to implement special syntax
    - *Interact.jl*: `@interact`
    - *VegaLite.jl*: `@vlplot`
    - *StatsModels.jl*: `@formula`
    - *PyCall*: `@pyimport` ... 

---

### Other ideas:

- `@quickdict`:
    ```
    d = Dict(:a=1, :b=2)
    @quickdict d function f()
        return a + b
    end
    f(b=3) # -> 4
    ```
- who wants to implement it ?

---

### Other ideas:

- `@zero_based`:
    
    ```
    a = [3,4,9]
    @zero_based begin
    x = a[0] + a[1] + a[2]
    end
    x # -> 16
    ```
---

## Performance tricks

---

### No global variable

---

### Type stability

---

### (advanced) Avoid Memory Allocation

- CPU vs memory
- stack vs heap

---

### Think about memory order

- C order:
    - last index varies first
- Fortran order
    - first index varies first

---

### (Advanced) Use static arrays

---

### Do not vectorize or vectorize wisely

---

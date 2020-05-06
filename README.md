# Computational Economics

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/albop/eco309.git/master?urlpath=lab)

## General

All the course material is written inside notebooks `notebooks/*` and markdown files (usually in `slides/`). Those ending with `_tutorial` are meant to be run and filled by students.
The content of the session is integrated can be browsed [online](http://www.mosphere.fr/eco309/). (PRs are welcome)

Each student is expected to have a clone of the course repository, and commit his completed tutorials by Friday night. Intermediary assignments must be done in the same fashion by the next Friday.

During the course, each student will be asked to choose and present one Julia library.

The tutorial in the last session will be the final exam.





## Git Workflow

Instructions to follow the course:

Here is the goal:
- each student A must be able to update its online copy of the main repository from professor
- he can share his work by pushing to a branchin his own online repository (aka fork)

One challenge, is that jupyter notebooks are not really appropriate for merging modifications (it's not a source format).

Hence it is suggested students do not work directly on the files from the github repository but on a copy.

Here is the basic workflow:

1. `git clone https://github.com/albop/eco309.git` to get a copy of the main repository (do it only once)
    - it will be referred as `origin`
2. add your fork as another remote: `git add remote fork https://github.com/EconForge/eco309.git`
  - replace EconForge by your github login
  - the fork will be referred to as `fork`
3. copy a file like `cp 1_Optimization_tutorial.ipynb 1_Optimization_tutorial_mycopy.ipynb` 
  - work on the copy
4. put the copy under version control: `git add 1_Optimization_tutorial_mycopy.ipynb` (only once per file)
5. commit your changes with a message `git commit -a -m "Edited optimization"`
6. push them to the branch in the fork you own: `git push fork`

When there is an update in the main repository you can get them with `git pull origin`. Then you continue with steps 3,4,5,6.


## Setup requirement

To make the most of the course, it is recommended to install
- JuliaPro 1.4 (or Julia 1.4 + a good text editor + JupyterLab)
- Git

## Roadmap

Each session is 4 hours, and expected to be evenly but not contiguously divided between lectures and hands-on tutorials.

### Session 1

- General Introduction
- Git + Linux
- Setup
- Julia: Basics
    - ...
- Tutorial: contagion model

### Session 2

- Math: Series Convergence, Optimization (1)
- Julia: Git/Linux

### Session 3

- Math: Optimization (2)
- Julia Basics 2
- Models:
    - profit optimization
    - solow model
    - consumer choice

---

### Session 3

- Math: Markov Chains, Value iteration
- Julia: Types, Multiple Dispatch
- Models: Discrete Dynamic Programming
    - job search
    - ressource management

### Session 4

- Julia: performance (1)
- Math: Probabilities and Integration, Distributions
- Simulation heavy models:
    - asset pricing (1)

### Session 5

- Math: Differentiation, Perturbation, Linear Algebra
- Local Rational Expectations Models (DSGE)
    - neoclassical model
    - RBC model

### Session 6

- Math: Function Approximation, Solution Methods (VFI)
- Rational Expectations Models (2)
    - consumption-savings

### Session 8

- Math: Weighted Residuals, Solution Methods (TI, ITI)
- Rational Expectations (3)

### Session 9

- Rational Expectations Models (2): DSGE modeling
    - FRBNY?
- Exam

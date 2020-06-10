Here are some instructions to install a working Julia/Juno environement, with a Jupyter notebook. Be patient, some steps take a bit of time.

- download:
    - atom/github
    - Julia 1.4.1
- install Julia 1.4.1
- install Atom

- install uber-Juno:
    - open Atom
    - open File/Settings
    - left Pane: click Install
    - in the "search-packages" type "uber-juno"
    - scroll down and click install

- configure uber-juno (if needed)
    - open File/Settings
    - left Pane: click Packages
    - search for "julia-client"
    - scroll down and click on "Settings"
    - in Julia Path, enter the path of the Julia Binary (see below)
    - click on the Julio console: uber-juno will finish its configuration

- how to get the path of the julia binary ?
    - windows:
        - in the application panel search for Julia 1.4.1
        - instead of opening it, right click on the Julia icon.
        - click on "Open file location": this opens the location of the link to Julia...
        - right click on the "Julia 1.4.1" file and choose "Properties"
        - copy the content of the field "target": this is the path to the julia binary that you need to fill in in uber-juno
    - mac OS: ? not sure it is even needed
    - Linux: not needed, Julia should be in your path


- install packages:
    - open a julia console
        - by launching the julia program (vanilla console)
        - by opening the Julia console in the atom editor.
    - type `]` to enter package management mode
    - type `add Something` for the various packages you want to install
    - Packages to test:
        - `IJulia`: Jupyter notebooks
            - test it from the Julia console (not atom): `using IJulia; notebook()` (then `yes` to "install via Conda?")
        - `SymEngine`, `Optim`, `NLSolve`

Here is a far from exhaustive list of some cool packages to try:

- `ScikitLearn`, `MLJ`: machine learning
- `VegaLite`: data plotting using Vega
- `PlotlyJS`: graphs using Plotly
- `DataFrames`, `GLM`: statistics
- `AxisArrays` multidimensional labelled arrays
- `Interact`: interactive widget in jupyter (not super easy setup)
- `Flux`, `Mocha`:  machine learning package
- `ProgressMeter`: progressbar for long running calculations
- `StaticArrays`: high performance, stack-allocated arrays
- `Traceur`: provides performance types
- `Reinforce`: reinforcement learning in Julie

```@meta
CurrentModule = FortranNamelistParser
```

# FortranNamelistParser

Documentation for [FortranNamelistParser](https://github.com/anchal-physics/FortranNamelistParser.jl).

See the [Index](@ref main-index) for the complete list of documented functions
and types.

This repository was forked from [singularitti/FortranNamelistParser.jl](https://github.com/singularitti/Fortran90Namelists.jl/commit/d7eaefe084875d3de11b4fd0fd7e568fbbdd8b60) and new functions to read namelist files into dictionary and write dictiory into Fortran namelist files have been added. Some minor fixes in parsing have also been done to ensure all sample namelist files are read correctly.

If your usecase namelist file is not being read/written correctly, please open a issue and attach a namelist file with code to reproduce the error. Alternatively, you are more than welcome to contribute directly to the repo to get your usecase supported.


## Installation
Â
The package can be installed with the Julia package manager.
From the Julia REPL, type `]` to enter the Pkg REPL mode and run:

```julia
pkg> add FortranNamelistParser
```

Or, equivalently, via the `Pkg` API:

```@repl
import Pkg; Pkg.add("FortranNamelistParser")
```

## Documentation

- [**STABLE**](https://anchal-physics.github.io/FortranNamelistParser.jl/stable) — **documentation of the most recently tagged version.**
- [**DEV**](https://anchal-physics.github.io/FortranNamelistParser.jl/dev) — _documentation of the in-development version._

## Project status

The package is tested against, and being developed for, Julia `1.6` and above on Linux,
macOS, and Windows.

## Questions and contributions

Contributions are very welcome, as are feature requests and suggestions. Please open an
[issue](https://github.com/anchal-physics/FortranNamelistParser.jl/issues)
if you encounter any problems. The [Contributing](@ref) page has
a few guidelines that should be followed when opening pull requests and contributing code.

## Manual outline

```@contents
Pages = [
    "installation.md",
    "developers/contributing.md",
    "developers/style-guide.md",
    "troubleshooting.md",
]
Depth = 3
```

## Library outline

```@contents
Pages = ["api.md"]
```

### [Index](@id main-index)

```@index
Pages = ["api.md"]
```

## Alternatives

* [FortranNamelists.jl](https://gitlab.com/seamsay/FortranNamelists.jl): Another pure Julia package for reading (and writing) Fortran namelist files. This package is another take at the parser with different features and is similar to Fortran in use. Please check if this package meets your needs better.
* [PyFortran90Namelists](https://github.com/singularitti/PyFortran90Namelists.jl): A package which uses `PyCall` to call the python librabry `f90nml` to perform the parsing.
* [Fortran90Namelists](https://github.com/singularitti/Fortran90Namelists.jl): A work in progress package which would probably supersede this package in future when registered.
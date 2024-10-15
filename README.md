# FortranNamelistParser

|                                 **Documentation**                                  |                                                                                                 **Build Status**                                                                                                 |                                        **Others**                                         |
| :--------------------------------------------------------------------------------: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :---------------------------------------------------------------------------------------: |
| [![Stable][docs-stable-img]][docs-stable-url] [![Dev][docs-dev-img]][docs-dev-url] | ![Tests][Tests-basge] ![Documentation][Docs-badge] ![Format Check][Format-Check-badge] [![Coverage][codecov-img]][codecov-url] | [![GitHub license][license-img]][license-url] [![Code Style: Blue][style-img]][style-url] |

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://anchal-physics.github.io/FortranNamelistParser.jl/stable

[Format-Check-badge]: https://github.com/anchal-physics/FortranNamelistParser.jl/actions/workflows/format_check.yml/badge.svg
[Docs-badge]: https://github.com/anchal-physics/FortranNamelistParser.jl/actions/workflows/make_docs.yml/badge.svg

[Tests-basge]: https://github.com/anchal-physics/FortranNamelistParser.jl/actions/workflows/test.yml/badge.svg

[codecov-img]: https://codecov.io/gh/anchal-physics/Fortran90Namelists.jl/graph/badge.svg?token=ZJBRLAXIS1

[codecov-url]: https://codecov.io/gh/anchal-physics/Fortran90Namelists.jl


[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://anchal-physics.github.io/FortranNamelistParser.jl/dev
[license-img]: https://img.shields.io/github/license/anchal-physics/FortranNamelistParser.jl
[license-url]: https://github.com/anchal-physics/FortranNamelistParser.jl/blob/main/LICENSE
[style-img]: https://img.shields.io/badge/code%20style-blue-4495d1.svg
[style-url]: https://github.com/invenia/BlueStyle

A pure [Julia](https://julialang.org/) implementation of Python
[`f90nml`](https://github.com/marshallward/f90nml) package.

The code is [hosted on GitHub](https://github.com/anchal-physics/FortranNamelistParser.jl),
with some continuous integration services to test its validity.

This repository was forked from [singularitti/FortranNamelistParser.jl](https://github.com/singularitti/Fortran90Namelists.jl/commit/d7eaefe084875d3de11b4fd0fd7e568fbbdd8b60) and new functions to read namelist files into dictionary and write dictiory into Fortran namelist files have been added. Some minor fixes in parsing have also been done to ensure all sample namelist files are read correctly.

If your usecase namelist file is not being read/written correctly, please open a issue and attach a namelist file with code to reproduce the error. Alternatively, you are more than welcome to contribute directly to the repo to get your usecase supported.

## Installation

The package can be installed with the Julia package manager.
From the Julia REPL, type `]` to enter the Pkg REPL mode and run:

```
pkg> add FortranNamelistParser
```

Or, equivalently, via the [`Pkg` API](https://pkgdocs.julialang.org/v1/getting-started/):

```julia
julia> import Pkg; Pkg.add("FortranNamelistParser")
```

## Documentation

- [**STABLE**][docs-stable-url] — **documentation of the most recently tagged version.**
- [**DEV**][docs-dev-url] — _documentation of the in-development version._

## Project status

The package is tested against, and being developed for, Julia `1.6` and above on Linux,
macOS, and Windows.

## Questions and contributions


Contributions are very welcome, as are feature requests and suggestions. Please open an
[issue][issues-url] if you encounter any problems. The [Contributing](@ref) page has
guidelines that should be followed when opening pull requests and contributing code.

[issues-url]: https://github.com/anchal-physics/FortranNamelistParser.jl/issues

## Alternatives

* [FortranNamelists.jl](https://gitlab.com/seamsay/FortranNamelists.jl): Another pure Julia package for reading (and writing) Fortran namelist files. This package is another take at the parser with different features and is similar to Fortran in use. Please check if this package meets your needs better.
* [PyFortran90Namelists](https://github.com/singularitti/PyFortran90Namelists.jl): A package which uses `PyCall` to call the python librabry `f90nml` to perform the parsing.
* [Fortran90Namelists](https://github.com/singularitti/Fortran90Namelists.jl): A work in progress package which would probably supersede this package in future when registered.

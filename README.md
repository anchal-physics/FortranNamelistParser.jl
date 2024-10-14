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

This repository is forked from original [repo](https://github.com/singularitti/FortranNamelistParser.jl) from [@singularitti](https://github.com/singularitti). [@singularitti](https://github.com/singularitti) is the major author of this package and the owner and mainter of this repository [@anchal-physics](https://github.com/anchal-physics) is only taking care of julia registration and minimal maintainence.

You are very welcome to contribute and/or take over the ownership of this project.

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

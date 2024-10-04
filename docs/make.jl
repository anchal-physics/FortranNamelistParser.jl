using Fortran90Namelists
using Documenter

DocMeta.setdocmeta!(
    Fortran90Namelists, :DocTestSetup, :(using Fortran90Namelists); recursive=true
)

makedocs(;
    modules=[Fortran90Namelists],
    authors="singularitti <singularitti@outlook.com> and contributors",
    repo="https://github.com/anchal-physics/Fortran90Namelists.jl/blob/{commit}{path}#{line}",
    sitename="Fortran90Namelists.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://anchal-physics.github.io/Fortran90Namelists.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Manual" => ["Installation guide" => "installation.md"],
        "API Reference" => "api.md",
        "Developer Docs" => [
            "Contributing" => "developers/contributing.md",
            "Style Guide" => "developers/style-guide.md",
        ],
        "Troubleshooting" => "troubleshooting.md",
    ],
    checkdocs=:none,
)

deploydocs(;
    repo="github.com/anchal-physics/Fortran90Namelists.jl",
    target="build",
    branch="gh-pages",
    devbranch="main",
    versions=["stable" => "v^", "v#.#"],
)

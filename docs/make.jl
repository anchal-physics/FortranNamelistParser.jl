using FortranNamelistParser
using Documenter

DocMeta.setdocmeta!(
    FortranNamelistParser, :DocTestSetup, :(using FortranNamelistParser); recursive=true
)

makedocs(;
    modules=[FortranNamelistParser],
    authors="singularitti <singularitti@outlook.com> and contributors",
    repo="https://github.com/anchal-physics/FortranNamelistParser.jl/blob/{commit}{path}#{line}",
    sitename="FortranNamelistParser.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://anchal-physics.github.io/FortranNamelistParser.jl",
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
    repo="github.com/anchal-physics/FortranNamelistParser.jl",
    target="build",
    branch="gh-pages",
    devbranch="main",
    versions=["stable" => "v^", "v#.#"],
)

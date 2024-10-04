using Fortran90Namelists
using Test

@testset "Fortran90Namelists.jl" begin
    include("fparse_tests.jl")
    include("Tokenizer_tests.jl")
end

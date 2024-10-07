using FortranNamelistParser
using Test

@testset "FortranNamelistParser.jl" begin
    include("fparse_tests.jl")
    include("Tokenizer_tests.jl")
    include("file_io_tests.jl")
end

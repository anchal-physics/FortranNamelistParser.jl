filenames = [
    joinpath(dirname(@__FILE__), "data", filename) for
    filename in readdir(joinpath(dirname(@__FILE__), "data"))
]

debug_mode = false

for filename in filenames
    @testset "Test reading $(basename(filename))" begin
        data_read = readnml(filename; verbose=debug_mode)
        @test data_read !== nothing
        string_write = writenml(tempname(), data_read; verbose=debug_mode)
        @test string_write !== nothing
    end
end

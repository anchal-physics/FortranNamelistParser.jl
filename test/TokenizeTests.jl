#=
TokenizeTests:
- Julia version: 1.0
- Author: singularitti
- Date: 2019-08-02
=#
module TokenizeTests

using Test

using Fortran90Namelists.Tokenize

@testset "Test bcast" begin
    benchmark = [["&", "bcast_nml"],
    ["    ", "x", " ", "=", " ", "2", "*", "2.0"],
    ["    ", "y", " ", "=", " ", "3", "*"],
    ["    ", "z", " ", "=", " ", "4", "*", ".true."],
    ["/"],
    [],
    ["&", "bcast_endnull_nml"],
    ["    ", "x", " ", "=", " ", "2", "*", "2.0"],
    ["    ", "y", " ", "=", " ", "3", "*"],
    ["/"],
    [],
    ["&", "bcast_mixed_nml"],
    ["    ", "x", " ", "=", " ", "3", "*", "1", ",", " ", "2", ",", " ", "3", ",", " ", "4"],
    ["    ", "y", " ", "=", " ", "3", "*", "1", ",", " ", "2", "*", "2", ",", " ", "3"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/bcast.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test bcast target" begin
    benchmark = [["&", "bcast_nml"],
    ["    ", "x", " ", "=", " ", "2.0", ",", " ", "2.0"],
    ["    ", "y", " ", "=", " ", ",", " ", ",", " ", ","],
    ["    ", "z", " ", "=", " ", ".true.", ",", " ", ".true.", ",", " ", ".true.", ",", " ", ".true."],
    ["/"],
    [],
    ["&", "bcast_endnull_nml"],
    ["    ", "x", " ", "=", " ", "2.0", ",", " ", "2.0"],
    ["    ", "y", " ", "=", " ", ",", " ", ",", " ", ","],
    ["/"],
    [],
    ["&", "bcast_mixed_nml"],
    ["    ", "x", " ", "=", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "2", ",", " ", "3", ",", " ", "4"],
    ["    ", "y", " ", "=", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "2", ",", " ", "2", ",", " ", "3"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/bcast_target.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test string" begin
    benchmark = [["&", "string_nml"],
    ["    ", "str_basic", " ", "=", " ", "'hello'"],
    ["    ", "str_no_delim", " ", "=", " ", "hello"],
    ["    ", "str_no_delim_no_esc", " ", "=", " ", "a''b"],
    ["    ", "single_esc_delim", " ", "=", " ", "'a ''single'' delimiter'"],
    ["    ", "double_esc_delim", " ", "=", " ", "\"a \"\"double\"\" delimiter\""],
    ["    ", "double_nested", " ", "=", " ", "\"''x'' \"\"y\"\"\""],
    ["    ", "str_list", " ", "=", " ", "'a'", ",", " ", "'b'", ",", " ", "'c'"],
    ["    ", "slist_no_space", " ", "=", " ", "'a'", ",", "'b'", ",", "'c'"],
    ["    ", "slist_no_quote", " ", "=", " ", "a", ",", "b", ",", "c"],
    ["    ", "slash", " ", "=", " ", "'back\\slash'"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/string.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test dollar" begin
    benchmark = [[raw"$", "dollar_nml"],
    ["    ", "v", " ", "=", " ", "1.00"],
    [raw"$"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/dollar.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test dollar target" begin
    benchmark = [["&", "dollar_nml"],
    ["    ", "v", " ", "=", " ", "1.0"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/dollar_target.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test comment argument" begin
    benchmark = [["&", "comment_alt_nml"],
    ["    ", "x", " ", "=", " ", "1"],
    ["    ", "#y = 2"],
    ["    ", "z", " ", "=", " ", "3"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/comment_alt.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test comment patch" begin
    benchmark = [["! This is an external comment"],
    ["&", "comment_nml"],
    ["    ", "v_cmt_inline", " ", "=", " ", "456", "  ", "! This is an inline comment"],
    ["    ", "! This is a separate comment"],
    ["    ", "v_cmt_in_str", " ", "=", " ", "'This token ! is not a comment'"],
    ["    ", "v_cmt_after_str", " ", "=", " ", "'This ! is not a comment'", " ", "! But this is"],
    ["/"],
    ["! This is a post-namelist comment"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/comment_patch.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test comment target" begin
    benchmark = [["&", "comment_nml"],
    ["    ", "v_cmt_inline", " ", "=", " ", "123"],
    ["    ", "v_cmt_in_str", " ", "=", " ", "'This token ! is not a comment'"],
    ["    ", "v_cmt_after_str", " ", "=", " ", "'This ! is not a comment'"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/comment_target.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test comment" begin
    benchmark = [["! This is an external comment"],
    ["&", "comment_nml"],
    ["    ", "v_cmt_inline", " ", "=", " ", "123", "  ", "! This is an inline comment"],
    ["    ", "! This is a separate comment"],
    ["    ", "v_cmt_in_str", " ", "=", " ", "'This token ! is not a comment'"],
    ["    ", "v_cmt_after_str", " ", "=", " ", "'This ! is not a comment'", " ", "! But this is"],
    ["/"],
    ["! This is a post-namelist comment"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/comment.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test default index" begin
    benchmark = [["&", "default_index_nml"],
    ["    ", "v", "(", "3", ":", "5", ")", " ", "=", " ", "3", ",", " ", "4", ",", " ", "5"],
    ["    ", "v", " ", "=", " ", "1", ",", " ", "2"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/default_index.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test empty namelist" begin
    benchmark = [["&", "empty_nml"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/empty.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test external token" begin
    benchmark = [["a"],
    ["123"],
    ["&", "ext_token_nml"],
    ["    ", "x", " ", "=", " ", "1"],
    ["/"],
    ["456"],
    ["z"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/ext_token.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

# FIXME:
# @testset "Test external comment" begin
#     benchmark = [[],
#     ["&", "efitin"],
#     ["abc", " ", "=", " ", "0"],
#     ["/"]]
#     tk = Tokenizer()
#     open(joinpath(dirname(@__FILE__), "data/extern_cmt.nml"), "r") do io
#         for (i, line) in enumerate(eachline(io))
#             @test parse(tk, line) == benchmark[i]
#         end
#     end
# end # testset

@testset "Test float" begin
    benchmark = [["&", "float_nml"],
    ["    ", "v_float", " ", "=", " ", "1.0"],
    ["    ", "v_decimal_start", " ", "=", " ", ".1"],
    ["    ", "v_decimal_end", " ", "=", " ", "1."],
    ["    ", "v_negative", " ", "=", " ", "-1."],
    [],
    ["    ", "v_single", " ", "=", " ", "1.0e0"],
    ["    ", "v_double", " ", "=", " ", "1.0d0"],
    [],
    ["    ", "v_single_upper", " ", "=", " ", "1.0E0"],
    ["    ", "v_double_upper", " ", "=", " ", "1.0D0"],
    [],
    ["    ", "v_positive_index", " ", "=", " ", "1.0e+01"],
    ["    ", "v_negative_index", " ", "=", " ", "1.0e-01"],
    [],
    ["    ", "v_no_exp_pos", " ", "=", " ", "1+0"],
    ["    ", "v_no_exp_neg", " ", "=", " ", "1-0"],
    ["    ", "v_no_exp_pos_dot", " ", "=", " ", "1.+0"],
    ["    ", "v_no_exp_neg_dot", " ", "=", " ", "1.-0"],
    ["    ", "v_neg_no_exp_pos", " ", "=", " ", "-1+0"],
    ["    ", "v_neg_no_exp_neg", " ", "=", " ", "-1-0"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/float.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test float target" begin
    benchmark = [["&", "float_nml"],
    ["    ", "v_float", " ", "=", " ", "1.0"],
    ["    ", "v_decimal_start", " ", "=", " ", "0.1"],
    ["    ", "v_decimal_end", " ", "=", " ", "1.0"],
    ["    ", "v_negative", " ", "=", " ", "-1.0"],
    ["    ", "v_single", " ", "=", " ", "1.0"],
    ["    ", "v_double", " ", "=", " ", "1.0"],
    ["    ", "v_single_upper", " ", "=", " ", "1.0"],
    ["    ", "v_double_upper", " ", "=", " ", "1.0"],
    ["    ", "v_positive_index", " ", "=", " ", "10.0"],
    ["    ", "v_negative_index", " ", "=", " ", "0.1"],
    ["    ", "v_no_exp_pos", " ", "=", " ", "1.0"],
    ["    ", "v_no_exp_neg", " ", "=", " ", "1.0"],
    ["    ", "v_no_exp_pos_dot", " ", "=", " ", "1.0"],
    ["    ", "v_no_exp_neg_dot", " ", "=", " ", "1.0"],
    ["    ", "v_neg_no_exp_pos", " ", "=", " ", "-1.0"],
    ["    ", "v_neg_no_exp_neg", " ", "=", " ", "-1.0"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/float_target.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test float format" begin
    benchmark = [["&", "float_nml"],
    ["    ", "v_float", " ", "=", " ", "1.000"],
    ["    ", "v_decimal_start", " ", "=", " ", "0.100"],
    ["    ", "v_decimal_end", " ", "=", " ", "1.000"],
    ["    ", "v_negative", " ", "=", " ", "-1.000"],
    ["    ", "v_single", " ", "=", " ", "1.000"],
    ["    ", "v_double", " ", "=", " ", "1.000"],
    ["    ", "v_single_upper", " ", "=", " ", "1.000"],
    ["    ", "v_double_upper", " ", "=", " ", "1.000"],
    ["    ", "v_positive_index", " ", "=", " ", "10.000"],
    ["    ", "v_negative_index", " ", "=", " ", "0.100"],
    ["    ", "v_no_exp_pos", " ", "=", " ", "1.000"],
    ["    ", "v_no_exp_neg", " ", "=", " ", "1.000"],
    ["    ", "v_no_exp_pos_dot", " ", "=", " ", "1.000"],
    ["    ", "v_no_exp_neg_dot", " ", "=", " ", "1.000"],
    ["    ", "v_neg_no_exp_pos", " ", "=", " ", "-1.000"],
    ["    ", "v_neg_no_exp_neg", " ", "=", " ", "-1.000"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/float_format.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test global index" begin
    benchmark = [["&", "global_index_nml"],
    ["    ", "v_zero", "(", "0", ":", "3", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3", ",", " ", "4"],
    ["    ", "v_neg", "(", "-2", ":", "1", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3", ",", " ", "4"],
    ["    ", "v_pos", "(", "2", ":", "5", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3", ",", " ", "4"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/global_index.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test group repeat" begin
    benchmark = [["&", "grp_repeat_nml"],
    ["    ", "x", " ", "=", " ", "1"],
    ["/"],
    ["&", "grp_repeat_nml"],
    ["    ", "x", " ", "=", " ", "2"],
    ["/"],
    ["&", "CASE_CHECK_nml"],
    ["    ", "y", " ", "=", " ", "1"],
    ["/"],
    ["&", "CASE_CHECK_nml"],
    ["    ", "y", " ", "=", " ", "2"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/grp_repeat.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test group repeat target" begin
    benchmark = [["&", "grp_repeat_nml"],
    ["    ", "x", " ", "=", " ", "1"],
    ["/"],
    [],
    ["&", "grp_repeat_nml"],
    ["    ", "x", " ", "=", " ", "2"],
    ["/"],
    [],
    ["&", "case_check_nml"],
    ["    ", "y", " ", "=", " ", "1"],
    ["/"],
    [],
    ["&", "case_check_nml"],
    ["    ", "y", " ", "=", " ", "2"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/grp_repeat_target.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test index bad end" begin
    benchmark = [["&", "bad_index_nml"],
    ["    ", "y", "(", "1", ":", "~", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/index_bad_end.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test index bad start" begin
    benchmark = [["&", "bad_index_nml"],
    ["    ", "y", "(", "1", "~", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/index_bad_start.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test index bad stride" begin
    benchmark = [["&", "bad_index_nml"],
    ["    ", "y", "(", "1", ":", "3", ":", "~", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/index_bad_stride.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test index bad" begin
    benchmark = [["&", "bad_index_nml"],
    ["    ", "y", "(", "~", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/index_bad.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test index empty end" begin
    benchmark = [["&", "empty_index_nml"],
    ["    ", "x", "(", "1", ":", ":", "2", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/index_empty_end.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test index empty stride" begin
    benchmark = [["&", "empty_index_nml"],
    ["    ", "x", "(", "1", ":", "3", ":", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/index_empty_stride.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test index empty" begin
    benchmark = [["&", "empty_index_nml"],
    ["    ", "x", "(", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/index_empty.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test index zero stride" begin
    benchmark = [["&", "bad_index_nml"],
    ["    ", "y", "(", "1", ":", "3", ":", "0", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/index_zero_stride.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test logical representation" begin
    benchmark = [["&", "logical_nml"],
    ["    ", "a", " ", "=", " ", "T"],
    ["    ", "b", " ", "=", " ", "F"],
    ["    ", "c", " ", "=", " ", "T"],
    ["    ", "d", " ", "=", " ", "F"],
    ["    ", "e", " ", "=", " ", "T"],
    ["    ", "f", " ", "=", " ", "F"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/logical_repr.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test logical" begin
    benchmark = [["&", "logical_nml"],
    ["    ", "a", " ", "=", " ", ".true."],
    ["    ", "b", " ", "=", " ", ".false."],
    ["    ", "c", " ", "=", " ", "t"],
    ["    ", "d", " ", "=", " ", "f"],
    ["    ", "e", " ", "=", " ", ".t"],
    ["    ", "f", " ", "=", " ", ".f"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/logical.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test multidimensional target" begin
    benchmark = [["&", "multidim_ooo_nml"],
    ["    ", "a", "(", "1", ",", "1", ")", " ", "=", " ", "1"],
    ["    ", "a", "(", "1", ":", "2", ",", "2", ")", " ", "=", " ", ",", " ", "2"],
    ["    ", "b", "(", "1", ",", "1", ")", " ", "=", " ", "1"],
    ["    ", "b", "(", "1", ":", "3", ",", "2", ")", " ", "=", " ", ",", " ", ",", " ", "3"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/multidim_ooo_target.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test multidimensional" begin
    benchmark = [["&", "multidim_ooo_nml"],
    ["    ", "a", "(", "2", ",", "2", ")", " ", "=", " ", "2"],
    ["    ", "a", "(", "1", ",", "1", ")", " ", "=", " ", "1"],
    [],
    ["    ", "b", "(", "3", ",", "2", ")", " ", "=", " ", "3"],
    ["    ", "b", "(", "1", ",", "1", ")", " ", "=", " ", "1"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/multidim_ooo.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test multidimensional space" begin
    benchmark = [["&", "multidim_nml"],
    ["    ", "v2d", "(", "1", ":", "2", ",", " ", "1", ")", " ", "=", " ", "1", ",", " ", "2"],
    ["    ", "v2d", "(", "1", ":", "2", ",", " ", "2", ")", " ", "=", " ", "3", ",", " ", "4"],
    ["    ", "v3d", "(", "1", ":", "2", ",", " ", "1", ",", " ", "1", ")", " ", "=", " ", "1", ",", " ", "2"],
    ["    ", "v3d", "(", "1", ":", "2", ",", " ", "2", ",", " ", "1", ")", " ", "=", " ", "3", ",", " ", "4"],
    ["    ", "v3d", "(", "1", ":", "2", ",", " ", "1", ",", " ", "2", ")", " ", "=", " ", "5", ",", " ", "6"],
    ["    ", "v3d", "(", "1", ":", "2", ",", " ", "2", ",", " ", "2", ")", " ", "=", " ", "7", ",", " ", "8"],
    ["    ", "w3d", "(", "1", ":", "4", ",", " ", "1", ",", " ", "1", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3", ",", " ", "4"],
    ["    ", "w3d", "(", "1", ":", "4", ",", " ", "2", ",", " ", "1", ")", " ", "=", " ", "5", ",", " ", "6", ",", " ", "7", ",", " ", "8"],
    ["    ", "w3d", "(", "1", ":", "4", ",", " ", "3", ",", " ", "1", ")", " ", "=", " ", "9", ",", " ", "10", ",", " ", "11", ",", " ", "12"],
    ["    ", "w3d", "(", "1", ":", "4", ",", " ", "1", ",", " ", "2", ")", " ", "=", " ", "13", ",", " ", "14", ",", " ", "15", ",", " ", "16"],
    ["    ", "w3d", "(", "1", ":", "4", ",", " ", "2", ",", " ", "2", ")", " ", "=", " ", "17", ",", " ", "18", ",", " ", "19", ",", " ", "20"],
    ["    ", "w3d", "(", "1", ":", "4", ",", " ", "3", ",", " ", "2", ")", " ", "=", " ", "21", ",", " ", "22", ",", " ", "23", ",", " ", "24"],
    ["    ", "v2d_explicit", "(", "1", ":", "2", ",", " ", "1", ")", " ", "=", " ", "1", ",", " ", "2"],
    ["    ", "v2d_explicit", "(", "1", ":", "2", ",", " ", "2", ")", " ", "=", " ", "3", ",", " ", "4"],
    ["    ", "v2d_outer", "(", "1", ",", " ", "1", ")", " ", "=", " ", "1"],
    ["    ", "v2d_outer", "(", "1", ",", " ", "2", ")", " ", "=", " ", "2"],
    ["    ", "v2d_outer", "(", "1", ",", " ", "3", ")", " ", "=", " ", "3"],
    ["    ", "v2d_outer", "(", "1", ",", " ", "4", ")", " ", "=", " ", "4"],
    ["    ", "v2d_inner", "(", ":", ",", " ", "1", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3", ",", " ", "4"],
    ["    ", "v2d_sparse", "(", ":", ",", " ", "1", ")", " ", "=", " ", "1", ",", " ", "2"],
    ["    ", "v2d_sparse", "(", ":", ",", " ", "2", ")", " ", "=", " ", ",", " ", ","],
    ["    ", "v2d_sparse", "(", ":", ",", " ", "3", ")", " ", "=", " ", "5", ",", " ", "6"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/multidim_space.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test multidimensional target" begin
    benchmark = [["&", "multidim_nml"],
    ["    ", "v2d", "(", "1", ":", "2", ",", "1", ")", " ", "=", " ", "1", ",", " ", "2"],
    ["    ", "v2d", "(", "1", ":", "2", ",", "2", ")", " ", "=", " ", "3", ",", " ", "4"],
    ["    ", "v3d", "(", "1", ":", "2", ",", "1", ",", "1", ")", " ", "=", " ", "1", ",", " ", "2"],
    ["    ", "v3d", "(", "1", ":", "2", ",", "2", ",", "1", ")", " ", "=", " ", "3", ",", " ", "4"],
    ["    ", "v3d", "(", "1", ":", "2", ",", "1", ",", "2", ")", " ", "=", " ", "5", ",", " ", "6"],
    ["    ", "v3d", "(", "1", ":", "2", ",", "2", ",", "2", ")", " ", "=", " ", "7", ",", " ", "8"],
    ["    ", "w3d", "(", "1", ":", "4", ",", "1", ",", "1", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3", ",", " ", "4"],
    ["    ", "w3d", "(", "1", ":", "4", ",", "2", ",", "1", ")", " ", "=", " ", "5", ",", " ", "6", ",", " ", "7", ",", " ", "8"],
    ["    ", "w3d", "(", "1", ":", "4", ",", "3", ",", "1", ")", " ", "=", " ", "9", ",", " ", "10", ",", " ", "11", ",", " ", "12"],
    ["    ", "w3d", "(", "1", ":", "4", ",", "1", ",", "2", ")", " ", "=", " ", "13", ",", " ", "14", ",", " ", "15", ",", " ", "16"],
    ["    ", "w3d", "(", "1", ":", "4", ",", "2", ",", "2", ")", " ", "=", " ", "17", ",", " ", "18", ",", " ", "19", ",", " ", "20"],
    ["    ", "w3d", "(", "1", ":", "4", ",", "3", ",", "2", ")", " ", "=", " ", "21", ",", " ", "22", ",", " ", "23", ",", " ", "24"],
    ["    ", "v2d_explicit", "(", "1", ":", "2", ",", "1", ")", " ", "=", " ", "1", ",", " ", "2"],
    ["    ", "v2d_explicit", "(", "1", ":", "2", ",", "2", ")", " ", "=", " ", "3", ",", " ", "4"],
    ["    ", "v2d_outer", "(", "1", ",", "1", ")", " ", "=", " ", "1"],
    ["    ", "v2d_outer", "(", "1", ",", "2", ")", " ", "=", " ", "2"],
    ["    ", "v2d_outer", "(", "1", ",", "3", ")", " ", "=", " ", "3"],
    ["    ", "v2d_outer", "(", "1", ",", "4", ")", " ", "=", " ", "4"],
    ["    ", "v2d_inner", "(", ":", ",", "1", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3", ",", " ", "4"],
    ["    ", "v2d_sparse", "(", ":", ",", "1", ")", " ", "=", " ", "1", ",", " ", "2"],
    ["    ", "v2d_sparse", "(", ":", ",", "2", ")", " ", "=", " ", ",", " ", ","],
    ["    ", "v2d_sparse", "(", ":", ",", "3", ")", " ", "=", " ", "5", ",", " ", "6"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/multidim_target.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test multidimensional" begin
    benchmark = [["&", "multidim_nml"],
    ["    ", "v2d", "(", "1", ":", "2", ",", " ", "1", ":", "2", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3", ",", " ", "4"],
    [],
    ["    ", "v3d", "(", "1", ":", "2", ",", " ", "1", ":", "2", ",", " ", "1", ":", "2", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3", ",", " ", "4", ",", " ", "5", ",", " ", "6", ",", " ", "7", ",", " ", "8"],
    [],
    ["    ", "w3d", "(", "1", ":", "4", ",", " ", "1", ":", "3", ",", " ", "1", ":", "2", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3", ",", " ", "4", ",", " ", "5", ",", " ", "6", ",", " ", "7", ",", " ", "8", ",", " ", "9", ",", " ", "10", ",", " ", "11", ",", " ", "12", ","],
    ["                         ", "13", ",", " ", "14", ",", " ", "15", ",", " ", "16", ",", " ", "17", ",", " ", "18", ",", " ", "19", ",", " ", "20", ",", " ", "21", ",", " ", "22", ",", " ", "23", ",", " ", "24"],
    [],
    ["    ", "v2d_explicit", "(", "1", ",", " ", "1", ")", " ", "=", " ", "1"],
    ["    ", "v2d_explicit", "(", "2", ",", " ", "1", ")", " ", "=", " ", "2"],
    ["    ", "v2d_explicit", "(", "1", ",", " ", "2", ")", " ", "=", " ", "3"],
    ["    ", "v2d_explicit", "(", "2", ",", " ", "2", ")", " ", "=", " ", "4"],
    [],
    ["    ", "v2d_outer", "(", "1", ",", " ", ":", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3", ",", " ", "4"],
    ["    ", "v2d_inner", "(", ":", ",", " ", "1", ")", " ", "=", " ", "1", ",", " ", "2", ",", " ", "3", ",", " ", "4"],
    [],
    ["    ", "v2d_sparse", "(", ":", ",", " ", "1", ")", " ", "=", " ", "1", ",", " ", "2"],
    ["    ", "v2d_sparse", "(", ":", ",", " ", "3", ")", " ", "=", " ", "5", ",", " ", "6"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/multidim.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test multidimensional column width" begin
    benchmark = [["&", "multiline_nml"],
    ["    ", "x", " ", "=", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ","],
    ["        ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ","],
    ["        ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ","],
    ["        ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ","],
    ["        ", "1", ",", " ", "1", ",", " ", "1"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/multiline_colwidth.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test multiline index" begin
    benchmark = [["&", "multiline_nml"],
    ["    ", "x", "(", "1", ":", "47", ")", " ", "=", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ","],
    ["              ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ","],
    ["              ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/multiline_index.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

@testset "Test multiline" begin
    benchmark = [["&", "multiline_nml"],
    ["    ", "x", " ", "=", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ","],
    ["        ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ",", " ", "1", ","],
    ["        ", "1", ",", " ", "1", ",", " ", "1"],
    ["/"]]
    tk = Tokenizer()
    open(joinpath(dirname(@__FILE__), "data/multiline.nml"), "r") do io
        for (i, line) in enumerate(eachline(io))
            @test parse(tk, line) == benchmark[i]
        end
    end
end # testset

end

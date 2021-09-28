using PyCall
using FromPython: AST
using FromPython

ast = pyimport("ast")

@testset "BinOp" begin
    for (op, x, y, jl_expr) in [
        (ast.Add(), 1, 2, :(1 + 2)),
        (ast.Sub(), 1, 2, :(1 - 2)),
        (ast.Mult(), 4, 5, :(4 * 5)),
        (ast.Div(), 4, 2, :(4 / 2)),

        (ast.Mod(), 15, 4, :(15 % 4)),
        (ast.Pow(), 2, 3, :(2 ^ 3)),
        (ast.LShift(), 2, 1, :(2 << 1)),
        (ast.RShift(), 2, 1, :(2 >> 1)),
        (ast.BitOr(),  4, 1, :(4 | 1)),
        # (ast.BitXor(), 4, 1, :(xor(4, 1)),
        (ast.BitAnd(), 4, 1, :(4 & 1)),

        # (ast.FloorDiv(),=> floor ∘ (/)
        # (ast.MatMult(), => @not_implemented_yet
    ]
        binop = ast.BinOp(op=op, left=ast.Num(x), right=ast.Num(y))
        @test AST.dispatch(Expr, binop) == jl_expr
    end
end

# @testset "Comparisons" begin
#     (op, x, y, jl_expr) in [
#     # (ast.Eq(), => (==),
#     # (ast.NotEq(), => (!=),
#     # (ast.Lt(), => (<),
#     # (ast.LtE(), => (<=),
#     # (ast.Gt(),  => (>),
#     # (ast.GtE(), => (>=),
#     # (ast.Is(),  => (===),
#     # (ast.IsNot(), => (!==),
#     # (ast.In(),    => (in),
#     #  (ast.NotIn(), => (!in),
#       ]
# end

# @testset "Assign" begin
#     assgn = ast.parse("x = 1").body[1]
#     tup_assgn = ast.parse("y, z = 2, 3").body[1]
#     @test AST.dispatch(Expr, assgn) == :(x = 1)
#     @test AST.dispatch(Expr, tup_assgn) == :((y, z) = (2, 3))
# end

@testset "Expr" begin
    binop = ast.BinOp(op=ast.Add, left=ast.Num(1), right=ast.Num(2))
    pyexpr = ast.Expr(value=binop)
    @test AST.dispatch(Expr, pyexpr) == :(1 + 2)
end

@testset "Module" begin
    binop = ast.BinOp(op=ast.Add, left=ast.Num(1), right=ast.Num(2))
    pyexpr = ast.Expr(value=binop)
    modl = ast.Module(body=[pyexpr])
    @test AST.dispatch(Expr, modl) == [:(1 + 2)]
end

# @testset "Call" begin
#     call_exp = ast.parse("numpy.dot(x, y)").body[1].value
#     @test AST.dispatch(Expr, call_exp) == [:(numpy.dot(x, y))]

#     FromPython.register!("numpy.dot",
#                             (ctx, func, args, keywords) -> :(dot($(AST.dispatch(ctx, args[1])),
#                                                                  $(AST.dispatch(ctx, args[2])))))
#     call_exp = ast.parse("numpy.dot(x, y)").body[1].value
#     @test AST.dispatch(Expr, call_exp) == [:(dot(x, y))]
# end

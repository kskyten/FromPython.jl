using PyCall
using FromPython: AST
using FromPython

ast = pyimport("ast")

@testset "BinOp" begin
    for (op, x, y, jl_expr) in [
        (ast.Add(), 1, 2, :(1 + 2)),
        (ast.Sub(), 1, 2, :(1 - 2)),
        (ast.Mult(), 4, 5, :(4 * 5)),
        (ast.Div(), 4, 2, :(4 / 2))
    ]
        binop = ast.BinOp(op=op, left=ast.Num(x), right=ast.Num(y))
        @test AST.dispatch(Expr, binop) == jl_expr
    end
end

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

@testset "Call" begin
    call_exp = ast.parse("numpy.dot(x, y)").body[1].value
    @test AST.dispatch(Expr, call_exp) == [:(numpy.dot(x, y))]

    FromPython.register!("numpy.dot",
                            (ctx, func, args, keywords) -> :(dot($(AST.dispatch(ctx, args[1])),
                                                                 $(AST.dispatch(ctx, args[2])))))
    call_exp = ast.parse("numpy.dot(x, y)").body[1].value
    @test AST.dispatch(Expr, call_exp) == [:(dot(x, y))]
end

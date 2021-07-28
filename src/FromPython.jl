module FromPython
using PyCall

include("ast.jl")

export transpile

const METHODS = Dict()

function register!(k, v)
    METHODS[k] = v
end

function transpile(ctx, code)
    ast = pyimport("ast")
    py_ast = ast.parse(code)
    AST.dispatch(ctx, py_ast)
end

function trace()
end

end

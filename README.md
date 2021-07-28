# FromPython

FromPython is a Python-to-Julia tranpiler. It is mainly intended
for translating numerical code and wrapping Python packages to add multiple
dispatch. However, it aims to be flexible and extensible enough to be used more generally.

## Usage

FromPython exports a single `transpile` method, which takes the desired format
as the first argument and the code to be transpiled as the second argument.
Additional options can be given as keyword arguments. Look at the tests to see
what is currently supported.

``` julia
using FromPython

transpile(Expr, "1 + 1")

transpile(String, "lambda x, y: x * y")

open("output.jl", "w") do f
    transpile(f,
    """
    import numpy as np

    def foo(x, y):
        x + y * np.dot(x, y)
    """)
end
```

### Transpiling code from external packages (WIP)

FromPython only transpiles core Python language constructs. You can
add ac-hoc translations of external Python packages by using the `methods`
keyword argument. If you intend to implement a translator for a whole package,
please register it in the (TranspilerRegistry)[]. Translator packages should be
prefixed with `From` to distinguish them from compatibility packages and wrappers. For
example `FromNumpy.jl` for transpiling numpy code and `Numpy.jl` for the
compatibility layer or wrapper.

```julia

function numpy_dot(ctx, func, args, keywords)
    :(dot($(AST.dispatch(ctx, args[1])), $(AST.dispatch(ctx, args[2]))))
end

methods = Dict(
    "numpy.dot" => numpy_dot
)

transpile(String,
    """
    import numpy as np

    def foo(x, y):
        x + y * np.dot(x, y)
    """)

transpile(String,
    """
    import numpy as np

    def foo(x, y):
        x + y * np.dot(x, y)
    """; methods=methods)

```
### Transpiling packages from PyPI (WIP)

```julia

using FilePaths

transpile(p"~/src/github.com/kskyten/", pip"SQLAlchemy")

```

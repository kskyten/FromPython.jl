#!/usr/bin/env python3

import asdl
from urllib.request import urlopen
from asdl import ASDLParser, parse

ARG_MAP = {"module": "mod", "ctx": "expr_ctx"}

CONSTRUCTOR_MAP = {
    "Dict": "PyDict",
    "Set": "PySet",
    "Expr": "PyExpr",
    "Tuple": "PyTuple",
}


def translate_constructors(name):
    return CONSTRUCTOR_MAP.get(name, name)


def constructor_args(fields):
    if len(fields) == 0 or fields is None:
        args = "(ctx)"
    else:
        flds = [_constructor_args(field) for field in fields]
        args = "(ctx, " + ", ".join(flds) + ")"
    return args


def translate_args(name):
    return ARG_MAP.get(name, name)


def _constructor_args(field):
    return f"{translate_args(field.name)}"


def constructor_docs():
    return ""


def asdl_signature(fields):
    if len(fields) == 0 or fields is None:
        args = "()"
    else:
        flds = [_asdl_args(field) for field in fields]
        args = "(" + ", ".join(flds) + ")"
    return args


def _asdl_args(field):
    return f"{field.type}{'*' if field.seq else ''} {field.name}"


def destructured_args(constructor):
    fields = constructor.fields
    if len(fields) == 0 or fields is None:
        return "ctx"
    else:
        return "ctx, " + ", ".join([_destructured_args(field) for field in fields])


def _destructured_args(field):
    return f"obj.{field.name}"


def dropfields(name, fields):
    if name == "Module":
        return [field for field in fields if field != "type_ignores"]
    elif name == "FuntionDef":
        return [field for field in fields if field != "type_comment"]
    else:
        return fields


def Constructor(constructor):
    name = constructor.name
    fields = dropfields(name, constructor.fields)
    tmp = f"""
\"\"\"
{name}{asdl_signature(fields)}
\"\"\"
function {translate_constructors(name)}{constructor_args(fields)}
    @error "Translation for {name} has not been implemented."
end

function {translate_constructors(name)}(ctx, obj::PyObject)
    {translate_constructors(name)}({destructured_args(constructor)})
end
"""
    return tmp


class JuliaVisitor(asdl.Check):
    def __init__(self, output, **kwargs):
        super().__init__(**kwargs)
        self.output = output

    def visitConstructor(self, cons, name):
        # print(Constructor(cons))
        self.write(Constructor(cons))

    def write(self, string):
        self.output.write(string)


def main(output):
    syntax = (
        urlopen(
            "https://raw.githubusercontent.com/python/cpython/master/Parser/Python.asdl"
        )
        .read()
        .decode("utf-8")
    )
    ast = ASDLParser().parse(syntax)

    with open(output, "a") as f:
        visitor = JuliaVisitor(f)
        visitor.visit(ast)

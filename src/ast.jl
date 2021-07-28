module AST
using PyCall

include("expressions.jl")

function dispatch(ctx, sym::Symbol, args...)
    getproperty(@__MODULE__, sym)(ctx, args...)
end

const CONSTRUCTORS = Dict(
    "Tuple" => "PyTuple",
    "Set" => "PySet",
    "Dict" => "PyDict",
    "Expr" => "PyExpr"
)

function classname(obj::PyObject)
    name = obj.__class__.__name__
    name == "type" ? obj.__name__ : name
end

function dispatch(ctx, obj::PyObject)
    _classname = classname(obj)
    constructor = get(CONSTRUCTORS, _classname, _classname)
    dispatch(ctx, Symbol(constructor), obj)
end

"""
Module(stmt* body, type_ignore* type_ignores)
"""
function Module(ctx::Type{Expr}, obj::PyObject)
    [dispatch(ctx, stmt) for stmt in obj.body]
end

"""
Interactive(stmt* body)
"""
function Interactive(ctx, body)
    @error "Translation for Interactive has not been implemented."
end

function Interactive(ctx, obj::PyObject)
    Interactive(ctx, obj.body)
end

"""
Expression(expr body)
"""
function Expression(ctx, body)
    @error "Translation for Expression has not been implemented."
end

function Expression(ctx, obj::PyObject)
    Expression(ctx, obj.body)
end

"""
FunctionType(expr* argtypes, expr returns)
"""
function FunctionType(ctx, argtypes, returns)
    @error "Translation for FunctionType has not been implemented."
end

function FunctionType(ctx, obj::PyObject)
    FunctionType(ctx, obj.argtypes, obj.returns)
end

"""
FunctionDef(identifier name, arguments args, stmt* body, expr* decorator_list, expr returns, string type_comment)
"""
function FunctionDef(ctx, name, args, body, decorator_list, returns)  # type_comment
    @error "Translation for FunctionDef has not been implemented."
end

function FunctionDef(ctx, obj::PyObject)
    FunctionDef(ctx, obj.name, obj.args, obj.body, obj.decorator_list, obj.returns)
end

"""
AsyncFunctionDef(identifier name, arguments args, stmt* body, expr* decorator_list, expr returns, string type_comment)
"""
function AsyncFunctionDef(ctx, name, args, body, decorator_list, returns, type_comment)
    @error "Translation for AsyncFunctionDef has not been implemented."
end

function AsyncFunctionDef(ctx, obj::PyObject)
    AsyncFunctionDef(ctx, obj.name, obj.args, obj.body, obj.decorator_list, obj.returns, obj.type_comment)
end

"""
ClassDef(identifier name, expr* bases, keyword* keywords, stmt* body, expr* decorator_list)
"""
function ClassDef(ctx, name, bases, keywords, body, decorator_list)
    @error "Translation for ClassDef has not been implemented."
end

function ClassDef(ctx, obj::PyObject)
    ClassDef(ctx, obj.name, obj.bases, obj.keywords, obj.body, obj.decorator_list)
end

"""
Return(expr value)
"""
function Return(ctx, value)
    @error "Translation for Return has not been implemented."
end

function Return(ctx, obj::PyObject)
    Return(ctx, obj.value)
end

"""
Delete(expr* targets)
"""
function Delete(ctx, targets)
    @error "Translation for Delete has not been implemented."
end

function Delete(ctx, obj::PyObject)
    Delete(ctx, obj.targets)
end

"""
Assign(expr* targets, expr value, string type_comment)
"""
function Assign(ctx, targets, value, type_comment)
    @error "Translation for Assign has not been implemented."
end

function Assign(ctx, obj::PyObject)
    Assign(ctx, obj.targets, obj.value, obj.type_comment)
end

"""
AugAssign(expr target, operator op, expr value)
"""
function AugAssign(ctx, target, op, value)
    @error "Translation for AugAssign has not been implemented."
end

function AugAssign(ctx, obj::PyObject)
    AugAssign(ctx, obj.target, obj.op, obj.value)
end

"""
AnnAssign(expr target, expr annotation, expr value, int simple)
"""
function AnnAssign(ctx, target, annotation, value, simple)
    @error "Translation for AnnAssign has not been implemented."
end

function AnnAssign(ctx, obj::PyObject)
    AnnAssign(ctx, obj.target, obj.annotation, obj.value, obj.simple)
end

"""
For(expr target, expr iter, stmt* body, stmt* orelse, string type_comment)
"""
function For(ctx, target, iter, body, orelse, type_comment)
    @error "Translation for For has not been implemented."
end

function For(ctx, obj::PyObject)
    For(ctx, obj.target, obj.iter, obj.body, obj.orelse, obj.type_comment)
end

"""
AsyncFor(expr target, expr iter, stmt* body, stmt* orelse, string type_comment)
"""
function AsyncFor(ctx, target, iter, body, orelse, type_comment)
    @error "Translation for AsyncFor has not been implemented."
end

function AsyncFor(ctx, obj::PyObject)
    AsyncFor(ctx, obj.target, obj.iter, obj.body, obj.orelse, obj.type_comment)
end

"""
While(expr test, stmt* body, stmt* orelse)
"""
function While(ctx, test, body, orelse)
    @error "Translation for While has not been implemented."
end

function While(ctx, obj::PyObject)
    While(ctx, obj.test, obj.body, obj.orelse)
end

"""
If(expr test, stmt* body, stmt* orelse)
"""
function If(ctx, test, body, orelse)
    @error "Translation for If has not been implemented."
end

function If(ctx, obj::PyObject)
    If(ctx, obj.test, obj.body, obj.orelse)
end

"""
With(withitem* items, stmt* body, string type_comment)
"""
function With(ctx, items, body, type_comment)
    @error "Translation for With has not been implemented."
end

function With(ctx, obj::PyObject)
    With(ctx, obj.items, obj.body, obj.type_comment)
end

"""
AsyncWith(withitem* items, stmt* body, string type_comment)
"""
function AsyncWith(ctx, items, body, type_comment)
    @error "Translation for AsyncWith has not been implemented."
end

function AsyncWith(ctx, obj::PyObject)
    AsyncWith(ctx, obj.items, obj.body, obj.type_comment)
end

"""
Raise(expr exc, expr cause)
"""
function Raise(ctx, exc, cause)
    @error "Translation for Raise has not been implemented."
end

function Raise(ctx, obj::PyObject)
    Raise(ctx, obj.exc, obj.cause)
end

"""
Try(stmt* body, excepthandler* handlers, stmt* orelse, stmt* finalbody)
"""
function Try(ctx, body, handlers, orelse, finalbody)
    @error "Translation for Try has not been implemented."
end

function Try(ctx, obj::PyObject)
    Try(ctx, obj.body, obj.handlers, obj.orelse, obj.finalbody)
end

"""
Assert(expr test, expr msg)
"""
function Assert(ctx, test, msg)
    @error "Translation for Assert has not been implemented."
end

function Assert(ctx, obj::PyObject)
    Assert(ctx, obj.test, obj.msg)
end

"""
Import(alias* names)
"""
function Import(ctx, names)
    @error "Translation for Import has not been implemented."
end

function Import(ctx, obj::PyObject)
    Import(ctx, obj.names)
end

"""
ImportFrom(identifier module, alias* names, int level)
"""
function ImportFrom(ctx, mod, names, level)
    @error "Translation for ImportFrom has not been implemented."
end

function ImportFrom(ctx, obj::PyObject)
    ImportFrom(ctx, obj.module, obj.names, obj.level)
end

"""
Global(identifier* names)
"""
function Global(ctx, names)
    @error "Translation for Global has not been implemented."
end

function Global(ctx, obj::PyObject)
    Global(ctx, obj.names)
end

"""
Nonlocal(identifier* names)
"""
function Nonlocal(ctx, names)
    @error "Translation for Nonlocal has not been implemented."
end

function Nonlocal(ctx, obj::PyObject)
    Nonlocal(ctx, obj.names)
end

"""
Expr(expr value)
"""
# function PyExpr(ctx, value)
#     dispatch(ctx, value)
# end

function PyExpr(ctx, obj::PyObject)
    dispatch(ctx, obj.value)
end

"""
Pass()
"""
function Pass(ctx)
    @error "Translation for Pass has not been implemented."
end

function Pass(ctx, obj::PyObject)
    Pass(ctx)
end

"""
Break()
"""
function Break(ctx)
    @error "Translation for Break has not been implemented."
end

function Break(ctx, obj::PyObject)
    Break(ctx)
end

"""
Continue()
"""
function Continue(ctx)
    @error "Translation for Continue has not been implemented."
end

function Continue(ctx, obj::PyObject)
    Continue(ctx)
end

"""
BoolOp(boolop op, expr* values)
"""
function BoolOp(ctx, op, values)
    @error "Translation for BoolOp has not been implemented."
end

function BoolOp(ctx, obj::PyObject)
    BoolOp(ctx, obj.op, obj.values)
end

"""
NamedExpr(expr target, expr value)
"""
function NamedExpr(ctx, target, value)
    @error "Translation for NamedExpr has not been implemented."
end

function NamedExpr(ctx, obj::PyObject)
    NamedExpr(ctx, obj.target, obj.value)
end

"""
BinOp(expr left, operator op, expr right)
"""
function BinOp(ctx, left, op, right)
    call(dispatch(Expr, op), dispatch(Expr, left), dispatch(Expr, right))
end

function BinOp(ctx, obj::PyObject)
    BinOp(ctx, obj.left, obj.op, obj.right)
end

"""
UnaryOp(unaryop op, expr operand)
"""
function UnaryOp(ctx, op, operand)
    @error "Translation for UnaryOp has not been implemented."
end

function UnaryOp(ctx, obj::PyObject)
    UnaryOp(ctx, obj.op, obj.operand)
end

"""
Lambda(arguments args, expr body)
"""
function Lambda(ctx, args, body)
    @error "Translation for Lambda has not been implemented."
end

function Lambda(ctx, obj::PyObject)
    Lambda(ctx, obj.args, obj.body)
end

"""
IfExp(expr test, expr body, expr orelse)
"""
function IfExp(ctx, test, body, orelse)
    @error "Translation for IfExp has not been implemented."
end

function IfExp(ctx, obj::PyObject)
    IfExp(ctx, obj.test, obj.body, obj.orelse)
end

"""
Dict(expr* keys, expr* values)
"""
function PyDict(ctx, keys, values)
    @error "Translation for Dict has not been implemented."
end

function PyDict(ctx, obj::PyObject)
    PyDict(ctx, obj.keys, obj.values)
end

"""
Set(expr* elts)
"""
function PySet(ctx, elts)
    @error "Translation for Set has not been implemented."
end

function PySet(ctx, obj::PyObject)
    PySet(ctx, obj.elts)
end

"""
ListComp(expr elt, comprehension* generators)
"""
function ListComp(ctx, elt, generators)
    @error "Translation for ListComp has not been implemented."
end

function ListComp(ctx, obj::PyObject)
    ListComp(ctx, obj.elt, obj.generators)
end

"""
SetComp(expr elt, comprehension* generators)
"""
function SetComp(ctx, elt, generators)
    @error "Translation for SetComp has not been implemented."
end

function SetComp(ctx, obj::PyObject)
    SetComp(ctx, obj.elt, obj.generators)
end

"""
DictComp(expr key, expr value, comprehension* generators)
"""
function DictComp(ctx, key, value, generators)
    @error "Translation for DictComp has not been implemented."
end

function DictComp(ctx, obj::PyObject)
    DictComp(ctx, obj.key, obj.value, obj.generators)
end

"""
GeneratorExp(expr elt, comprehension* generators)
"""
function GeneratorExp(ctx, elt, generators)
    @error "Translation for GeneratorExp has not been implemented."
end

function GeneratorExp(ctx, obj::PyObject)
    GeneratorExp(ctx, obj.elt, obj.generators)
end

"""
Await(expr value)
"""
function Await(ctx, value)
    @error "Translation for Await has not been implemented."
end

function Await(ctx, obj::PyObject)
    Await(ctx, obj.value)
end

"""
Yield(expr value)
"""
function Yield(ctx, value)
    @error "Translation for Yield has not been implemented."
end

function Yield(ctx, obj::PyObject)
    Yield(ctx, obj.value)
end

"""
YieldFrom(expr value)
"""
function YieldFrom(ctx, value)
    @error "Translation for YieldFrom has not been implemented."
end

function YieldFrom(ctx, obj::PyObject)
    YieldFrom(ctx, obj.value)
end

"""
Compare(expr left, cmpop* ops, expr* comparators)
"""
function Compare(ctx, left, ops, comparators)
    @error "Translation for Compare has not been implemented."
end

function Compare(ctx, obj::PyObject)
    Compare(ctx, obj.left, obj.ops, obj.comparators)
end

"""
Call(expr func, expr* args, keyword* keywords)
"""
function Call(ctx, func, args, keywords)
    canon_func = canonicalize(ctx, func)
    if canon_func in METHODS
        return METHODS[canon_func](ctx, func, args, keywords)
    else
    begin
        func = dispatch(ctx, func)
        args = map(x -> dispatch(ctx, x), args)
        keywords = [(it[:arg], dispatch(ctx, it[:value])) for it in keywords]
        kw_unpack = [Expr(:..., snd) for (fst, snd) in keywords if fst === nothing]
        kw_args = [Expr(:kw, fst, snd) for (fst, snd) in keywords if fst !== nothing]
        Expr(:call, func, Expr(:parameters, kw_unpack...), args..., kw_args...)
    end
    end
end

function Call(ctx, obj::PyObject)
    Call(ctx, obj.func, obj.args, obj.keywords)
end

"""
FormattedValue(expr value, int conversion, expr format_spec)
"""
function FormattedValue(ctx, value, conversion, format_spec)
    @error "Translation for FormattedValue has not been implemented."
end

function FormattedValue(ctx, obj::PyObject)
    FormattedValue(ctx, obj.value, obj.conversion, obj.format_spec)
end

"""
JoinedStr(expr* values)
"""
function JoinedStr(ctx, values)
    @error "Translation for JoinedStr has not been implemented."
end

function JoinedStr(ctx, obj::PyObject)
    JoinedStr(ctx, obj.values)
end

"""
Constant(constant value, string kind)
"""
function Constant(ctx, value, kind)
    @error "Translation for Constant has not been implemented."
end

function Constant(ctx, obj::PyObject)
    Constant(ctx, obj.value, obj.kind)
end

"""
Attribute(expr value, identifier attr, expr_context ctx)
"""
function Attribute(ctx, value, attr, expr_ctx)
    @error "Translation for Attribute has not been implemented."
end

function Attribute(ctx, obj::PyObject)
    Attribute(ctx, obj.value, obj.attr, obj.ctx)
end

"""
Subscript(expr value, expr slice, expr_context ctx)
"""
function Subscript(ctx, value, slice, expr_ctx)
    @error "Translation for Subscript has not been implemented."
end

function Subscript(ctx, obj::PyObject)
    Subscript(ctx, obj.value, obj.slice, obj.ctx)
end

"""
Starred(expr value, expr_context ctx)
"""
function Starred(ctx, value, expr_ctx)
    @error "Translation for Starred has not been implemented."
end

function Starred(ctx, obj::PyObject)
    Starred(ctx, obj.value, obj.ctx)
end

"""
Name(identifier id, expr_context ctx)
"""
function Name(ctx, id, expr_ctx)
    @error "Translation for Name has not been implemented."
end

function Name(ctx, obj::PyObject)
    Name(ctx, obj.id, obj.ctx)
end

"""
List(expr* elts, expr_context ctx)
"""
function List(ctx, elts, expr_ctx)
    @error "Translation for List has not been implemented."
end

function List(ctx, obj::PyObject)
    List(ctx, obj.elts, obj.ctx)
end

"""
Tuple(expr* elts, expr_context ctx)
"""
function PyTuple(ctx, elts, expr_ctx)
    @error "Translation for Tuple has not been implemented."
end

function PyTuple(ctx, obj::PyObject)
    PyTuple(ctx, obj.elts, obj.ctx)
end

"""
Slice(expr lower, expr upper, expr step)
"""
function Slice(ctx, lower, upper, step)
    @error "Translation for Slice has not been implemented."
end

function Slice(ctx, obj::PyObject)
    Slice(ctx, obj.lower, obj.upper, obj.step)
end

"""
Load()
"""
function Load(ctx)
    @error "Translation for Load has not been implemented."
end

function Load(ctx, obj::PyObject)
    Load(ctx)
end

"""
Store()
"""
function Store(ctx)
    @error "Translation for Store has not been implemented."
end

function Store(ctx, obj::PyObject)
    Store(ctx)
end

"""
Del()
"""
function Del(ctx)
    @error "Translation for Del has not been implemented."
end

function Del(ctx, obj::PyObject)
    Del(ctx)
end

"""
And()
"""
function And(ctx)
    @error "Translation for And has not been implemented."
end

function And(ctx, obj::PyObject)
    And(ctx)
end

"""
Or()
"""
function Or(ctx)
    @error "Translation for Or has not been implemented."
end

function Or(ctx, obj::PyObject)
    Or(ctx)
end

function Add(ctx::Type{Expr}, obj::PyObject)
    :+
end

function Sub(ctx::Type{Expr}, obj::PyObject)
    :-
end

function Mult(ctx::Type{Expr}, obj::PyObject)
    :*
end

# """
# MatMult()
# """
# function MatMult(ctx)
#     @error "Translation for MatMult has not been implemented."
# end

# function MatMult(ctx::Type{Expr}, obj::PyObject)
#     :*
# end

function Div(ctx::Type{Expr}, obj::PyObject)
    :/
end

"""
Mod()
"""
function Mod(ctx)
    @error "Translation for Mod has not been implemented."
end

function Mod(ctx, obj::PyObject)
    Mod(ctx)
end

"""
Pow()
"""
function Pow(ctx)
    @error "Translation for Pow has not been implemented."
end

function Pow(ctx, obj::PyObject)
    Pow(ctx)
end

"""
LShift()
"""
function LShift(ctx)
    @error "Translation for LShift has not been implemented."
end

function LShift(ctx, obj::PyObject)
    LShift(ctx)
end

"""
RShift()
"""
function RShift(ctx)
    @error "Translation for RShift has not been implemented."
end

function RShift(ctx, obj::PyObject)
    RShift(ctx)
end

"""
BitOr()
"""
function BitOr(ctx)
    @error "Translation for BitOr has not been implemented."
end

function BitOr(ctx, obj::PyObject)
    BitOr(ctx)
end

"""
BitXor()
"""
function BitXor(ctx)
    @error "Translation for BitXor has not been implemented."
end

function BitXor(ctx, obj::PyObject)
    BitXor(ctx)
end

"""
BitAnd()
"""
function BitAnd(ctx)
    @error "Translation for BitAnd has not been implemented."
end

function BitAnd(ctx, obj::PyObject)
    BitAnd(ctx)
end

"""
FloorDiv()
"""
function FloorDiv(ctx)
    @error "Translation for FloorDiv has not been implemented."
end

function FloorDiv(ctx, obj::PyObject)
    FloorDiv(ctx)
end

"""
Invert()
"""
function Invert(ctx)
    @error "Translation for Invert has not been implemented."
end

function Invert(ctx, obj::PyObject)
    Invert(ctx)
end

"""
Not()
"""
function Not(ctx)
    @error "Translation for Not has not been implemented."
end

function Not(ctx, obj::PyObject)
    Not(ctx)
end

"""
UAdd()
"""
function UAdd(ctx)
    @error "Translation for UAdd has not been implemented."
end

function UAdd(ctx, obj::PyObject)
    UAdd(ctx)
end

"""
USub()
"""
function USub(ctx)
    @error "Translation for USub has not been implemented."
end

function USub(ctx, obj::PyObject)
    USub(ctx)
end

"""
Eq()
"""
function Eq(ctx)
    @error "Translation for Eq has not been implemented."
end

function Eq(ctx, obj::PyObject)
    Eq(ctx)
end

"""
NotEq()
"""
function NotEq(ctx)
    @error "Translation for NotEq has not been implemented."
end

function NotEq(ctx, obj::PyObject)
    NotEq(ctx)
end

"""
Lt()
"""
function Lt(ctx)
    @error "Translation for Lt has not been implemented."
end

function Lt(ctx, obj::PyObject)
    Lt(ctx)
end

"""
LtE()
"""
function LtE(ctx)
    @error "Translation for LtE has not been implemented."
end

function LtE(ctx, obj::PyObject)
    LtE(ctx)
end

"""
Gt()
"""
function Gt(ctx)
    @error "Translation for Gt has not been implemented."
end

function Gt(ctx, obj::PyObject)
    Gt(ctx)
end

"""
GtE()
"""
function GtE(ctx)
    @error "Translation for GtE has not been implemented."
end

function GtE(ctx, obj::PyObject)
    GtE(ctx)
end

"""
Is()
"""
function Is(ctx)
    @error "Translation for Is has not been implemented."
end

function Is(ctx, obj::PyObject)
    Is(ctx)
end

"""
IsNot()
"""
function IsNot(ctx)
    @error "Translation for IsNot has not been implemented."
end

function IsNot(ctx, obj::PyObject)
    IsNot(ctx)
end

"""
In()
"""
function In(ctx)
    @error "Translation for In has not been implemented."
end

function In(ctx, obj::PyObject)
    In(ctx)
end

"""
NotIn()
"""
function NotIn(ctx)
    @error "Translation for NotIn has not been implemented."
end

function NotIn(ctx, obj::PyObject)
    NotIn(ctx)
end

"""
ExceptHandler(expr type, identifier name, stmt* body)
"""
function ExceptHandler(ctx, type, name, body)
    @error "Translation for ExceptHandler has not been implemented."
end

function ExceptHandler(ctx, obj::PyObject)
    ExceptHandler(ctx, obj.type, obj.name, obj.body)
end

"""
TypeIgnore(int lineno, string tag)
"""
function TypeIgnore(ctx, lineno, tag)
    @error "Translation for TypeIgnore has not been implemented."
end

function TypeIgnore(ctx, obj::PyObject)
    TypeIgnore(ctx, obj.lineno, obj.tag)
end

Num(ctx, obj::PyObject) = obj.n

end

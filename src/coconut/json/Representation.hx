package coconut.json;
#if !macro

@:genericBuild(coconut.json.Representation.build())
class Representation<T> {}

#else
import haxe.macro.Expr;
import haxe.macro.Context;
import tink.macro.BuildCache;

using tink.MacroApi;

class Representation {
	public static function build() {
		return BuildCache.getType('coconut.json.Representation', (ctx:BuildContext) -> {
			var name = ctx.name;
			var fields = getFields(ctx.type, ctx.pos);
			
			var def = macro class $name {}
			def.pack = ['coconut', 'serialize'];
			def.kind = TDStructure;
			
			for(f in fields) {
				def.fields.push({
					name: f.name,
					kind: FVar(f.type.toComplex(), null),
					pos: f.pos,
				});
			}
			
			def;
		});
	}
	
	public static function getFields(type:haxe.macro.Type, pos:Position) {
		return switch type.reduce() {
			case TInst(_.get() => {constructor: _.get() => ctor}, _):
				var fields = (function parseCtor(t:haxe.macro.Type) {
					return switch t {
						case TFun([], _):
							[];
						case TFun([{t: _.reduce() => TAnonymous(_.get() => {fields: fields})}], _):
							fields;
						case TLazy(f):
							parseCtor(f());
						case _:
							ctor.pos.error('Invalid constructor');
					}
				})(ctor.type);
				
				[for(f in fields) {
					name: f.name,
					type: f.type,
					pos: f.pos,
				}];
				
			case _:
				pos.error('Invalid type');
		}
	}
}

#end
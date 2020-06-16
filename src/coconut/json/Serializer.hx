package coconut.json;
#if !macro

@:genericBuild(coconut.json.Serializer.build())
class Serializer<T> {}

#else
import haxe.macro.Expr;
import tink.macro.BuildCache;
using tink.MacroApi;

class Serializer {
	public static function build() {
		return BuildCache.getType('coconut.json.Serializer', (ctx:BuildContext) -> {
			
			var name = ctx.name;
			var modelCt = ctx.type.toComplex();
			
			var fields = Representation.getFields(ctx.type, ctx.pos);
			var obj = EObjectDecl([for(f in fields) {var name = f.name; {field: name, expr: macro @:privateAccess model.$name};}]).at(ctx.pos);
			
			var def = macro class $name {
				final cache = new Map();
				var count = 0;
				public function new(_) {}
				public function prepare(model:$modelCt):coconut.json.Ref<coconut.json.Representation<$modelCt>> {
					return switch cache[model] {
						case null:
							cache[model] = count++;
							Payload($obj);
						case v:
							Cached(v);
					}
				}
			}
			def.pack = ['coconut', 'serialize'];
			def;
			
		});
	}
}

#end


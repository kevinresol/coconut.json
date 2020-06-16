package coconut.json;
#if !macro

@:genericBuild(coconut.json.Unserializer.build())
class Unserializer<T> {}

#else
import haxe.macro.Expr;
import tink.macro.BuildCache;
using tink.MacroApi;

class Unserializer {
	public static function build() {
		return BuildCache.getType('coconut.json.Unserializer', (ctx:BuildContext) -> {
			
			var name = ctx.name;
			var modelCt = ctx.type.toComplex();
			var modelTp = switch modelCt {
				case TPath(tp): tp;
				case _: throw 'unreachable';
			}
			
			var fields = Representation.getFields(ctx.type, ctx.pos);
			var obj = EObjectDecl([for(f in fields) {var name = f.name; {field: name, expr: macro data.$name};}]).at(ctx.pos);
			
			var def = macro class $name {
				final cache = new Map();
				var count = 0;
				public function new(_) {}
				public function parse(data:coconut.json.Ref<coconut.json.Representation<$modelCt>>):$modelCt {
					return switch data {
						case Payload(data):
							cache[count++] = new $modelTp($obj);
						case Cached(id):
							cache[id];
					}
				}
			}
			def.pack = ['coconut', 'serialize'];
			def;
			
		});
	}
}

#end
package ;

import model.*;
import tink.unit.*;
import tink.testrunner.*;

@:asserts
class RunTests {
	static function main() {
		Runner.run(TestBatch.make([
			new RunTests(),
		])).handle(Runner.exit);
	}
	
	public function new() {}
	
	public function sameInstance() {
		var p = new Player({coins: 1});
		var o:{final p:Player;} = {p: p}
		var game = new Game({p1: p, p2: p, c1: o, c2: o});
		var s = tink.Json.stringify(game);
		trace(s);
		var parsed:Game = tink.Json.parse(s);
		asserts.assert(parsed.p1 == parsed.p2);
		asserts.assert(parsed.c1 == parsed.c2);
		asserts.assert(parsed.p1 == parsed.c1.p);
		return asserts.done();
	}
	
	public function nullable() {
		var game = new Game({p1: null, p2: null, c1: null, c2: null});
		var s = tink.Json.stringify(game);
		trace(s);
		var parsed:Game = tink.Json.parse(s);
		asserts.assert(parsed.p1 == null);
		asserts.assert(parsed.p2 == null);
		asserts.assert(parsed.c1 == null);
		asserts.assert(parsed.c2 == null);
		return asserts.done();
	}
}
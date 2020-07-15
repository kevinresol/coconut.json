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
		var game = new Game({p1: p, p2: p});
		var s = tink.Json.stringify(game);
		trace(s);
		var parsed:Game = tink.Json.parse(s);
		asserts.assert(parsed.p1 == parsed.p2);
		return asserts.done();
	}
	
	public function nullable() {
		var game = new Game({p1: null, p2: null});
		var s = tink.Json.stringify(game);
		trace(s);
		var parsed:Game = tink.Json.parse(s);
		asserts.assert(parsed.p1 == null);
		asserts.assert(parsed.p2 == null);
		return asserts.done();
	}
}
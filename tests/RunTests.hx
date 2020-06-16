package ;

import model.*;

class RunTests {

	static function main() {
		var p = new Player({coins: 1});
		var game = new Game({p1: p, p2: p});
		var s = tink.Json.stringify(game);
		trace(s);
		var parsed:Game = tink.Json.parse(s);
		
		
		trace(parsed.p1 == parsed.p2);
	}
	
}
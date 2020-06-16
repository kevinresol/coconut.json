package model;

@:jsonStringify((_:coconut.json.Serializer<model.Game>))
@:jsonParse((_:coconut.json.Unserializer<model.Game>))
class Game implements coconut.data.Model {
	@:observable var p1:Player = @byDefault new Player();
	@:observable var p2:Player;
}

package model;

@:jsonStringify((_:coconut.json.Serializer<model.Game>))
@:jsonParse((_:coconut.json.Unserializer<model.Game>))
class Game implements coconut.data.Model {
	@:observable var p1:Null<Player>;
	@:observable var p2:Null<Player>;
	@:observable var c1:Null<tink.json.Cached<{final p:Player;}>>;
	@:observable var c2:Null<tink.json.Cached<{final p:Player;}>>;
}

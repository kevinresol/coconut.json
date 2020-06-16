
package model;

@:jsonStringify((_:coconut.json.Serializer<model.Player>))
@:jsonParse((_:coconut.json.Unserializer<model.Player>))
class Player implements coconut.data.Model {
	@:observable var coins:Int = @byDefault 0;
}
package coconut.json;

enum Ref<T> {
	Payload(v:T);
	Cached(id:Int);
}
//: # Multidictionary

public
struct MultiDictionary<Key: Hashable, Value: Hashable> {
    
    //MARK: - Types
    public
    typealias Bucket = Set<Value>
    
    //MARK: - Properties
    private
    var _dict: [Key: Bucket]
    
    //MARK: - Lifecycle
    public
    init() {
        _dict = Dictionary()
    }
    
    //MARK: - Accessors
    public
    var isEmpty : Bool {
        return _dict.isEmpty
    }
    
    public
    var countBuckets: Int {
        return _dict.count
    }
    
    public
    var count: Int {
        var total = 0
        for bucket in _dict.values {
            total += bucket.count
        }
        
        return total
    }
    
    public
    var countUnique: Int {
        var total = Bucket()
        
        for bucket in _dict.values {
            total = total.union(bucket)
        }
        
        return total.count
    }
    
    //MARK: - Setters (Mutator)
    public
    subscript(key: Key) -> Bucket? {
        get {
            return _dict[key]
        }
        
        set(maybeNewBucket) {
            guard let newBucket = maybeNewBucket else {
                // insertar algo vacio es no insertar
                return
            }
            
            // verificar si ya existe algo bajo esa clave
            guard let previous = _dict[key] else {
                _dict[key] = Bucket()
                return
            }
            
            // crear union de elementos
            _dict[key] = previous.union(newBucket)
        }
    }
    
    // toda funcion que cambie el estado (self) de la estructura
    // tiene que venir precedida por la palabra mutating
    public
    mutating func insert(value: Value, forKey key: Key) {
        if var previous = _dict[key] {
            previous.insert(value)
            _dict[key] = previous
        } else {
            _dict[key] = [value]
        }
    }
    
    // cosas que faltan (ver slack para version completa)
    // eliminar valores
    // poder iterar por el MultiDict como por un diccionario
    
}

// Ejemplo de uso
var map = MultiDictionary<String, Int>()

var pares = Set<Int>()
pares.insert(2)
pares.insert(4)

map["Pares"] = pares    // setter
map["Pares"]            // getter


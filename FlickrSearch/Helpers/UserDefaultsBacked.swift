import Foundation

@propertyWrapper struct UserDefaultsBacked<Value> {
    
    private let key: String
    private let storage: UserDefaults
    private let defaultValue: Value
    
    var wrappedValue: Value {
        get {
            let value = storage.value(forKey: key) as? Value
            return value ?? defaultValue
        }
        
        set {
            if let newValue = newValue as? Any?, newValue == nil {
                storage.removeObject(forKey: key)
                return
            }
            
            storage.set(newValue, forKey: key)
        }
    }
    
    init(defaultValue: Value, key: String) {
        self.defaultValue = defaultValue
        self.key = key
        self.storage = UserDefaults.standard
    }
}

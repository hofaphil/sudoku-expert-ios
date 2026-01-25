public struct FieldType {
    
    var selected: Bool
    var coSelected: Bool
    var error: Bool
    
    init(selected: Bool, coSelected: Bool, error: Bool) {
        self.selected = selected
        self.coSelected = coSelected
        self.error = error
    }
    
    init() {
        self.init(selected: false, coSelected: false, error: false)
    }
}

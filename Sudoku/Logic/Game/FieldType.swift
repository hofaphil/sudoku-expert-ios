public struct FieldType {
    
    var selected: Bool
    var coSelected: Bool
    var sameNumber: Bool
    var error: Bool
    
    init(selected: Bool, coSelected: Bool, sameNumber: Bool, error: Bool) {
        self.selected = selected
        self.coSelected = coSelected
        self.sameNumber = sameNumber
        self.error = error
    }
    
    init() {
        self.init(selected: false, coSelected: false, sameNumber: false, error: false)
    }
}

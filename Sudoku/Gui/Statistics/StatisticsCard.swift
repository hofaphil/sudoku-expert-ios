import SwiftUI

struct StatisticsCard: View {
    
    let difficulty: Difficulty
    
    var averageTime: Int
    let bestTime: Int
    let timesPlayed: Int
    
    init(difficulty: Difficulty) {
        self.difficulty = difficulty
        let stats = Data().loadStatistics()
        
        bestTime = stats.getBestTime(difficulty: difficulty)
        timesPlayed = stats.getTimesPlayed(difficulty: difficulty)
        averageTime = stats.getAverageTime(difficulty: difficulty)
    }
    
    func statistic(key: LocalizedStringKey, value: String) -> some View {
        return HStack {
            Text(key)
            Text(value)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var body: some View {
        Section(header: Text(difficulty.asString)) {
            statistic(
                key: LocalizedStringKey("average"),
                value: MainModel.timeToString(averageTime))
            
            statistic(
                key: LocalizedStringKey("best-time"),
                value: MainModel.timeToString(bestTime))
            
            statistic(
                key: LocalizedStringKey("number-of-games"),
                value:"\(timesPlayed)")
        }
    }
}

struct StatisticsCard_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsCard(difficulty: Difficulty.ADVANCED)
    }
}

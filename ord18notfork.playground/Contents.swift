//: Playground - noun: a place where people can play

enum InputChar {
    // 1 - 9
    case customer(number: Int)
    // x
    case stop
    // .
    case process
    
    static func parse(input: Character) -> InputChar {
        switch input {
        case "x":
            return .stop
        case ".":
            return .process
        default:
            return .customer(number: Int(String(input))!)
        }
    }
}

enum Customer {
    // 通常の人
    case normal
    // xの人
    case stop
}

class RegiState {
    // 待っている人数
    var waiterCount:Int {
        get {
            return waiterList.count
        }
    }

    // 1つの"."あたりのレジ処理人数
    private let power: Int
    // 各レジで待っている人
    private var waiterList: [Customer] = []

    init(power: Int) {
        self.power = power
    }
    
    func add(input: InputChar) {
        switch input {
        case let .customer(number):
            // Customer.normalを必要件数追加
            (0..<number).forEach { _ in waiterList.append(Customer.normal) }
        default:
            // x
            waiterList.append(Customer.stop)
        }
    }
    
    func process() {
        (0..<power).forEach { _ in
            if (waiterCount == 0) {
                return
            }
            switch waiterList[0] {
            case .stop:
                return
            default:
                waiterList.removeFirst()
            }
        }
    }
}

class Store {
    private let regiList: [RegiState]
    
    init(powerList: [Int]) {
        regiList = powerList.map { RegiState(power: $0) }
    }
    
    func add(input: InputChar) {
        let targetRegiNumber = minWaiterRegi()
        regiList[targetRegiNumber].add(input: input)
    }
    
    func process() {
        // 各レジの処理
        regiList.forEach { $0.process() }
    }
    
    var description: String {
        return regiList.map { String($0.waiterCount) }.joined(separator: ",")
    }
    
    // 待っている人が一番少ないレジ番号を返す
    private func minWaiterRegi() -> Int {
        var regiNumber = -1
        var waiterCount = Int.max
        for (index, regi) in regiList.enumerated() {
            if (waiterCount > regi.waiterCount) {
                regiNumber = index
                waiterCount = regi.waiterCount
            }
        }
        return regiNumber
    }
}

func parseInput(_ paramInput: String) -> [InputChar] {
    return paramInput.map { input in InputChar.parse(input: input) }
}

func test(_ param: String, _ expect: String) {
    let inputList = parseInput(param)

    let store = Store(powerList: [2, 7, 3, 5, 2])

    inputList.forEach {
        switch $0 {
        case .process:
            store.process()
        default:
            store.add(input: $0)
        }
    }

    print("\"\(param)\", \"\(store.description)\"")
    assert(store.description == expect)
}

/*0*/ test( "42873x.3.", "0,4,2,0,0" );
/*1*/ test( "1", "1,0,0,0,0" );
/*2*/ test( ".", "0,0,0,0,0" );
/*3*/ test( "x", "1,0,0,0,0" );
/*4*/ test( "31.", "1,0,0,0,0" );
/*5*/ test( "3x.", "1,1,0,0,0" );
/*6*/ test( "99569x", "9,9,6,6,9" );
/*7*/ test( "99569x33", "9,9,9,9,9" );
/*8*/ test( "99569x33.", "7,2,6,4,7" );
/*9*/ test( "99569x33..", "5,0,4,0,5" );
/*10*/ test( "12345x3333.", "4,0,3,2,3" );
/*11*/ test( "54321x3333.", "3,0,3,0,4" );
/*12*/ test( "51423x3333.", "3,4,4,0,4" );
/*13*/ test( "12x34x.", "1,0,1,0,2" );
/*14*/ test( "987x654x.32", "7,6,4,10,5" );
/*15*/ test( "99999999999x99999999.......9.", "20,10,12,5,20" );
/*16*/ test( "997", "9,9,7,0,0" );
/*17*/ test( ".3.9", "1,9,0,0,0" );
/*18*/ test( "832.6", "6,6,0,0,0" );
/*19*/ test( ".5.568", "3,5,6,8,0" );
/*20*/ test( "475..48", "4,8,0,0,0" );
/*21*/ test( "7.2..469", "1,4,6,9,0" );
/*22*/ test( "574x315.3", "3,3,1,7,1" );
/*23*/ test( "5.2893.x98", "10,9,5,4,1" );
/*24*/ test( "279.6xxx..4", "2,1,4,1,1" );
/*25*/ test( "1.1.39..93.x", "7,1,0,0,0" );
/*26*/ test( "7677749325927", "16,12,17,18,12" );
/*27*/ test( "x6235.87.56.9.", "7,2,0,0,0" );
/*28*/ test( "4.1168.6.197.6.", "0,0,3,0,0" );
/*29*/ test( "2.8.547.25..19.6", "6,2,0,0,0" );
/*30*/ test( ".5.3x82x32.1829..", "5,0,5,0,7" );
/*31*/ test( "x.1816..36.24.429.", "1,0,0,0,7" );
/*32*/ test( "79.2.6.81x..26x31.1", "1,0,2,1,1" );
/*33*/ test( "574296x6538984..5974", "14,13,10,15,14" );
/*34*/ test( "99.6244.4376636..72.6", "5,6,0,0,3" );
/*35*/ test( "1659.486x5637168278123", "17,16,16,18,17" );
/*36*/ test( ".5.17797.x626x5x9457.3.", "14,0,3,5,8" );
/*37*/ test( "..58624.85623..4.7..23.x", "1,1,0,0,0" );
/*38*/ test( "716.463.9.x.8..4.15.738x4", "7,3,5,8,1" );
/*39*/ test( "22xx.191.96469472.7232377.", "10,11,18,12,9" );
/*40*/ test( "24..4...343......4.41.6...2", "2,0,0,0,0" );
/*41*/ test( "32732.474x153.866..4x29.2573", "7,5,7,8,5" );
/*42*/ test( "786.1267x9937.17.15448.1x33.4", "4,4,8,4,10" );
/*43*/ test( "671714849.149.686852.178.895x3", "13,16,13,10,12" );
/*44*/ test( "86x.47.517..29621.61x937..xx935", "7,11,8,8,10" );
/*45*/ test( ".2233.78x.94.x59511.5.86x3.x714.", "4,6,10,8,8" );
/*46*/ test( ".793...218.687x415x13.1...x58576x", "8,11,8,6,9" );
/*47*/ test( "6.6x37.3x51x932.72x4x33.9363.x7761", "15,13,15,12,15" );
/*48*/ test( "6..4.x187..681.2x.2.713276.669x.252", "6,7,8,6,5" );
/*49*/ test( ".6.xx64..5146x897231.x.21265392x9775", "19,17,19,20,17" );
/*50*/ test( "334.85413.263314.x.6293921x3.6357647x", "14,14,12,16,10" );
/*51*/ test( "4.1..9..513.266..5999769852.2.38x79.x7", "12,10,13,6,10" );


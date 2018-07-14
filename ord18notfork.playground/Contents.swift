//: Playground - noun: a place where people can play

enum Input {
    // 1 - 9
    case customer(number: Int)
    // x
    case stop
    // .
    case process
    
    static func parse(input: Character) -> Input {
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
    // 各レジで待っている人
    let power: Int
    var waiterList: [Customer] = []
    
    init(power: Int) {
        self.power = power
    }
    
    func add(input: Input) {
        switch input {
        case let .customer(number):
            // Customer.normalを必要件数追加
            for i in 1..<number {
                waiterList.append(Customer.normal)
            }
        default:
            // x
            waiterList.append(Customer.stop)
        }
    }
    
    func process() {
        for i in 0..<power {
            if (waiterCount() == 0) {
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
    
    func waiterCount() -> Int {
        return waiterList.count
    }
}

class Store {
    let regiList: [RegiState]
    
    init() {
        regiList = [
            RegiState(power: 2),
            RegiState(power: 7),
            RegiState(power: 3),
            RegiState(power: 5),
            RegiState(power: 2)
        ]
    }
    
    func add(input: Input) {
        let targetRegiNumber = minWaiterRegi()
        regiList[targetRegiNumber].add(input: input)
    }
    
    func process() {
        // 各レジの処理
        for regi in regiList {
            regi.process()
        }
    }
    
    var description: String {
        return "0: \(regiList[0].waiterCount()), "
            + "1: \(regiList[1].waiterCount()), "
            + "2: \(regiList[2].waiterCount()), "
            + "3: \(regiList[3].waiterCount()), "
            + "4: \(regiList[4].waiterCount()), "
    }
    
    // 待っている人が一番少ないレジ番号を返す
    private func minWaiterRegi() -> Int {
        var regiNumber = 0
        var waiterCount = 0
        for (index, regi) in regiList.enumerated() {
            print(index)
            if (waiterCount < regi.waiterCount()) {
                regiNumber = index
                waiterCount = regi.waiterCount()
            }
        }
        return regiNumber
    }
}

func parseInput(input: String) -> [Input] {
    var input:[Input] = []
    for c in rawInput {
        input.append(Input.parse(input: c))
    }
    return input
}

// MARK: Process start

let rawInput = "42873x.3."

let inputList = parseInput(input: rawInput)

let store = Store()

inputList.forEach {
    switch $0 {
    case .process:
        print("DEBUG: process")
        store.process()
    default:
        print("DEBUG: add")
        store.add(input: $0)
    }
}

print(store.description)


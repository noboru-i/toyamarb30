enum BlockState {
    case block
    case fall
    case water
    case undefined
    
    func toChar() -> Character {
        switch self {
        case .block:
            return "|"
        case .fall:
            return "_"
        case .water:
            return "x"
        case .undefined:
            return " "
        }
    }
}

class Stage {
    var blockList: [[BlockState]] = [[BlockState]]()
    
    func mapping(input: String) {
        let depth = maxDepth(input: input)

        for lineState in input {
            let blockCount = Int(String(lineState))!
            var blockCol: [BlockState] = []
            for d in 0..<depth {
                if (depth - blockCount >  d) {
                    blockCol.append(.undefined)
                } else {
                    blockCol.append(.block)
                }
            }
            blockList.append(blockCol)
        }
        
        // fall checks
        mappingLeftFall()
    }
    
    private func mappingLeftFall() {
        let target = blockList[0]
        for i in 0..<target.count {
            if (target[i] == .undefined) {
                
            }
        }
    }
    
    func fill() {
        for (x, blockCol) in blockList.enumerated() {
            for (y, block) in blockCol.enumerated() {
                if (block == .undefined) {
                    blockList[x][y] = .water
                }
            }
        }
    }
    
    func output() {
        for y in 0..<blockList[0].count {
            for x in 0..<blockList.count {
                print("\(blockList[x][y].toChar())", terminator: "")
            }
            print()
        }
    }

    func countWater() -> Int {
        return blockList.reduce(0) { (count, blockCol) -> Int in
            return count + blockCol.reduce(0) { (count, block) -> Int in
                return count + (block == .water ? 1 : 0)
            }
        }
    }

    private func maxDepth(input: String) -> Int {
        return input.map{ Int(String($0))! }.max()!
    }
}

let rawInput = "223"

let stage = Stage()

stage.mapping(input: rawInput)

print("mapped")
stage.output()

stage.fill()

print("filled")
stage.output()

let count = stage.countWater()
print("water = \(count)")


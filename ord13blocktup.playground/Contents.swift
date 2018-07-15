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
    }
    
    func fill() {
        for (x, blockCol) in blockList.enumerated() {
            for (y, block) in blockCol.enumerated() {
                if (block == .block) {
                    continue
                }
                
                let left = safeGet(x: x - 1, y: y)
                let right = safeGet(x: x + 1, y: y)
                let bottom = safeGet(x: x, y: y + 1)
            }
        }
    }
    
    private func safeGet(x: Int, y: Int) -> BlockState {
        guard case blockList.indices = x else {
            return .undefined
        }
        return .undefined
    }
    
    func output() {
        for blockLine in blockList {
            for block in blockLine {
                print("\(block.toChar())", terminator: "")
            }
            print()
        }
    }
    private func maxDepth(input: String) -> Int {
        return input.map{ Int(String($0))! }.max()!
    }
}

let rawInput = "213"

let stage = Stage()

//// DUMMY
//stage.blockList = [
//    [BlockState.block, BlockState.water],
//    [BlockState.water, BlockState.water],
//]

stage.mapping(input: rawInput)

print("mapped")
stage.output()

stage.fill()

print("filled")
stage.output()

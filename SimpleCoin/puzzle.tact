import "@stdlib/deploy";

@name(get_data) 
native peekState_internal(): Cell;

message CheckLevelResult {
    name: String;
    completed: Bool;
}

message(296627) Flip {
  side: Bool;
}

fun computeNumber(a: Int, b: Int, c: Int): Int {
    return a * b + c + 1;
}

contract SimpleCoinLevel with Deployable {
  player: Address;
  nonce: Int;
  consecutiveWins: Int = 0;
  flipsCount: Int = 0;
  init(player: Address, nonce: Int){
    self.player = player;
    self.nonce = nonce;
  }

  receive(msg: Flip){
    let side = computeNumber(self.flipsCount, self.consecutiveWins, self.nonce) % 2 == 0;
    self.consecutiveWins = msg.side == side ? self.consecutiveWins + 1 : 0;
    self.flipsCount += 1;
  }

  receive("check"){
    send(SendParameters{
        to: sender(),
        value: 0,
        mode: SendRemainingValue,
        bounce: false,
        body: CheckLevelResult{
          name: "coin",
          completed: self.consecutiveWins >= 5
        }.toCell()
      }
    );
  }

  get fun consecutiveWins(): Int {
    return self.consecutiveWins;
  }

  get fun flipsCount(): Int {
    return self.flipsCount;
  }
  
  get(-11) fun peekState(): Cell {
     return peekState_internal();
  }
 
  get(-10) fun result(): Bool {
    return self.consecutiveWins >= 5;
  }
}

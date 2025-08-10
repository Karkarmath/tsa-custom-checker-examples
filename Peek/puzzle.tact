import "@stdlib/deploy";

message(0x5938) Unlock {
   password: Int as uint32;
}

message(0x1844) CheckLevelResult {
    name: String;
    completed: Bool;
}

message(0x2966) Check {
}

contract PeekLevel with Deployable {
  player: Address;
  nonce: Int;
  password: Int as uint32;
  locked: Bool = true;
  
  init(player: Address, nonce: Int, password: Int){
    self.player = player;
    self.nonce = nonce;
    self.password = password;
  }

  receive(msg: Unlock){
    require(msg.password == self.password, "Wrong password.");
    self.locked = false;
  }

  receive(_: Check){
    send(SendParameters{
        to: sender(),
        value: 0,
        mode: SendRemainingValue,
        bounce: false,
        body: CheckLevelResult{name: "peek", completed: !self.locked}.toCell()
      }
    );
  }

  get fun locked(): Bool {
    return self.locked;
  }
}

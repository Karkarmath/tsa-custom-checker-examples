import "@stdlib/deploy";
import "./messages";
message(0x6e38a063) ChangeLevelOwner {
  newOwner: Address;
}
message(0x6f13c225) ChangeClientOwner {
  newOwner: Address;
}
message(0xa4e501ef) ChangeOwnerInternal {
  newOwner: Address;
}

contract Manager with Deployable {
  client: Address;
  nonce: Int;
  init(client: Address, nonce: Int){
    self.client = client;
    self.nonce = nonce;
  }

  receive(msg: ChangeClientOwner){
    send(SendParameters{
        to: self.client,
        value: 0,
        bounce: false,
        mode: SendRemainingValue,
        body: ChangeOwnerInternal{newOwner: msg.newOwner}.toCell()
      }
    );
  }

  get(-30) fun client(): Address {
    return self.client
  }

  get(-31) fun nonce(): Int {
    return self.nonce
  }

  get(-32) fun cont_address(): Address {
    return myAddress()
  }
}

contract IntruderLevel with Deployable {
  owner: Address;
  player: Address;
  nonce: Int;
  manager: Address;
  init(player: Address, nonce: Int){
    self.owner = sender();
    self.player = player;
    self.nonce = nonce;
    self.manager = address("EQAGq420C-zLc7OcS30rtxLndMXEfZL3vbsE5RttWR8Ky0sr");
  }

  receive(msg: ChangeLevelOwner){
    require(sender() == self.owner, "Wrong sender.");
    send(SendParameters{
        to: self.manager,
        value: 0,
        bounce: false,
        mode: SendRemainingValue,
        body: ChangeClientOwner{newOwner: msg.newOwner}.toCell()
      }
    );
  }

  receive(msg: ChangeOwnerInternal){
    require(sender() == self.manager, "Wrong sender.");
    self.owner = msg.newOwner;
  }

  receive("check"){
    send(SendParameters{
        to: sender(),
        value: 0,
        mode: SendRemainingValue,
        bounce: false,
        body: CheckLevelResult{
          name: "intruder",
          completed: self.owner == self.player
        }.toCell()
      }
    );
  }

  get(-10) fun owner(): Address {
    return self.owner;
  }

  get(-21) fun player(): Address {
    return self.player;
  }

  get(-22) fun nonce(): Int {
    return self.nonce;
  }

  get(-23) fun manager(): Address {
    return self.manager;
  }

  get(-24) fun cont_address(): Address{
    return myAddress();
  }
}
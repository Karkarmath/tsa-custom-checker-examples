import "@stdlib/ownable";
import "@stdlib/deploy";
import "./messages";

contract Child with Deployable {
  parent: Address;
  nonce: Int;
  init(parent: Address, nonce: Int){
    self.parent = parent;
    self.nonce = nonce;
  }
}
message SendChildAddress {
  address: Address;
}

contract ScannerLevel with Ownable, Deployable {
  owner: Address;
  player: Address;
  nonce: Int;
  child: Address;
  init(player: Address, nonce: Int){
    self.owner = sender();
    self.player = player;
    self.nonce = nonce;
    self.child = address("EQAGq420C-zLc7OcS30rtxLndMXEfZL3vbsE5RttWR8Ky0sr");
  }

  receive(msg: SendChildAddress){
    require(msg.address == self.child, "Wrong child address.");
    self.owner = sender();
  }

  receive("check"){
    send(SendParameters{
        to: sender(),
        value: 0,
        mode: SendRemainingValue,
        bounce: false,
        body: CheckLevelResult{
          name: "scanner",
          completed: self.owner == self.player
        }.toCell()
      }
    );
  }

  get(-10) fun owner1(): Address {
    return self.owner;
  }

  get(-21) fun player(): Address {
    return self.player;
  }

  get(-22) fun nonce(): Int {
    return self.nonce;
  }

  get(-23) fun child(): Address {
    return self.child;
  }

  get(-24) fun cont_address(): Address{
    return myAddress();
  }
}
This is a simplified version of the COIN puzzle https://www.hacktheton.com/en/level/coin, in which instead of computing the coin toss using `initof` and `hashing`:
```
let init: StateInit = initOf Contract(self.flipsCount);
let contractAddress: Address = contractAddress(init);
let side = contractAddress.asSlice().asCell().hash() % 2 == 0;
```
We use an arithmetic function:
```
let side = computeNumber(self.flipsCount, self.consecutiveWins, self.nonce) % 2 == 0;
```
where `computeNumber` is:
```
fun computeNumber(a: Int, b: Int, c: Int): Int {
    return a * b + c + 1;
}
```

The puzzle was also modified so that it can be solved by sending at least 5 Flip messages, instead of 10 messages. The reason is that TSA already takes around 16 minutes to find out the guesses in each 
of those 5 messages, and sending even more messages would result in state explosion.

This experiment suggest that we should use TSA to analyze short transactions that require a small number of messages (no more than 5 messages). For transactions involving more than 5 messages, we should think of ways of splitting the analysis into several stages so that TSA is able to handle it.

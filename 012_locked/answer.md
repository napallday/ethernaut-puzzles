```
const key = await web3.eth.getStorageAt(contract.address, 5)
key.slice(0, 34)

await contract.locked()
```
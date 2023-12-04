# Verification Issue PoC

All contract deployments were performed with a private key stored in keystore.
All relevant parameters were passed in the environment variables
- `--rpc-url`
- `--verifier-url`
- `--etherscan-api-key`

## Gnosis Deployment
In first step the contract was deployed to Gnosis chain with the following command
```
forge create CounterForTestingVerification --account <DEPLOYER_ACCOUNT_NAME_IN_KEYSTORE> --verify
```
(all other key params in env variables)
The command produced the following output
```
[⠢] Compiling...
No files changed, compilation skipped
Deployer: 0x6c902797941E33187853dED359DEdcA37Ef8082F
Deployed to: 0x6426a0787a25A09291B470eF9224E9741Df0cB6c
Transaction hash: 0x0584c833847d0e8679e890cdc5b56c08181269221c79fd772fadcda040d317e5
Starting contract verification...
Waiting for etherscan to detect contract deployment...
Start verifying contract `0x6426a0787a25a09291b470ef9224e9741df0cb6c` deployed on xdai

Submitting verification for [src/CounterForTestingVerification.sol:CounterForTestingVerification] "0x6426a0787a25A09291B470eF9224E9741Df0cB6c".

Submitting verification for [src/CounterForTestingVerification.sol:CounterForTestingVerification] "0x6426a0787a25A09291B470eF9224E9741Df0cB6c".
Submitted contract for verification:
        Response: `OK`
        GUID: `u2mdi44hiz9egegy5fhexaecpz2pv3prklhddpgvsjtzw6ly4r`
        URL:
        https://blockscout.com/xdai/mainnet/address/0x6426a0787a25a09291b470ef9224e9741df0cb6c
Contract verification status:
Response: `NOTOK`
Details: `Pending in queue`
Contract verification status:
Response: `OK`
Details: `Pass - Verified`
Contract successfully verified
```
Which resulted in a successful deployment and verification

https://gnosisscan.io/address/0x6426a0787a25A09291B470eF9224E9741Df0cB6c#code

## Mainnet Deployment
Deployment on Ethereum Mainnet was performed with the following command
```
forge create CounterForTestingVerification --account PLAY_AROUND_DEPLOYER --verify
```
The values of the env variables were changed accordingly, to match the Ethereum Mainnet environment

The command produced the following output
```
[⠢] Compiling...
No files changed, compilation skipped
Deployer: 0x6c902797941E33187853dED359DEdcA37Ef8082F
Deployed to: 0x6426a0787a25A09291B470eF9224E9741Df0cB6c
Transaction hash: 0x8158ff9e9e6ba6ac889b30eec7b03fc27bc044ea3b76963f9467fabf1054110c
Starting contract verification...
Waiting for etherscan to detect contract deployment...
Start verifying contract `0x6426a0787a25a09291b470ef9224e9741df0cb6c` deployed on mainnet

Submitting verification for [src/CounterForTestingVerification.sol:CounterForTestingVerification] "0x6426a0787a25A09291B470eF9224E9741Df0cB6c".

Submitting verification for [src/CounterForTestingVerification.sol:CounterForTestingVerification] "0x6426a0787a25A09291B470eF9224E9741Df0cB6c".

Submitting verification for [src/CounterForTestingVerification.sol:CounterForTestingVerification] "0x6426a0787a25A09291B470eF9224E9741Df0cB6c".
Submitted contract for verification:
        Response: `OK`
        GUID: `zsgufzwtmdugfzusllsyjupm9fkjiabbr4fxnhgfvfbmmvrrqu`
        URL:
        https://etherscan.io/address/0x6426a0787a25a09291b470ef9224e9741df0cb6c
Contract verification status:
Response: `NOTOK`
Details: `Fail - Unable to verify. Compiled contract runtime bytecode does NOT match the on-chain runtime bytecode.`
Contract failed to verify.
```
After that the following command was run in order to manually verify the contract, with the following result
```
Start verifying contract `0x6426a0787a25a09291b470ef9224e9741df0cb6c` deployed on mainnet

Submitting verification for [src/CounterForTestingVerification.sol:CounterForTestingVerification] "0x6426a0787a25A09291B470eF9224E9741Df0cB6c".
Submitted contract for verification:
        Response: `OK`
        GUID: `uu3zn4ie8nynk7h1cdbsynb3xiqz4szjmgrkhrttshldk1c7rf`
        URL:
        https://etherscan.io/address/0x6426a0787a25a09291b470ef9224e9741df0cb6c
```
Despite the message signalling the verification process was a success, the verification was failing and the contract page on Etherscan was not showing the contract code.

### Temporary Solution

The contract was created with `pragma solidity ^0.8.13;` and then compiled with Solc `0.8.21`.
```
[⠢] Compiling...
[⠆] Compiling 2 files with 0.8.21
[⠰] Solc 0.8.21 finished in 1.03s
Compiler run successful!
```
The verification runs correctly only if the explicit version of the compiler used to compile the contract was passed.
The following command was successful and this time it resulted with the code showing on Etherscan
```
forge verify-contract 0x6426a0787a25A09291B470eF9224E9741Df0cB6c CounterForTestingVerification --compiler-version "0.8.21"
```
https://etherscan.io/address/0x6426a0787a25a09291b470ef9224e9741df0cb6c#code

## Mainnet Deployment (2nd Attempt)
The contract's pragma was changed from `pragma solidity ^0.8.13;` to `pragma solidity 0.8.20;`.
It was compiled successfully with a compiler of desired version
```
[⠢] Compiling...
[⠰] Compiling 24 files with 0.8.20
[⠘] Solc 0.8.20 finished in 3.27s
```
Then the contract was deployed with a failed attempt to verify in the same command
```
forge create CounterForTestingVerification --account PLAY_AROUND_DEPLOYER --verify
```
```
[⠢] Compiling...
No files changed, compilation skipped
Deployer: 0x6c902797941E33187853dED359DEdcA37Ef8082F
Deployed to: 0x1899D6C68fDb34a629Fd3379d258E4c832FE33A6
Transaction hash: 0xfc33289cb1354e377dbdbb6c28ab6dc4b875a06d1be0992a3ebccd26d128431c
Starting contract verification...
Waiting for etherscan to detect contract deployment...
Start verifying contract `0x1899d6c68fdb34a629fd3379d258e4c832fe33a6` deployed on mainnet

Submitting verification for [src/CounterForTestingVerification.sol:CounterForTestingVerification] "0x1899D6C68fDb34a629Fd3379d258E4c832FE33A6".
Submitted contract for verification:
        Response: `OK`
        GUID: `rqeyx6hz24eibfpf1ugmikbhshcziw7i8ptbfpkj3hpqeihxef`
        URL:
        https://etherscan.io/address/0x1899d6c68fdb34a629fd3379d258e4c832fe33a6
Contract verification status:
Response: `NOTOK`
Details: `Fail - Unable to verify. Compiled contract runtime bytecode does NOT match the on-chain runtime bytecode.`
Contract failed to verify.
```
The attempt to verify with the `verify-contract` command was also unsuccessful (despite `OK` response, the code was not showing on etherscan)
```
forge verify-contract 0x1899D6C68fDb34a629Fd3379d258E4c832FE33A6 CounterForTestingVerification
```
```
Start verifying contract `0x1899d6c68fdb34a629fd3379d258e4c832fe33a6` deployed on mainnet

Submitting verification for [src/CounterForTestingVerification.sol:CounterForTestingVerification] "0x1899D6C68fDb34a629Fd3379d258E4c832FE33A6".
Submitted contract for verification:
        Response: `OK`
        GUID: `1jrvxfemyqwjh6xmamnnzcjnirwm3iz6j3wntdhmnigupj1jtt`
        URL:
        https://etherscan.io/address/0x1899d6c68fdb34a629fd3379d258e4c832fe33a6
```
Only, again, the explicit passing of the desired compiler version helped.
```
forge verify-contract 0x1899D6C68fDb34a629Fd3379d258E4c832FE33A6 CounterForTestingVerification --compiler-version "0.8.20"
```
```
Start verifying contract `0x1899d6c68fdb34a629fd3379d258e4c832fe33a6` deployed on mainnet

Submitting verification for [src/CounterForTestingVerification.sol:CounterForTestingVerification] "0x1899D6C68fDb34a629Fd3379d258E4c832FE33A6".
Submitted contract for verification:
        Response: `OK`
        GUID: `8ujsgnz3c6jtjpqqqf9auww1sgvpyyrcjab6ntn8pqsc3uzt5r`
        URL:
        https://etherscan.io/address/0x1899d6c68fdb34a629fd3379d258e4c832fe33a6
```
https://etherscan.io/address/0x1899d6c68fdb34a629fd3379d258e4c832fe33a6#code

## Mainnet Deployment (3rd Attempt)
In the 3rd attempt the contract's pragma was set to `pragma solidity 0.8.21;`, so the compiler version specified in the code would exactly match the exact compiler version, the code is going to be compiled with.

The contract was compiled and deployed, with failed verification attempt:
```
  forge create CounterForTestingVerification --account PLAY_AROUND_DEPLOYER --verify
```
```
[⠢] Compiling...
[⠒] Compiling 24 files with 0.8.21
[⠊] Solc 0.8.21 finished in 3.46s
Compiler run successful!
Deployer: 0x6c902797941E33187853dED359DEdcA37Ef8082F
Deployed to: 0x70d061F5C0Dd807ab9345909B298fcFAdd9da082
Transaction hash: 0x44f4921f7cd9b0b5f7634dbdfd809628b831ed57350f5b23ddb7980d42e1ba21
Starting contract verification...
Waiting for etherscan to detect contract deployment...
Start verifying contract `0x70d061f5c0dd807ab9345909b298fcfadd9da082` deployed on mainnet

Submitting verification for [src/CounterForTestingVerification.sol:CounterForTestingVerification] "0x70d061F5C0Dd807ab9345909B298fcFAdd9da082".

Submitting verification for [src/CounterForTestingVerification.sol:CounterForTestingVerification] "0x70d061F5C0Dd807ab9345909B298fcFAdd9da082".
Submitted contract for verification:
        Response: `OK`
        GUID: `9gapsedv2m8kq33etsy9ukcu9gsmwzpbix65mmgrdi7ehvzrrt`
        URL:
        https://etherscan.io/address/0x70d061f5c0dd807ab9345909b298fcfadd9da082
Contract verification status:
Response: `NOTOK`
Details: `Pending in queue`
Contract verification status:
Response: `NOTOK`
Details: `Fail - Unable to verify. Compiled contract runtime bytecode does NOT match the on-chain runtime bytecode.`
Contract failed to verify.
```

Attempt to verify in a separate command is failing despite positive response as in previous examples

```
forge verify-contract 0x1899D6C68fDb34a629Fd3379d258E4c832FE33A6 CounterForTestingVerification
```
```
Start verifying contract `0x70d061f5c0dd807ab9345909b298fcfadd9da082` deployed on mainnet

Submitting verification for [src/CounterForTestingVerification.sol:CounterForTestingVerification] "0x70d061F5C0Dd807ab9345909B298fcFAdd9da082".
Submitted contract for verification:
        Response: `OK`
        GUID: `ukasqbrizztavdfy8aek3xs1bevhxxhuk84fcskqfetnfdjdyv`
        URL:
        https://etherscan.io/address/0x70d061f5c0dd807ab9345909b298fcfadd9da082
```
Again, explicit compiler specification was necessary in order for the contract to verify correctly
```
forge verify-contract 0x70d061F5C0Dd807ab9345909B298fcFAdd9da082 CounterForTestingVerification --compiler-version "0.8.21"
```
```
Start verifying contract `0x70d061f5c0dd807ab9345909b298fcfadd9da082` deployed on mainnet

Submitting verification for [src/CounterForTestingVerification.sol:CounterForTestingVerification] "0x70d061F5C0Dd807ab9345909B298fcFAdd9da082".
Submitted contract for verification:
        Response: `OK`
        GUID: `u7vtapu9ypax3c5curpn2cfexd7gtz5asia1gu1ffmhqiuewq3`
        URL:
        https://etherscan.io/address/0x70d061f5c0dd807ab9345909b298fcfadd9da082
```
https://etherscan.io/address/0x70d061f5c0dd807ab9345909b298fcfadd9da082#code

# Conclusion
It seems like the verifying script is not able to correctly detect the version of the compiler the contract was compiled with. Interestingly this issue only appears when interacting with Mainnet Etherscan and is not present for example on Gnosisscan.

The issue is manageable, as the contracts can be verified if the command is composed correctly, but it is a little annoying that the `forge create` command cannot take the explicit `--compiler-version` parameter, so the verification can be made successful and a separate command is needed to be run.

The preferred solution would be to fix the behavior of both of the `forge create` and `forge verify-contract` commands, so the can run smoothly without explicit compiler version passing.

Far less optimal, but also welcome would be to add the `--compiler-version` param to the `forge create` command, so the verification can work in the same flow as when using `forge verify-contract`.

# Replication
In order to replicate the described behavior, simply follow the exactly same steps that were taken by the author of this repo.

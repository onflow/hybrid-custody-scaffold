# 👋 Welcome Flow Developer!

### TODO:

- [ ] README
    - [ ] Interacting with HybridCustody
- [ ] Transfer ownership to @onflow
___

> :information_source: Be sure to check out the [Hybrid Custody docs](https://developers.flow.com/concepts/hybrid-custody) for more info and the [source repo](https://github.com/Flowtyio/restricted-child-account) for greater context.

This scaffold was created to make starting a Hybrid Custody project easier for you, and is a simplified template of the contents of [@Flowtyio/restricted-child-account](https://github.com/Flowtyio/restricted-child-account)

## 🔨 Getting started

Getting started can feel overwhelming, but we are here for you. Depending on how accustomed you are to Flow here's a list of resources you might find useful:

Cadence documentation: here you will find language reference for Cadence, which will be the language in which you develop your smart contracts,
Visual Studio Code and Cadence extension: we suggest using Visual Studio Code IDE for writing Cadence with the Cadence extension installed, that will give you nice syntax highlitning and additional smart features,
SDKs: here you will find a list of SDKs you can use to ease the interaction with Flow network (sending transactions, fetching accounts etc),
Tools: development tools you can use to make your development easier, Flowser can be super handy to see what's going on the blockchain while you develop
NFT Resources:

flow-nft: home of the Flow NFT standards, contains utility contracts, examples, and documentation,
nft-storefront: NFT Storefront is an open marketplace contract used by most Flow NFT marketplaces,
Flow NFT Catalog: list of NFT contracts on Flow, can be a valuable source to compose new projects or use as example,

## 📦 Project Structure

Your project comes with some standard folders which have a special purpose:

`/cadence` inside here is where your Cadence smart contracts code lives
`flow.json` configuration file for your project, you can think of it as package.json, but you don't need to worry, flow dev command will configure it for you

Inside `cadence` folder you will find:

`/contracts` location for Cadence contracts go in this folder
`/scripts` location for Cadence scripts goes here
`/transactions` location for Cadence transactions goes in this folder

## 👨‍💻 Start Developing

[Install Flow CLI](https://developers.flow.com/tooling/flow-cli/install)

From your workspace directory, setup your Flow project from a scaffold

    ```sh
    flow setup <YOUR_PROJECT_NAME> --scaffold
    ```

You'll be asked to select the scaffold number for this scaffold
    
```sh
✗ Enter the scaffold number:
```
    
Go ahead and enter the scaffold number for Hybrid Custody Project: `[4] Hybrid Custody Project` [TODO - confirm scaffold number after flow-cli PR]

```sh
✔ Enter the scaffold number: 4
```

Now, to get emulator running with deployed contracts, change to your project's directory
    
```sh
cd <YOUR_PROJECT_NAME>
```

Run the emulator
    
```sh
flow emulator --contracts
```

> :information_source: We use --contracts flag to include additional contracts we can then easily import into our project.

Deploy the scaffold project contracts
    
```sh
flow deploy
```

## 🏎️ Interacting with ExampleNFT

## 📚 Resources
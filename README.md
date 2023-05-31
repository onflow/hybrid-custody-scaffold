# 👋 Welcome Flow Developer!

### TODO:

- [ ] README
    - [ ] Interacting with HybridCustody
    - [ ] Resources
- [ ] Transfer ownership to @onflow
- [ ] Submit PR to flow-cli with scaffold info
- [ ] Update HC docs with Get Started CTA directing to scaffold info
___

> :information_source: Be sure to check out the [Hybrid Custody
> docs](https://developers.flow.com/concepts/hybrid-custody) for more info and the [source
> repo](https://github.com/Flowtyio/restricted-child-account) for the full code and contribution history.

This scaffold was created to make starting a Hybrid Custody project easier for you, and is a simplified template of the
contents of [@Flowtyio/restricted-child-account](https://github.com/Flowtyio/restricted-child-account)

## 🔨 Getting started

Getting started can feel overwhelming, but we are here for you. Depending on how accustomed you are to Flow, here's a
list of resources you might find useful:

- [Cadence documentation](https://developers.flow.com/cadence/language): here you will find language reference for
  Cadence, which will be the language in which you develop your smart contracts,
- [Visual Studio Code](https://code.visualstudio.com/?wt.mc_id=DX_841432) and [Cadence
  extension](https://marketplace.visualstudio.com/items?itemName=onflow.cadence): we suggest using Visual Studio Code
  IDE for writing Cadence with the Cadence extension installed, that will give you nice syntax highlitning and
  additional smart features,
- [SDKs](https://developers.flow.com/tools#sdks): here you will find a list of SDKs you can use to ease the interaction
  with Flow network (sending transactions, fetching accounts etc),
- [Tools](https://developers.flow.com/tools#development-tools): development tools you can use to make your development
  easier, 

**NFT Resources:**

- [flow-nft](https://github.com/onflow/flow-nft): home of the Flow NFT standards, contains utility contracts, examples,
  and documentation,
- [nft-storefront](https://github.com/onflow/nft-storefront/): NFT Storefront is an open marketplace contract used by
  most Flow NFT marketplaces,
- [Flow NFT Catalog](https://www.flow-nft-catalog.com/): list of NFT contracts on Flow, can be a valuable source to
  compose new projects or use as example,

## 📦 Project Structure

Your project comes with some standard folders which have a special purpose:

- `cadence/` inside here is where your Cadence smart contracts code lives
    - `contracts/` location for Cadence contracts go in this folder
    - `scripts/` location for Cadence scripts goes here
    - `transactions/` location for Cadence transactions goes in this folder
- `flow.json` configuration file for your project, you can think of it as package.json, but you don't need to worry,
  flow dev command will configure it for you

## 🤔 What is Hybrid Custody?

> :books: Read the full docs at [developers.flow.com/hybrid-custody](https://developers.flow.com/concepts/hybrid-custody)

The Hybrid Custody model on Flow enables developers to provide seamless onboarding and in-app experiences while
simultaneously empowering users with real ownership and self-sovereignty. With this new custodial model, developers can
deliver the benefits of both app and self-custody in a unified experience.

Hybrid Custody grants users full access to their linked child accounts without needing to interface with the child
account's custodial app, and the custodial app can interact with the relevant assets in the child account on behalf of
the user in a frictionless UX free from transaction prompts.

## 🧭 The Path to Hybrid Custody
1. The app creates, funds, and manages access to a Flow account initialized on user onboarding. This enables the app to abstract away the complexities of interacting with smart contract powered applications, and focus on creating slick user experiences behind familiar Web2 authentication and fiat denominated payments.
1. Once a user returns to the app with a self-custodial wallet, they can authenticate their wallet-managed account in the app, allowing the app to give the user's main account delegated access to the app managed account.
1. Upon linking, the user's main account - now the "parent" account - adds the app created account - now the "child" account - to a collection of all linked child accounts. At this point, Hybrid Custody is reached

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

Now, to get emulator running and deploy contracts. Change to your project's directory
    
```sh
cd <YOUR_PROJECT_NAME>
```

Run the emulator
    
```sh
flow emulator --contracts
```

> :information_source: We use `--contracts` flag to include additional contracts we can then easily import into our project.

Deploy the scaffold project contracts
    
```sh
flow deploy
```

You now have a running emulator instance with all project contracts deployed to `emulator-account`. We know this is the
account where contracts were deployed because of our `deployments` field in our [flow.json](./flow.json) file:

> :information_source: These contracts are not deployed to a single contract on testnet/mainnet, but are done so here
> for the sake of simplicity. Refer to contract aliases for contract deployment addresses.

```json
{
    "deployments": {
        "emulator": {
            "emulator-account": [
                "AddressUtils",
                "StringUtils",
                "ArrayUtils",
                "HybridCustody",
                "CapabilityProxy",
                "CapabilityFilter",
                "CapabilityFactory",
                "FTProviderFactory",
                "NFTProviderFactory",
                "NFTProviderAndCollectionFactory",
                "NFTCollectionPublicFactory",
                "ExampleToken"
            ]
        }
    }
}
```

## 🏎️ Interacting with HybridCustody

Now that the project contracts are deployed on a locally running emulator instance, we can start to interact with them.
Let's check out a ***progressive onboarding*** flow.

What is ***progressive onboarding***? It's the process of onboarding a new-to-Web3 user on to your application,
abstracting away onchain interactions, and on through to Hybrid Custody once they link their accounts

> :information_source: Make sure that you've performed the steps above and your emulator is running with contracts deployed.

### Create Dev Account

There are a number of ways you can create accounts for the purposes of your application. You could use a custodial service such as Niftory, craft your own backend account creation and custodial service, or simply run a transaction from an account you control. For simplicity and since everything boils down to the fundamentals, we'll continue by simply running an account creation transaction.

In order to create accounts on Flow, you'll need an account to begin with to both run the transaction and fund account creation. So let's do that via flow CLI:

```sh
flow accounts create # account name: dev
```

Name the account `dev` and select `Emulator` as your network.

If you take a look at your [flow.json](./flow.json), you should see the new account under the `accounts` field like so:

```json
"dev": {
    "address": "e03daebed8ca0615",
    "key": "5ea518f98a0c4f6341675e0b1596925cb331856b051744850bfeabf3e6ecddb5"
}
```

> :information_source: Note that your emulator environment tears down after it stops, so even though this `dev` account remains in your flow.json, it will only work for the length of the session in which is was created. Attempting to access this account in a new emulator instance will result in an error.

Lastly, we'll want to make sure this account has enough Flow balance to fund new account creation. The `emulator-account` is initialized with a sizable balance which we can transfer to the `dev` account - let's transfer 100.0 $FLOW:

```sh
 fts cadence/transactions/flow-token/transfer_flow.cdc e03daebed8ca0615 100.0
```

### Walletless Onboarding

Now that we have a dev account, we can create new accounts on Flow. [Walletless onboarding](./transactions/walletless_onboarding.cdc) is really pretty simple - you're creating an account, funding its creation and taking care custody on behalf of your user.

But first, we'll need to generate the key to add to the account.

```sh
flow keys generate
```

This will output a public/private key pair we'll use for the account we're about to create. Of course, in your app, you could handle custody any number of ways - store locally in secure enclave, key sharding protocols, KMS, etc. For our purposes here, we'll deal with this manually in a minute.

Copy the generated public key and add it as an argument in the following command along with the initial funding amount to add to the account we're going to create:

```sh
flow transactions send cadence/transactions/hybrid-custody/onboarding/walletless_onboarding.cdc <PUBLIC_KEY> <INITIAL_FUNDING_AMOUNT> --signer dev
```

> :information_source: If you need testnet $FLOW, check out the [testnet faucet](https://testnet-faucet.onflow.org/) :potable_water:

At the end of this transaction, a new account will be created with the provided public key added at full weight (1000.0).

Time to figure out the address of the account we just created. A number of events will be emitted, including `flow.AccountsCreated`. You can either look for this event manually in your terminal, or you can run the following command and refer to the event emitted in the latest block:

```sh
flow events get flow.AccountCreated
```

> :information_source: For more on subscribing to relevant events, check FCL documentation TODO

Now that we know the new account's address, we can add it to our flow.json. Of course, your app would manage custody much more elegantly. Add the following to your flow.json's `accounts` field. Recall the private key we generated previously.

```json
"child": {
    "address": "0x120e725050340cab",
    "key": "<GENERATED_PRIVATE_KEY>"
}
```

You did it - you just completed a walletless onboarding! Recall we:

1. Generated a public/private key pair
1. Submitted a transaction that:
    1. Created a new account
    1. Added the public key to that account
    1. Added initial funds to the new account
1. Custodied the corresponding private key

The `child` account in this instance would be an app-managed account. Next, we'll simulate the process of your app user creating their own wallet-managed account that will be used to manage their hybrid custody account.

### Create Parent Account

This step is pretty easy. Simply run:

```sh
flow accounts create # account name: parent
```

Name the account `parent` and select `Emulator` as your network.

### Configure CapabilityFilter & CapabilityFactory Resources

### Link Parent & Child Accounts

### Inspect Account Storage

### Bonus: Blockchain-Native Onboarding

## 📚 Resources
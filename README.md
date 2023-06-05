# 👋 Welcome Flow Developer!

<!-- ### Contribution Checklist

- [ ] Ensure contents are in sync with source repo: https://github.com/onflow/hybrid-custody
- [ ] Update the commit hash in @onflow/flow-cli/scaffolds.json: https://github.com/onflow/flow-cli/blob/master/scaffolds.json

-->

> :information_source: Be sure to check out the [Hybrid Custody
> docs](https://developers.flow.com/concepts/hybrid-custody) for more info and the [source
> repo](https://github.com/onflow/hybrid-custody) for the full code and contribution history. If you run
> into any issues with this scaffold, please create an issue
> [here](https://github.com/onflow/hybrid-custody-scaffold)

This scaffold was created to make starting and exploring a Hybrid Custody project easier for you, and is a simplified
template of the contents in [@onflow/hybrid-custody](https://github.com/onflow/hybrid-custody).
If building on these contracts, you might consider using [Git
Submodules](https://github.blog/2016-02-01-working-with-submodules/) to ensure your dependencies remain up to date.

# 🔨 Getting started

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
- [Account inspection](https://emulator.flowview.app/): Account inspector for all networks, including your localnet!

**NFT Resources:**

- [flow-nft](https://github.com/onflow/flow-nft): home of the Flow NFT standards, contains utility contracts, examples,
  and documentation,
- [nft-storefront](https://github.com/onflow/nft-storefront/): NFT Storefront is an open marketplace contract used by
  most Flow NFT marketplaces,
- [Flow NFT Catalog](https://www.flow-nft-catalog.com/): list of NFT contracts on Flow, can be a valuable source to
  compose new projects or use as example,

# 📦 Project Structure

Your project comes with some standard folders which have a special purpose:

- `cadence/` inside here is where your Cadence smart contracts code lives
    - `contracts/` location for Cadence contracts go in this folder
    - `scripts/` location for Cadence scripts goes here
    - `transactions/` location for Cadence transactions goes in this folder
- `flow.json` configuration file for your project, you can think of it as package.json. We'll dig more into this in a bit.

# 🤔 What is Hybrid Custody?

> :books: Read the full docs at [developers.flow.com/hybrid-custody](https://developers.flow.com/concepts/hybrid-custody)

The Hybrid Custody model on Flow enables developers to provide seamless onboarding and in-app experiences while
simultaneously empowering users with real ownership and self-sovereignty. With this new custodial model, developers can
deliver the benefits of both app and self-custody in a unified experience.

Hybrid Custody grants users access to their linked child accounts without needing to interface with the child
account's custodial app, and the custodial app can interact with the relevant assets in the child account on behalf of
the user in a frictionless UX free from transaction prompts.

## 🧭 The Path to Hybrid Custody
1. The app creates, funds, and manages access to a Flow account initialized on user onboarding. This enables the app to
   abstract away the complexities of interacting with smart contract powered applications, and focus on creating slick
   user experiences behind familiar Web2 authentication and fiat denominated payments.
1. Once a user returns to the app with a self-custodial wallet, they can authenticate their wallet-managed account in
   the app, allowing the app to give the user's main account delegated access to the app managed account (albeit with
   some developer-defined restrictions).
1. Upon linking, the user's main account - now the "parent" account - adds the app created account - now the "child"
   account - to a collection of all linked child accounts. At this point, Hybrid Custody is reached!

# 👨‍💻 Start Developing

> :warning: Note that the contracts in this scaffold are still under development and may undergo breaking changes. You
> can stay up to date on advancements and changes by following the [source
> repo](https://github.com/onflow/hybrid-custody).

[Install Flow CLI](https://developers.flow.com/tooling/flow-cli/install)

From your workspace directory, setup your Flow project from a scaffold

```sh
flow setup <YOUR_PROJECT_NAME> --scaffold
```

You'll be asked to select the scaffold number for this scaffold
    
```sh
✗ Enter the scaffold number:
```
    
Go ahead and enter the scaffold number for Hybrid Custody Project: `[4] Hybrid Custody Project`

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

> :information_source: These contracts are not deployed to a single contract on testnet/mainnet, but are done so here
> for the sake of simplicity. Refer to contract aliases for contract deployment addresses.

## 🏎️ Interacting with HybridCustody

Now that the project contracts are deployed on a locally running emulator instance, we can start to interact with them.
Let's check out a ***progressive onboarding*** flow.

What is ***progressive onboarding***? It's the process of onboarding a new-to-Web3 user on to your application,
abstracting away onchain interactions, and on through to Hybrid Custody once they link their accounts.

> :information_source: Make sure that you've performed the steps above and your emulator is running with contracts deployed.

## Create Dev Account

There are a number of ways you can create accounts for the purposes of your application. You could use a custodial
service, craft your own backend account creation and custodial service, or simply run a transaction from an account you
control. For simplicity and since everything boils down to the fundamentals, we'll continue by simply running an account
creation transaction.

In order to create accounts on Flow, you'll need an account to begin with to both run the transaction and fund account
creation. So let's do that via flow CLI:

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

> :information_source: Note that your emulator environment tears down after it stops, so even though this `dev` account
> remains in your flow.json, it will only work for the length of the session in which is was created. Attempting to
> access this account in a new emulator instance will result in an error.

Lastly, we'll want to make sure this account has enough Flow balance to fund new account creation. The
`emulator-account` is initialized with a sizable balance which we can transfer to the `dev` account - let's transfer
1000.0 $FLOW:

```sh
 fts cadence/transactions/flow-token/transfer_flow.cdc e03daebed8ca0615 1000.0
```

## Walletless Onboarding

Now that we have a funded dev account and we've configured it with the necessary resources & Capabilities, we can create
new app-controlled accounts on Flow. [Walletless onboarding](./transactions/walletless_onboarding.cdc) is really pretty simple - you're
creating an account, funding its creation and taking care custody on behalf of your user.

But first, we'll need to generate the key to add to the account.

```sh
flow keys generate
```

This will output a public/private key pair we'll use for the account we're about to create. Of course, in your app, you
could handle custody any number of ways - store locally in secure enclave, key sharding protocols, KMS, etc. For our
purposes here, we'll deal with this manually in a minute.

Copy the generated public key and add it as an argument in the following command along with the initial funding amount
to add to the account we're going to create:

```sh
flow transactions send cadence/transactions/hybrid-custody/onboarding/walletless_onboarding.cdc <PUBLIC_KEY> <INITIAL_FUNDING_AMOUNT> --signer dev
```

> :information_source: If you need testnet $FLOW, check out the [testnet faucet](https://testnet-faucet.onflow.org/)
> :potable_water:

At the end of this transaction, a new account will be created with the provided public key added at full weight
(1000.0).

Time to figure out the address of the account we just created. A number of events will be emitted, including
`flow.AccountsCreated`. You can either look for this event manually in your terminal, or you can run the following
command and refer to the event emitted in the latest block:

```sh
flow events get flow.AccountCreated
```

> :information_source: Your app will want to query for this event from the submitted transaction. Check out [this
> account creation
> example](https://github.com/onflow/faucet/blob/045ad28cb9c375871246e40a667dfb62202edcc9/lib/flow/account.ts#L43-L75)
> using FCL.

Now that we know the new account's address, we can add it to our flow.json. Of course, your app would manage custody
much more elegantly. Add the following to your flow.json's `accounts` field. Recall the private key we generated
previously.

```json
"child": {
    "address": "0x120e725050340cab",
    "key": "<GENERATED_PRIVATE_KEY>"
}
```

You did it - you just completed walletless onboarding!

Recall we:

1. Generated a public/private key pair
1. Submitted a transaction that:
    1. Created a new account
    1. Added the public key to that account
    1. Added initial funds to the new account
1. Custodied the corresponding private key

The `child` account in this instance would be an app-managed account. Next, we'll simulate the process of your app's
user creating their own wallet-managed account that will be linked to the account we just created to achieve Hybrid
Custody. But first we need to prepare the `dev` account.

## Configure CapabilityFilter & CapabilityFactory Resources

As noted in the full docs, the `HybridCustody` contract supports restricted access delegation. This means developers are
empowered to define limitations on the level of access a parent account can have on an app-managed Hybrid Custody
accounts.

Constructs in `CapabilityFilter` and `CapabilityFactory` contracts are utilized to define and enforce the Capability
Types accessible from linked child accounts. The simplest understanding of their respective roles is that a `Filter`
resource defines the accessible Types and `Factory` structs define the access pattern to retrieve those Capability Types
from an account.

For concrete examples of each, see [`AllowlistFilter`](./cadence/contracts/hybrid-custody/CapabilityFilter.cdc) and
[`NFTCollectionPublicFactory`](./cadence/contracts/hybrid-custody/factories/NFTCollectionPublicFactory.cdc)

> :information_source: To learn more about all these components, see the [Account Model
section](https://developers.flow.com/concepts/hybrid-custody/guides/account-model) of the full docs.

Before linking the `child` & `parent` accounts, we'll need to first configure the `CapabilityFilter` and
`CapabilityFactory` resources. We'll configure an `AllowAllFilter`, but consider `AllowlistFilter` and
`DenylistFilter`(or define your own) if you'd like to enforce restrictions on allowable Types.

```sh
flow transactions send cadence/transactions/filter/setup_allow_all.cdc --signer dev
```

Next, we'll configure a `CapabilityFactory.Manager`. The transaction we're about to run confures a `Manager` and adds a
number of NFT-related `Factory` implementations. Again, you're encouraged to define constructs that are relevant to your
use case.

```sh
flow transactions send cadence/transactions/factory/setup.cdc --signer dev
```

At the end of this, the `dev` account has `CapabilityFilter.AllowAllFilter` and a `CapabilityFactory.Manager` with a
number of `Factory` implementations configured. We'll use Capabilities on each when we link the `child` and `parent`
accounts.

> :information_source: You can inspect the developer account storage in [FlowView](https://emulator.flowview.app/), a
> super useful tool! Click on the link and search for the address you want to inspect. At this point, you should see the
> `AllowAllFilter` and `Manager` resources at their derived paths.

## Create Parent Account

This step is pretty easy. Simply run:

```sh
flow accounts create # account name: parent
```

Name the account `parent` and select `Emulator` as your network. Again, you'll find this account automatically added to
your flow.json.

In the progressive onboarding flow, this step emulates your user going to a wallet provider and creating self-managed
account. This is the account that will share access on the app-managed `child` account.

## Link Parent & Child Accounts

Time to link accounts and achieve Hybrid Custody!

There are two ways we could do this. If we have both accounts sign a single transaction, the link can be done in that
one transaction. However, we could also utilize the
[`AuthAccount.Inbox`](https://developers.flow.com/cadence/language/accounts#account-inbox) to perform an async account
link by first publishing a Capability the parent account later claims.

Pick your path and follow along:

<details>
<summary>Publish & Claim</summary>

First, we need to publish a `ProxyAccount` Capability for the parent account to claim, signing here as the child
account. Provide the `dev` account address as both the factory and filter addresses.

```sh
flow transactions send cadence/transactions/hybrid-custody/publish_to_parent.cdc \
    <PARENT_ADDRESS> <FACTORY_ADDRESS> <FILTER_ADDRESS> \
    --signer child
```

Once published, we sign with the parent account to claim the Capability. Note that the parent can set a `Filter` of its
own to prevent access to Capabilities it doesn't want. For our purposes, we'll pass `nil`, but the feature might be
useful for custodial wallet providers.

Let's now run the transaction, signing as the `parent` account to claim the 

```sh
flow transactions send cadence/transactions/hybrid-custody/reddem_account.cdc \
    <CHILD_ADDRESS> <FILTER_ADDRESS?> <FILTER_PATH?> \
    --signer parent
```

After both transactions have been sent, Hybrid Custody has been achieved, giving the parent account access to the child
account according to the rules defined in the Filter and accessible by the Factories.

</details>

<details>
<summary>Multisig</summary>

Let's prepare a single multisig transaction that will link the `child ` and `parent` accounts. Note that the parent can
set a `Filter` of its own to prevent access to Capabilities it doesn't want. For our purposes, we'll pass `nil`, but the
feature might be useful for custodial wallet providers.

First step is to build the transaction:

```sh
flow transactions build cadence/transactions/hybrid-custody/setup_multi_sig.cdc \
    <PARENT__FILTER_ADDRESS?> <CHILD_ACCOUNT_FACTORY_ADDRESS> <CHILD_ACCOUNT_FILTER_ADDRESS> \
    --proposer child \
    --payer child \
    --authorizer child \
    --authorizer parent \
    --filter payload \
    --save setup_multi_sig
```

With the transaction built, we need to sign with both signers:

```sh
flow transactions sign setup_multi_sig --signer child --signer parent --filter payload --save setup_multi_sig
```

Lastly, we'll send the signed transaction:

```sh
flow transactions send-signed setup_multi_sig
```

</details>

> :information_source: Again, you're encouraged to inspect account storage using
> [FlowView](https://emulator.flowview.app/). It can be helpful to understand the components involved in making Hybrid
> Custody function.

We can validate that the accounts have been linked by running a quick script returning `parent`'s linked Hybrid Custody
accounts.

```sh
flow scripts execute cadence/scripts/hybrid-custody/get_child_addresses.cdc <PARENT_ADDRESS>
```

## Bonus: Blockchain-Native Onboarding

Walletless onboarding lends a fantastic user experience for Web3 newcomers, but what about crypto-native users? 

Blockchain-native onboarding enables a user to log in with their wallet-managed account and link with an app-managed
account from the get go. This means the user starts your app with a Hybrid Custody account, enabling them to manage
accessible in-app assets from their main account while maintaining a seamless in-app experience.

> :warning: Before we can submit the blockchain-native onboarding transaction, we need to make sure the
> `CapabilityFilter` and `CapabilityFactory` resources are configured properly. If you haven't already, check out [that
> step above](#configure-capabilityfilter--capabilityfactory-resources) before continuing.
>
> You'll also want to ensure you've [created a `parent` account](#create-parent-account) to link to.

Now we can run the blockchain-native onboarding transaction, signing as the `dev` and `parent` accounts.

First we generate a public/private key pair to assign to the account we'll create in the transaction.

```sh
flow keys generate
```

You'll want to copy the public key as an argument and build the following multisig transaction:

```sh
flow transactions build cadence/transactions/hybrid-custody/onboarding/blockchain_native.cdc \
    <PUBLIC_KEY> <INITIAL_FUNDING_AMOUNT> <FACTORY_ADDRESS> <FILTER_ADDRESS> \
    --proposer dev \
    --payer dev \
    --authorizer parent \
    --authorizer dev \
    --filter payload \
    --save blockchain_native
```

Then we need to sign that transaction:

```sh
flow transactions sign blockchain_native --signer parent --signer dev --filter payload --save blockchain_native
```

And finally, send the signed transaction

```sh
flow transactions send-signed blockchain_native
```

You'll see a number of events emitted including account creation and account linking events. To validate the parent has
the child account added, let's query against the parent account

```sh
flow scripts execute cadence/scripts/hybrid-custody/get_child_addresses.cdc <PARENT_ADDRESS>
```

If you ran through both onboarding tracks, you should see two addresses returned. Otherwise, just the one created and
linked in the blockchain-native transaction will be present.

# 📚 Resources

- [Full Hybrid Custody docs](https://developers.flow.com/concepts/hybrid-custody)
- [Full Hybrid Custody repo](https://github.com/onflow/hybrid-custody)
- [#hybrid-custody Discord channel](https://discord.com/channels/613813861610684416/1087374662100602920)
import "FungibleToken"
import "FlowToken"

transaction(to: Address, amount: UFix64) {

    prepare(signer: AuthAccount) {
        let fromVault: &FungibleToken.Vault =   signer.borrow<&FungibleToken.Vault>(from: /storage/flowTokenVault)
            ?? panic("Problem getting signer's Flow Vault")
        let receiver: &{FungibleToken.Receiver} = getAccount(to).getCapability<&{FungibleToken.Receiver}>(
                /public/flowTokenReceiver
            ).borrow()
            ?? panic("Problem accessing Receiver reference")
        receiver.deposit(from: <-fromVault.withdraw(amount: amount))
    }
}
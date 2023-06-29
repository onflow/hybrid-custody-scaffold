import "CapabilityDelegator"
import "HybridCustody"

import "NonFungibleToken"
import "ExampleNFT"

pub fun main(parentAddress: Address, childAddress: Address): [Capability] {
    // Derive the Delegator path based on parent Address
    let delegatorPublicPath = PublicPath(
            identifier: HybridCustody.getCapabilityDelegatorIdentifier(parentAddress)
        ) ?? panic("invalid PublicPath")
    // Get the public Capabilities or panic if Delegator not found
    return getAccount(childAddress).getCapability<&CapabilityDelegator.Delegator{CapabilityDelegator.GetterPublic}>(
            delegatorPublicPath
        ).borrow()
        ?.getAllPublic()
        ?? panic("delegator not found")

}
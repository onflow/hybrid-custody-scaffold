import "CapabilityDelegator"
import "HybridCustody"

import "NonFungibleToken"
import "ExampleNFT"

pub fun main(parentAddress: Address, childAddress: Address): [Capability] {
    // Derive the Delegator path based on parent Address
    let delegatorPrivatePath = PrivatePath(
            identifier: HybridCustody.getCapabilityDelegatorIdentifier(parentAddress)
        ) ?? panic("invalid PrivatePath")
    // Get the private Capabilities or panic if Delegator not found
    return getAuthAccount(childAddress).getCapability<&CapabilityDelegator.Delegator{CapabilityDelegator.GetterPrivate}>(
            delegatorPrivatePath
        ).borrow()
        ?.getAllPrivate()
        ?? panic("could not borrow delegator")
}
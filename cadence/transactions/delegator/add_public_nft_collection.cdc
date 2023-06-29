import "CapabilityDelegator"
import "HybridCustody"

import "NonFungibleToken"
import "MetadataViews"
import "ExampleNFT"

transaction(parent: Address) {
    prepare(acct: AuthAccount) {
        let delegatorStoragePath = StoragePath(
                identifier: HybridCustody.getCapabilityDelegatorIdentifier(parent)
            ) ?? panic("invalid StoragePath")
        
        let delegator = acct.borrow<&CapabilityDelegator.Delegator>(from: delegatorStoragePath)
            ?? panic("delegator not found")
        
        let data = ExampleNFT.resolveView(Type<MetadataViews.NFTCollectionData>())! as! MetadataViews.NFTCollectionData
        
        let sharedCap = acct
            .getCapability<&ExampleNFT.Collection{ExampleNFT.ExampleNFTCollectionPublic, NonFungibleToken.CollectionPublic}>(
                ExampleNFT.CollectionPublicPath
            )
        
        delegator.addCapability(cap: sharedCap, isPublic: true)
    }
}

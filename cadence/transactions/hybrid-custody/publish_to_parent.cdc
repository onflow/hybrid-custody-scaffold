import "HybridCustody"
import "CapabilityFactory"
import "CapabilityFilter"
import "CapabilityDelegator"

import "MetadataViews"

transaction(parent: Address, factoryAddress: Address, filterAddress: Address) {
    prepare(acct: AuthAccount) {
        // Check AuthAccount Capability, linking if needed
        var acctCap = acct.getCapability<&AuthAccount>(HybridCustody.LinkedAccountPrivatePath)
        if !acctCap.check() {
            acctCap = acct.linkAccount(HybridCustody.LinkedAccountPrivatePath)!
        }
        // Check for OwnedAccount in signer where expected
        if acct.borrow<&HybridCustody.OwnedAccount>(from: HybridCustody.OwnedAccountStoragePath) == nil {
            let ownedAccount <- HybridCustody.createOwnedAccount(acct: acctCap)
            acct.save(<-ownedAccount, to: HybridCustody.OwnedAccountStoragePath)
        }

        // Check that paths are all configured properly
        acct.unlink(HybridCustody.OwnedAccountPrivatePath)
        acct.link<&HybridCustody.OwnedAccount{HybridCustody.BorrowableAccount, HybridCustody.OwnedAccountPublic, MetadataViews.Resolver}>(HybridCustody.OwnedAccountPrivatePath, target: HybridCustody.OwnedAccountStoragePath)

        acct.unlink(HybridCustody.OwnedAccountPublicPath)
        acct.link<&HybridCustody.OwnedAccount{HybridCustody.OwnedAccountPublic}>(HybridCustody.OwnedAccountPublicPath, target: HybridCustody.OwnedAccountStoragePath)

        // Prepare OwnedAccount reference, CapabilityFactory & CapabilityFilter Capabilities
        let owned = acct.borrow<&HybridCustody.OwnedAccount>(from: HybridCustody.OwnedAccountStoragePath)
            ?? panic("owned account not found")

        let factory = getAccount(factoryAddress).getCapability<&CapabilityFactory.Manager{CapabilityFactory.Getter}>(CapabilityFactory.PublicPath)
        assert(factory.check(), message: "factory address is not configured properly")

        let filter = getAccount(filterAddress).getCapability<&{CapabilityFilter.Filter}>(CapabilityFilter.PublicPath)
        assert(filter.check(), message: "capability filter is not configured properly")

        // Finally, configure & publish ChildAccount Capability to parent
        owned.publishToParent(parentAddress: parent, factory: factory, filter: filter)
    }
}
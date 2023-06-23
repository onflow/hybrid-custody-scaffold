import "HybridCustody"
import "MetadataViews"

pub fun main(addr: Address, name: String, desc: String, thumbnail: String): MetadataViews.Display? {
    let acct = getAuthAccount(addr)
    let owned = acct.borrow<&HybridCustody.OwnedAccount>(from: HybridCustody.OwnedAccountStoragePath)
        ?? panic("no owned account found")
    return owned.resolveView(Type<MetadataViews.Display>()) as! MetadataViews.Display?
}
import "HybridCustody"
import "MetadataViews"

pub fun main(addr: Address, name: String, desc: String, thumbnail: String): MetadataViews.Display? {
    let acct = getAuthAccount(addr)
    let child = acct.borrow<&HybridCustody.ChildAccount>(from: HybridCustody.ChildStoragePath)
        ?? panic("no child account found")
    return child.resolveView(Type<MetadataViews.Display>()) as! MetadataViews.Display?
}
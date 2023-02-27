import Twitter from "../contracts/Twitter.cdc"

pub fun main(): [UInt64] {
   let cap = getAccount(0x01).getCapability(/public/TweetCollection).borrow<&{Twitter.CollectionPublic}>()

   return cap!.getIDs()
 
}

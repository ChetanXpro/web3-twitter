import Twitter from "../contracts/Twitter.cdc"

pub fun main(account:Address): [UInt64] {
   let cap = getAccount(account).getCapability(/public/TweetCollection).borrow<&{Twitter.CollectionPublic}>()

   return cap!.getIDs()
 
}

import Twitter from "../contracts/Twitter.cdc"

pub fun main(account:Address,id:UInt64): &Twitter.Tweet? {
   let cap = getAccount(account).getCapability(/public/TweetCollection).borrow<&{Twitter.CollectionPublic}>()

   return cap?.borrowTweet(id: id) ?? panic("")
 
}

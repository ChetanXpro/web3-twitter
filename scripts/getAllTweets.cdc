import Twitter from "../contracts/Twitter.cdc"

pub fun main(account:Address): [&Twitter.Tweet?] {
   let cap = getAccount(account).getCapability(/public/TweetCollection).borrow<&{Twitter.CollectionPublic}>()

   
   let allId = cap!.getIDs()

   var allTweets:[&Twitter.Tweet?] = []

   for id in allId  {
     let cap = getAccount(account).getCapability(/public/TweetCollection).borrow<&{Twitter.CollectionPublic}>()
      let tweet = cap?.borrowTweet(id: id) ?? panic("")

      allTweets.append(tweet)
   }


    return allTweets
}

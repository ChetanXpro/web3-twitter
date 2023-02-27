import Twitter from "../contracts/Twitter.cdc"


transaction(message:String){
prepare(auth:AuthAccount){
 let collection = auth.borrow<&Twitter.Collection>(from: /storage/TweetCollection)
   
   collection?.saveTweet(tweet: <- Twitter.createTweet(message))
    }


}
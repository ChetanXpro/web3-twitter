import Twitter from "../contracts/Twitter.cdc"


transaction{
prepare(auth:AuthAccount){
  auth.save(<- Twitter.createEmptyCollection(), to: Twitter.TweetCollectionStoragePath)
   auth.link<&{Twitter.CollectionPublic}>(Twitter.TweetCollectionPublicPath, target: Twitter.TweetCollectionStoragePath)
    }


}
import Twitter from "../contracts/Twitter.cdc"


transaction{
prepare(auth:AuthAccount){
  auth.link<&{Twitter.CollectionPublic}>(Twitter.TweetCollectionPublicPath, target: Twitter.TweetCollectionStoragePath)
 }


}
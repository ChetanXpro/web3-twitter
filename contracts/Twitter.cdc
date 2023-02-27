
pub contract Twitter {

    pub let TweetCollectionStoragePath: StoragePath
    pub let TweetCollectionPublicPath: PublicPath

    pub resource Tweet {
        pub let id: UInt64

        pub var metadata: {String: String}

        init(message: String) {
            self.id = self.uuid
            self.metadata = {
                "message": message
            }
        }
    }

    pub fun createTweet(_ message: String): @Tweet {
        return <-create Tweet(message: message)
    }
   pub resource interface CollectionPublic {
        pub fun getIDs(): [UInt64]
        pub fun borrowTweet(id: UInt64): &Tweet? 
    }

    pub resource Collection: CollectionPublic {
 
        pub var tweets: @{UInt64: Tweet}

     
        pub fun saveTweet(tweet: @Tweet) {
         
            self.tweets[tweet.id] <-! tweet
        }

       
        pub fun getIDs(): [UInt64] {
            return self.tweets.keys
        }

        pub fun borrowTweet(id:UInt64):&Tweet?{
            pre {
                self.tweets[id] != nil 
            }
          return &self.tweets[id] as &Twitter.Tweet?
        }

        init() {
            self.tweets <- {}
        }

        destroy() {
         
            destroy self.tweets
        }
    }

    pub fun createEmptyCollection(): @Collection {
        return <- create Collection()
    }

    init() {
  
        
        self.TweetCollectionStoragePath = /storage/TweetCollection
        self.TweetCollectionPublicPath = /public/TweetCollection
     
        self.account.save(<-self.createEmptyCollection(), to: self.TweetCollectionStoragePath)
    
        self.account.link<&{CollectionPublic}>(self.TweetCollectionPublicPath, target: self.TweetCollectionStoragePath)
    }
}
 
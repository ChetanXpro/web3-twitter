
pub contract Twitter {

    pub let TweetCollectionStoragePath: StoragePath

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


    pub resource Collection {
 
        pub var tweets: @{UInt64: Tweet}

     
        pub fun saveTweet(tweet: @Tweet) {
         
            self.tweets[tweet.id] <-! tweet
        }

       
        pub fun getIDs(): [UInt64] {
            return self.tweets.keys
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
   
        self.account.save(<-self.createEmptyCollection(), to: self.TweetCollectionStoragePath)
    }
}
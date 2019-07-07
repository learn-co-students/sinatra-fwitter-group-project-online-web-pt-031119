mike = User.new({username: "Mike", email: "mike@home.com", password: "elementary"})
malki = User.new({username: "Malki", email: "malki@home.com", password: "primary"})
annette = User.new({username: "Annette", email: "annette@home.com", password: "secondary"})

# And tweet some stuff
mike.tweets.build({content: "Isn't programming great fun?"})
malki.tweets.build({content: "It sure is!"})
annette.tweets.build({content: "I agree completely!"})

mike.tweets.build({content: "I'm really enjoying the curriculum so far."})
malki.tweets.build({content: "Yes, I can hardly wait for rails."})
annette.tweets.build({content: "Hey, do you guys use a local IDE?"})

mike.tweets.build({content: "Yes, I set mine up yesterday. It's great so far."})
malki.tweets.build({content: "I've been using one for a while."})

mike.tweets.build({content: "I'm using Visual Studio Code, which I think has better debugging capabiligy."})

annette.tweets.build({content: "Interesting.  I might check that out."})

#and save them
mike.save
malki.save
annette.save

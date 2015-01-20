`
2.2.0 :041 > Brewery.create name:"BrewDog", year:2007
   (0.1ms)  begin transaction
  SQL (0.4ms)  INSERT INTO "breweries" ("name", "year", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["name", "BrewDog"], ["year", 2007], ["created_at", "2015-01-20 09:07:18.326009"], ["updated_at", "2015-01-20 09:07:18.326009"]]
   (115.9ms)  commit transaction
 => #<Brewery id: 4, name: "BrewDog", year: 2007, created_at: "2015-01-20 09:07:18", updated_at: "2015-01-20 09:07:18"> 
2.2.0 :042 > bd = _
 => #<Brewery id: 4, name: "BrewDog", year: 2007, created_at: "2015-01-20 09:07:18", updated_at: "2015-01-20 09:07:18"> 
2.2.0 :043 > bd.beers.create name:"Punk IPA", style:"IPA"
   (0.1ms)  begin transaction
  SQL (0.3ms)  INSERT INTO "beers" ("name", "style", "brewery_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["name", "Punk IPA"], ["style", "IPA"], ["brewery_id", 4], ["created_at", "2015-01-20 09:07:49.865419"], ["updated_at", "2015-01-20 09:07:49.865419"]]
   (105.3ms)  commit transaction
 => #<Beer id: 8, name: "Punk IPA", style: "IPA", brewery_id: 4, created_at: "2015-01-20 09:07:49", updated_at: "2015-01-20 09:07:49"> 
2.2.0 :044 > bd.beers.create name:"Nanny State", style:"lowalcohol" 
   (0.1ms)  begin transaction
  SQL (0.3ms)  INSERT INTO "beers" ("name", "style", "brewery_id", "created_at", "updated_at") VALUES (?, ?, ?, ?, ?)  [["name", "Nanny State"], ["style", "lowalcohol"], ["brewery_id", 4], ["created_at", "2015-01-20 09:08:03.906694"], ["updated_at", "2015-01-20 09:08:03.906694"]]
   (76.3ms)  commit transaction
 => #<Beer id: 9, name: "Nanny State", style: "lowalcohol", brewery_id: 4, created_at: "2015-01-20 09:08:03", updated_at: "2015-01-20 09:08:03"> 
2.2.0 :045 > nanny = _
 => #<Beer id: 9, name: "Nanny State", style: "lowalcohol", brewery_id: 4, created_at: "2015-01-20 09:08:03", updated_at: "2015-01-20 09:08:03"> 
2.2.0 :046 > punk = bd.beers.first
  Beer Load (0.3ms)  SELECT  "beers".* FROM "beers" WHERE "beers"."brewery_id" = ?  ORDER BY "beers"."id" ASC LIMIT 1  [["brewery_id", 4]]
 => #<Beer id: 8, name: "Punk IPA", style: "IPA", brewery_id: 4, created_at: "2015-01-20 09:07:49", updated_at: "2015-01-20 09:07:49"> 
2.2.0 :047 > nanny.ratings.create score:10
   (0.1ms)  begin transaction
  SQL (0.3ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 10], ["beer_id", 9], ["created_at", "2015-01-20 09:08:33.557223"], ["updated_at", "2015-01-20 09:08:33.557223"]]
   (124.4ms)  commit transaction
 => #<Rating id: 1, score: 10, beer_id: 9, created_at: "2015-01-20 09:08:33", updated_at: "2015-01-20 09:08:33"> 
2.2.0 :048 > nanny.ratings.create score:14
   (0.1ms)  begin transaction
  SQL (0.3ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 14], ["beer_id", 9], ["created_at", "2015-01-20 09:08:36.784577"], ["updated_at", "2015-01-20 09:08:36.784577"]]
   (108.4ms)  commit transaction
 => #<Rating id: 2, score: 14, beer_id: 9, created_at: "2015-01-20 09:08:36", updated_at: "2015-01-20 09:08:36"> 
2.2.0 :049 > nanny.ratings.create score:20
   (0.1ms)  begin transaction
  SQL (0.4ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 20], ["beer_id", 9], ["created_at", "2015-01-20 09:08:41.500402"], ["updated_at", "2015-01-20 09:08:41.500402"]]
   (146.5ms)  commit transaction
 => #<Rating id: 3, score: 20, beer_id: 9, created_at: "2015-01-20 09:08:41", updated_at: "2015-01-20 09:08:41"> 
2.2.0 :050 > punk.ratings.create score:40
   (0.1ms)  begin transaction
  SQL (0.3ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 40], ["beer_id", 8], ["created_at", "2015-01-20 09:08:50.642970"], ["updated_at", "2015-01-20 09:08:50.642970"]]
   (138.9ms)  commit transaction
 => #<Rating id: 4, score: 40, beer_id: 8, created_at: "2015-01-20 09:08:50", updated_at: "2015-01-20 09:08:50"> 
2.2.0 :051 > punk.ratings.create score:0
   (0.1ms)  begin transaction
  SQL (0.4ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 0], ["beer_id", 8], ["created_at", "2015-01-20 09:08:53.644660"], ["updated_at", "2015-01-20 09:08:53.644660"]]
   (141.2ms)  commit transaction
 => #<Rating id: 5, score: 0, beer_id: 8, created_at: "2015-01-20 09:08:53", updated_at: "2015-01-20 09:08:53"> 
2.2.0 :052 > punk.ratings.create score:15
   (0.1ms)  begin transaction
  SQL (0.3ms)  INSERT INTO "ratings" ("score", "beer_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["score", 15], ["beer_id", 8], ["created_at", "2015-01-20 09:08:55.794298"], ["updated_at", "2015-01-20 09:08:55.794298"]]
   (129.2ms)  commit transaction
 => #<Rating id: 6, score: 15, beer_id: 8, created_at: "2015-01-20 09:08:55", updated_at: "2015-01-20 09:08:55"> 


`

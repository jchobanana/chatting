namespace :dev do


  task :park => :environment do

    url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=8f6fcb24-290b-461d-9d34-72ed1b3f51f0"

    json_string = RestClient.get(url)

    data = JSON.parse( json_string )

    data["result"]["results"].each do |p|
      existing = Park.find_by_raw_id( p["_id"] )
      if existing
        #update
      else
        Park.create( :raw_id => p["_id"], :name => p["ParkName"])
        puts "create #{p["ParkName"]}"
      end
    end

end


  task :fake => :environment do
    Topic.delete_all
    Comment.delete_all

    users = []
    10.times do
      users << User.create!( :email => Faker::Internet.email, :password => "12345678" )
    end

    100.times do
      t = Topic.create!( :subject => Faker::Lorem.sentence,
                     :content => Faker::Lorem.paragraph,
                     :status => "published",
                     :user => users.sample  )

      (5 + rand(10)).times do
        t.comments.create!( :content => Faker::Lorem.sentence,
                            :user => users.sample )
      end
    end

  end
end

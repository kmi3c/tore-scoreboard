def rand_days
  u_days = {}
  sample = [0,1,2,3,4,5,6,7,8,9,10]
  (1..5).each do |i|
    u_days[['day',i].join().to_sym] = sample.sample
  end
  u_days[:finale] = sample.sample
  u_days
end
10.times do
  User.create do |u|
    u.first_name = Faker::Name::first_name
    u.last_name = Faker::Name::last_name
    u.nickname = Faker::Internet.user_name
    u.email = Faker::Internet::safe_email(u.nickname)
    u.adult = true
    u.signature_json = {}
    u.signature_url = "http://dummyimage.com/198x55/ffffff/0011ff.png&text=#{u.first_name}+#{u.last_name}"
  end
end
User.all.each do |u|
  r = rand_days
  u.update_columns(r)
  u.update_column(:score,(r.values-['-']).inject(&:+))
end



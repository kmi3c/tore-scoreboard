def rand_days
  r_days = User.user_days.except!('TOTAL').dup
  r_days.each do |d,i|
    r_days[d] = ['-',1,2,3,4,5,6,7,8,9,10].sample
  end
end
10.times do
  User.create do |u|
    u.first_name = Faker::Name::first_name
    u.last_name = Faker::Name::last_name
    u.nickname = Faker::Internet.user_name
    u.email = Faker::Internet::safe_email(u.nickname)
    u.adult = true
    u.signature_url = "http://dummyimage.com/198x55/ffffff/0011ff.png&text=#{u.first_name}+#{u.last_name}"
  end
end
User.all.each do |u|
  r = rand_days
  u.update_column(:days,r)
  u.update_column(:score,(r.values-['-']).inject(&:+))
end



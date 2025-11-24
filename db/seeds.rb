# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.find_or_create_by!(name: "admin", email: "admin@example.com") do |a|
  a.password = ENV['SECRET_KEY']
end

shizuoka = Prefecture.find_or_create_by!(name: "静岡県") do |a|
  a.latitude = "34.9385"
  a.longitude = "138.026"
  if File.exist?("#{Rails.root}/db/fixtures/shizuoka.jpg")
    a.prefecture_image = ActiveStorage::Blob.create_and_upload!(
      io: File.open("#{Rails.root}/db/fixtures/shizuoka.jpg"), 
      filename:"shizuoka.jpg"
    )
  end
end

tokyo = Prefecture.find_or_create_by!(name: "東京都") do |a|
  a.latitude = "35.6995"
  a.longitude = "139.753"
  if File.exist?("#{Rails.root}/db/fixtures/tokyo.jpg")
    a.prefecture_image = ActiveStorage::Blob.create_and_upload!(
      io: File.open("#{Rails.root}/db/fixtures/tokyo.jpg"), 
      filename:"tokyo.jpg"
    )
  end
end

osaka = Prefecture.find_or_create_by!(name: "大阪府") do |a|
  a.latitude = "34.6558"
  a.longitude = "135.506"
  if File.exist?("#{Rails.root}/db/fixtures/osaka.jpg")
    a.prefecture_image = ActiveStorage::Blob.create_and_upload!(
      io: File.open("#{Rails.root}/db/fixtures/osaka.jpg"), 
      filename:"osaka.jpg"
    )
  end
end

aichi = Prefecture.find_or_create_by!(name: "愛知県") do |a|
  a.latitude = "35.1849"
  a.longitude = "136.9"
  if File.exist?("#{Rails.root}/db/fixtures/aichi.jpg")
    a.prefecture_image = ActiveStorage::Blob.create_and_upload!(
      io: File.open("#{Rails.root}/db/fixtures/aichi.jpg"), 
      filename:"aichi.jpg"
    )
  end
end

course1 = shizuoka.courses.find_or_create_by!(name: "富士山カントリークラブ") do |a|
  a.address = "富士宮市北山"
  a.latitude = "35.3615"
  a.longitude = "138.727"
  if File.exist?("#{Rails.root}/db/fixtures/course_1.jpg")
    a.course_image = ActiveStorage::Blob.create_and_upload!(
      io: File.open("#{Rails.root}/db/fixtures/course_1.jpg"), 
      filename:"course_1.jpg"
    )
  end
end

course2 = tokyo.courses.find_or_create_by!(name: "東都タワーカントリークラブ") do |a|
  a.address = "東京都 港区芝公園４丁目２−８"
  a.latitude = "35.6589"
  a.longitude = "139.745"
  if File.exist?("#{Rails.root}/db/fixtures/course_2.jpg")
    a.course_image = ActiveStorage::Blob.create_and_upload!(
      io: File.open("#{Rails.root}/db/fixtures/course_2.jpg"), 
      filename:"course_2.jpg"
    )
  end
end

course3 = osaka.courses.find_or_create_by!(name: "阪神城カントリークラブ") do |a|
  a.address = "東大阪府 大阪市中央区大阪城１−１"
  a.latitude = "34.6925"
  a.longitude = "135.525"
  if File.exist?("#{Rails.root}/db/fixtures/course_3.jpg")
    a.course_image = ActiveStorage::Blob.create_and_upload!(
      io: File.open("#{Rails.root}/db/fixtures/course_3.jpg"), 
      filename:"course_3.jpg"
    )
  end
end

suzuki = shizuoka.customers.find_or_create_by!(name: "スズキ") do |a|
  a.email = "sample1@example.com"
  a.password = "123456"
  a.address = "富士市富士町１１１"
  a.history = 1.0
  if File.exist?("#{Rails.root}/db/fixtures/suzuki.png")
    a.profile_image = ActiveStorage::Blob.create_and_upload!(
      io: File.open("#{Rails.root}/db/fixtures/suzuki.png"), 
      filename:"suzuki.png"
    )
  end
end

yamada = tokyo.customers.find_or_create_by!(name: "ヤマダ") do |a|
  a.email = "sample2@examsample.com"
  a.password = "123456"
  a.address = "東都区東都２丁目２−２"
  a.history = 2.0
  if File.exist?("#{Rails.root}/db/fixtures/yamada.png")
    a.profile_image = ActiveStorage::Blob.create_and_upload!(
      io: File.open("#{Rails.root}/db/fixtures/yamada.png"), 
      filename:"yamada.png"
    )
  end
end

sato = osaka.customers.find_or_create_by!(name: "サトウ") do |a|
  a.email = "sample3@examsample.com"
  a.password = "123456"
  a.address = "大阪市大阪区阪神城３丁目３−３"
  a.history = 3.0
  if File.exist?("#{Rails.root}/db/fixtures/sato.png")
    a.profile_image = ActiveStorage::Blob.create_and_upload!(
      io: File.open("#{Rails.root}/db/fixtures/sato.png"), 
      filename:"sato.png"
    )
  end
end

suzukiichiro = aichi.customers.find_or_create_by!(name: "スズキイチロウ") do |a|
  a.email = "sample4@example.com"
  a.password = "123456"
  a.address = "名古屋市千種区若水３丁目２−１２"
  a.history = 4.0
  if File.exist?("#{Rails.root}/db/fixtures/suzukiichiro.png")
    a.profile_image = ActiveStorage::Blob.create_and_upload!(
      io: File.open("#{Rails.root}/db/fixtures/suzukiichiro.png"), 
      filename:"suzukiichiro.png"
    )
  end
end

post1 = suzuki.posts.find_or_create_by!(round_day: "2025-11-11") do |a|
  a.course = course1
  a.golf_score = "111"
  a.sentence = "日本一に恥じない難しいコースでした。"
  a.score = 3
end

post2 = yamada.posts.find_or_create_by!(round_day: "2025-11-12") do |a|
  a.course = course2
  a.golf_score = "102"
  a.sentence = "初心者向けのコースでもあり、ベストスコアを出すことができました。"
  a.score = 4
end


comment1 = yamada.post_comments.find_or_create_by!(post_id: post1.id) do |c|
  c.comment = "私もいつか挑んでみます！"
end

comment2 = suzuki.post_comments.find_or_create_by!(post_id: post2.id) do |c|
  c.comment = "ベストスコアおめでとうございます！"
end
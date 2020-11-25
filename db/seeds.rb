# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'
require 'date'
require 'open-uri'

ActiveRecord::Base.transaction do
  #View.destroy_all
  #Vote.destroy_all
  #Comment.destroy_all
  Video.destroy_all
  User.destroy_all

  p 'creating content creators...'
  demo_user = User.create!(channel_name: 'Demo User', first_name: 'Demo', last_name: 'User', email: 'demouser@gmail.com', password: 'password')

  content_creators = [demo_user]

  4.times do |n|
    channel_name = Faker::Internet.username(specifier: 5..8)
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = Faker::Internet.email(name: "#{first_name} #{last_name}", separators: '_')
    user = User.create!(
      channel_name: channel_name, 
      first_name: first_name, 
      last_name: last_name, 
      email: email, 
      password: 'password' 
    )
    content_creators << user
  end

  videoUrls = [
    "https://we-tube-seed.s3.amazonaws.com/Audio_bands_Feed.mov",
    "https://we-tube-seed.s3.amazonaws.com/autonomous-grand-piano.mp4",
    "https://we-tube-seed.s3.amazonaws.com/beach.mp4",
    "https://we-tube-seed.s3.amazonaws.com/cat-family.mp4",
    "https://we-tube-seed.s3.amazonaws.com/Creatures+Underwater.mp4",
    "https://we-tube-seed.s3.amazonaws.com/Dogs+Digging.mp4", 
    "https://we-tube-seed.s3.amazonaws.com/fall-road.mp4",
    "https://we-tube-seed.s3.amazonaws.com/jellyfish.mp4",
    "https://we-tube-seed.s3.amazonaws.com/kid-on-electric-kit.mp4", 
    "https://we-tube-seed.s3.amazonaws.com/kitten-vs-tape.mp4",
    "https://we-tube-seed.s3.amazonaws.com/lights.mp4",
    "https://we-tube-seed.s3.amazonaws.com/mixkit-crowds-of-people-cross-a-street-junction-4401.mp4",
    "https://we-tube-seed.s3.amazonaws.com/mountain.mp4",
    "https://we-tube-seed.s3.amazonaws.com/telephone.mp4", 
    "https://we-tube-seed.s3.amazonaws.com/tide.mp4",
    "https://we-tube-seed.s3.amazonaws.com/traditional-music.mp4",
    "https://we-tube-seed.s3.amazonaws.com/waterfall.mp4",
    "https://we-tube-seed.s3.amazonaws.com/wind-chimes.mp4"
  ]
  

  p 'creating content...'

  videos = videoUrls.map do |url|
    creator = content_creators.sample
    video = Video.new(
      title: Faker::TvShows::BreakingBad.episode,
      description: Faker::TvShows::VentureBros.quote,
      uploader_id: creator.id
    )

    submission = open(url)
    p "uploading video..."
    video.attach(io: submission, filename: "#{creator.email}_#{rand(1..1000)}" )
    video.save!
  end
end
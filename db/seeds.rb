# frozen_string_literal: true

category_names = ['ruby', 'java', 'js', 'c++']
category_names.each { |name| PostCategory.create(name: name) }
categories = PostCategory.all

5.times do
  user = User.create!(email: "#{Faker::Lorem.word}@gmail.com", password: '#$taawktljasktlw4aaglj', password_confirmation: '#$taawktljasktlw4aaglj')

  5.times do
    user.posts.create!(title: Faker::Lorem.characters(number: 10), body: Faker::Lorem.sentence(word_count: 100), creator: user, post_category: categories.sample)
  end
end

100.times do
  title = Faker::Lorem.question
  body = Faker::Lorem.paragraph(sentence_count: 6)
  Question.create title: title, body: body
end
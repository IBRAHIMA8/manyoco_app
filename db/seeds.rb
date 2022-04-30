# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create(name:"Admin",
           email:'hadi.ibrahima@gmail.com',
        password:'firstadmin123456',
           admin:true)
  @tasks=Task.where(user_id:nil)
  @tasks.each do |e|
  e.update(user_id:1)
end


status = ['pending', 'started', 'completed']
priority = ['low', 'medium', 'high']

15.times do |i|
    User.create(
        name: "marou#{i}name",
        email: "marouemail#{i}@gmail.com",
        password: "password"
    )
end

# 21.times do |n|
#     Label.create(name: "tag_#{n}_#{n+12}")
# end


100.times do |i|
    Task.create(
      title: "task#{i + 1}",
      content: "task detail#{i + 1}",
      deadline: DateTime.now + 10,
      status: status[rand(3)],
      priority: priority[rand(3)],
      user_id: rand(1..21)
    )
end

20.times do |n|
    Label.create(
        name: "tag_#{n}_#{n-12}"
    )
end

# 100.times do |i|
#     Labeling.create!(
#       task_id: rand(1..100),
#       label_id: rand(1..5)
#     )
# end

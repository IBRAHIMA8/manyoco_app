# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name:"Admin",
           email:'hadi.ibrahima77gmail.com',
        password:'firstadmin123456',
           admin:true)
  @tasks=Task.where(user_id:nil)
  @tasks.each do |e|
  e.update(user_id:1)
end

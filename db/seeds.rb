# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@user = User.new(:email => 'test1@example.com', :password => 'password', :password_confirmation => 'password')
@user.skip_confirmation!
@user.save
@user = User.new(:email => 'test2@example.com', :password => 'password', :password_confirmation => 'password')
@user.skip_confirmation!
@user.save
@user = User.new(:email => 'test3@example.com', :password => 'password', :password_confirmation => 'password')
@user.skip_confirmation!
@user.save

@a=Admin.new(:email => "def@mac.ro", :password => "pass", :password_confirmation => "pass")
@a.save

Plan.create({name:'Tutorial', price: 4.99, interval: 'month', stripe_id: 'Tutorial' })
Plan.create({name:'Server', price: 9.99, interval: 'month', stripe_id: 'Server'  })
Plan.create({name:'Tutorial-yearly', price: 49.99, interval: 'year', stripe_id: 'Tutorial-yearly' })
Plan.create({name:'server-yearly', price: 99.99, interval: 'year', stripe_id: 'server-yearly'  })

Book.create({title:'Learning PERL', author: "PERL Expert", image: 'http://perl.jpg', price: 7.99, visible: true})
Book.create({title:'Learning python', author: "Python Expert", image: 'http://python.jpg', price: 8.49, visible: true})
Book.create({title:'Learning Java', author: "Java Expert", image: 'http://java.jpg', price: 8.99, visible: true})
Book.create({title:'Learning Ruby', author: "Ruby Expert", image: 'http://ruby.jpg', price: 9.49, visible: true})
Book.create({title:'Learning C++', author: "C Expert", image: 'http://c.jpg', price: 9.99, visible: true})
Book.create({title:'Learning Elixir', author: "Elixir Expert", image: 'http://elixir.jpg', price: 10.99, visible: true})
Book.create({title:'Learning R', author: "Ana R Expert", image: 'http://anaR.jpg', price: 12.39, visible: true})
Book.create({title:'Learning to swim', author: "Michael Phelps", image: 'http://swim.jpg', price: 13.47, visible: true})
Book.create({title:'Learning to cook', author: "Tim Cook", image: 'http://cooking.jpg', price: 12.12, visible: true})

BuyBook.create({user_id: 1, book_id: 1})
BuyBook.create({user_id: 2, book_id: 4})

BuyPlan.create({user_id: 1, plan_id: 1, status: 1})


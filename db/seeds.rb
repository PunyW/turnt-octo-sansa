# This file should contain all the record creation needed to seed the database with its default values.n.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.create username:'Admin', password: 'Test1', password_confirmation: 'Test1', admin: true
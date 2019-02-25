# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'Cleaning Database...'
User.destroy_all
Specialty.destroy_all
Doctor.destroy_all
DoctorSpecialty.destroy_all

puts 'Creating Users...'
user1 = User.create!(email: 'a@a.com', password: 'senhasenha')
user2 = User.create!(email: 'b@b.com', password: 'senhasenha')
user3 = User.create!(email: 'c@c.com', password: 'senhasenha')

puts 'Creating Specialties...'
sp1 = Specialty.create!(name: 'Dermatologist')
sp2 = Specialty.create!(name: 'pediatrician')

puts 'Creating Doctors...'
doc1 = Doctor.create!(user: user1)
doc2 = Doctor.create!(user: user2)

puts 'Creating DoctorSpecialties'
ds1 = DoctorSpecialty.create!(doctor: doc1, specialty: sp1)
ds1 = DoctorSpecialty.create!(doctor: doc1, specialty: sp2)
ds2 = DoctorSpecialty.create!(doctor: doc2, specialty: sp1)

puts 'Finished!'

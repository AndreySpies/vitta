# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts ''
puts 'Seeding'
puts 'Cleaning Database...'
User.destroy_all
Specialty.destroy_all
Doctor.destroy_all
DoctorSpecialty.destroy_all

puts 'Creating Users...'
user1 = User.create!(email: 'a@a.com', password: 'senhasenha', first_name: 'Gregory', last_name: 'House', rg: 123, phone: '987654321', birth_date: '15/01/1990')
user2 = User.create!(email: 'b@b.com', password: 'senhasenha', first_name: 'John', last_name: 'Wick', rg: 1234, phone: '123456789', birth_date: '20/07/1985')
user3 = User.create!(email: 'c@c.com', password: 'senhasenha', first_name: 'Rocky', last_name: 'Balboa', rg: 321, phone: '123498765', birth_date: '30/08/1977')
user4 = User.create!(email: 'd@d.com', password: 'senhasenha', first_name: 'John', last_name: 'Rambo', rg: 4321, phone: '987612345', birth_date: '04/03/1960')

puts 'Creating Specialties...'
sp1 = Specialty.create!(name: 'Dermatologist')
sp2 = Specialty.create!(name: 'pediatrician')

puts 'Creating Doctors...'
doc1 = Doctor.new(user: user1, description: 'Mai naime is gregório', price_cents: 15000, crm: '12345', address: 'Rua Piratini 14 Sapiranga RS')
doc1.save
doc2 = Doctor.new(user: user2, price_cents: 20000, description: "I'm the big john!", crm: '54321', address: 'Rua Presidente Kennedy Sapiranga RS')
doc2.save

puts 'Creating DoctorSpecialties'
ds1 = DoctorSpecialty.create!(doctor: doc1, specialty: sp1)
ds1 = DoctorSpecialty.create!(doctor: doc1, specialty: sp2)
ds2 = DoctorSpecialty.create!(doctor: doc2, specialty: sp1)

puts 'Creating Consulations'
con1 = Consultation.create!(patient: user3, doctor: doc1, start_time: "2019-02-26 14:00:00 -0300", end_time: "2019-02-26 14:30:00 -0300")
con2 = Consultation.create!(patient: user4, doctor: doc1, start_time: "2019-02-26 19:30:00 -0300", end_time: "2019-02-26 20:00:00 -0300")
con3 = Consultation.create!(patient: user4, doctor: doc2, start_time: "2019-02-26 20:00:00 -0300", end_time: "2019-02-26 20:30:00 -0300")

puts 'Seeding completed!'
system("clear")

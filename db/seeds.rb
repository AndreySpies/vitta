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
Schedule.destroy_all
DoctorSchedule.destroy_all

puts 'Creating Users...'
user1 = User.create!(email: 'a@a.com', password: 'senhasenha', first_name: 'Gregory', last_name: 'House')
user2 = User.create!(email: 'b@b.com', password: 'senhasenha', first_name: 'John', last_name: 'Wick')
user3 = User.create!(email: 'c@c.com', password: 'senhasenha', first_name: 'Rocky', last_name: 'Balboa')
user4 = User.create!(email: 'd@d.com', password: 'senhasenha', first_name: 'John', last_name: 'Rambo')

puts 'Creating Specialties...'
sp1 = Specialty.create!(name: 'Dermatologist')
sp2 = Specialty.create!(name: 'pediatrician')

puts 'Creating Doctors...'
doc1 = Doctor.create!(user: user1, price_cents: 15000, crm: '12345')
doc2 = Doctor.create!(user: user2, price_cents: 20000, crm: '54321')

puts 'Creating DoctorSpecialties'
ds1 = DoctorSpecialty.create!(doctor: doc1, specialty: sp1)
ds1 = DoctorSpecialty.create!(doctor: doc1, specialty: sp2)
ds2 = DoctorSpecialty.create!(doctor: doc2, specialty: sp1)

puts 'Creating Consulations'
con1 = Consultation.create!(patient: user3, doctor: doc1)
con2 = Consultation.create!(patient: user4, doctor: doc1)
con3 = Consultation.create!(patient: user4, doctor: doc2)

puts 'Creating Schedules'
sc1 = Schedule.create!(day: 15, hour: '15')
sc2 = Schedule.create!(day: 15, hour: '16')

puts 'Creating DoctorSchedules'
DoctorSchedule.create!(doctor: doc1, schedule: sc1)
DoctorSchedule.create!(doctor: doc1, schedule: sc2)

puts 'Finished!'

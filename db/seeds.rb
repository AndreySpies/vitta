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
user1 = User.create!(email: 'a@a.com', password: 'senhasenha', first_name: 'Gregory', last_name: 'House', rg: 123, phone: '51985654321', birth_date: '15/01/1990')
user2 = User.create!(email: 'b@b.com', password: 'senhasenha', first_name: 'John', last_name: 'Wick', rg: 1234, phone: '51987654321', birth_date: '20/07/1985')
user3 = User.create!(email: 'c@c.com', password: 'senhasenha', first_name: 'Rocky', last_name: 'Balboa', rg: 321, phone: '51987656321', birth_date: '30/08/1977')
user4 = User.create!(email: 'd@d.com', password: 'senhasenha', first_name: 'John', last_name: 'Rambo', rg: 4321, phone: '51987654331', birth_date: '04/03/1960')
user5 = User.create!(email: 'user@gmail.com', password: 'senhasenha', first_name: 'User', last_name: 'user', rg: 98765, phone: '51987654371', birth_date: '15/03/1990')
doctor = User.create!(email: 'doctor@gmail.com', password: 'senhasenha', first_name: 'Stallone', last_name: 'Cobra', rg: 4578, phone: '51987654521', birth_date: '03/05/1990')

puts 'Creating Specialties...'
sp1 = Specialty.create!(name: 'Dermatologia')
sp2 = Specialty.create!(name: 'Pediatria')
sp3 = Specialty.create!(name: 'Ginecologia')
sp4 = Specialty.create!(name: 'Oftalmologia')
sp5 = Specialty.create!(name: 'Psiquiatria')
sp6 = Specialty.create!(name: 'Ortopedia')
sp7 = Specialty.create!(name: 'Otorrinolaringologia')
sp8 = Specialty.create!(name: 'Neurologia')

puts 'Creating Doctors...'
doc1 = Doctor.new(user: user1, description: 'Mai naime is gregório', price_cents: 15000, crm: '12345', address: 'Rua Piratini 14 Sapiranga RS')
doc1.save
doc2 = Doctor.new(user: user2, price_cents: 20000, description: "I'm the big john!", crm: '54321', address: 'Rua Presidente Kennedy Sapiranga RS')
doc2.save
doctor = Doctor.new(user: doctor, price_cents: 100000, description: "I'm the best!", crm: '25431', address: 'Av. Rebouças 3970, Pinheiros, São Paulo - SP')
doctor.save

puts 'Creating DoctorSpecialties'
ds1 = DoctorSpecialty.create!(doctor: doc1, specialty: sp1)
ds2 = DoctorSpecialty.create!(doctor: doc1, specialty: sp2)
ds3 = DoctorSpecialty.create!(doctor: doc2, specialty: sp1)
ds4 = DoctorSpecialty.create!(doctor: doctor, specialty: sp1)

puts 'Creating Consulations'
con1 = Consultation.create!(patient: user2, doctor: doc1, start_time: "2019-02-26 14:00:00 -0300", end_time: "2019-02-26 14:30:00 -0300")
con2 = Consultation.create!(patient: user4, doctor: doc1, start_time: "2019-02-26 19:30:00 -0300", end_time: "2019-02-26 20:00:00 -0300")
con3 = Consultation.create!(patient: user4, doctor: doc2, start_time: "2019-02-26 20:00:00 -0300", end_time: "2019-02-26 20:30:00 -0300")
con4 = Consultation.create!(patient: user1, doctor: doctor, start_time: "2019-03-26 15:00:00 -0300", end_time: "2019-02-26 15:30:00 -0300")
con5 = Consultation.create!(patient: user2, doctor: doctor, start_time: "2019-03-26 16:00:00 -0300", end_time: "2019-02-26 16:30:00 -0300")

puts 'Creating PatientRecords'
pr1 = PatientRecord.create!(patient: user1, doctor: doctor, entry: 'Patient record - id = 1 | Doctor: doctor')
pr2 = PatientRecord.create!(patient: user2, doctor: doctor, entry: 'Patient record - id = 2 | Doctor: doctor')
pr3 = PatientRecord.create!(patient: user2, doctor: doc1, entry: 'Patient record - id = 3 | Doctor: Gregory House')
puts 'Seeding completed!'
system("clear")

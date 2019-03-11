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
Admin.destroy_all
Specialty.destroy_all
Doctor.destroy_all
DoctorSpecialty.destroy_all
PatientRecord.destroy_all
Bank.destroy_all

puts 'Creating Bank codes'
bank1 = Bank.create!(name: 'BANCO DO BRASIL S.A.', code: 001)
bank2 = Bank.create!(name: 'Banrisul', code: 002)

puts 'Creating Users...'
user1 = User.create!(email: 'a@a.com', password: 'senhasenha', first_name: 'Gregory', last_name: 'House', cpf: '23015342512', gender: 'masculino', phone: '51985654321', birth_date: '15/01/1990')
user2 = User.create!(email: 'b@b.com', password: 'senhasenha', first_name: 'John', last_name: 'Wick', cpf: '23015342523', gender: 'masculino', phone: '51987654321', birth_date: '20/07/1985')
user3 = User.create!(email: 'c@c.com', password: 'senhasenha', first_name: 'Rocky', last_name: 'Balboa', cpf: '23015342534', gender: 'masculino', phone: '51987656321', birth_date: '30/08/1977')
user4 = User.create!(email: 'd@d.com', password: 'senhasenha', first_name: 'John', last_name: 'Rambo', cpf: '23015342545', gender: 'masculino', phone: '51987654331', birth_date: '04/03/1960')
user5 = User.create!(email: 'user@gmail.com', password: 'senhasenha', first_name: 'User', last_name: 'user', cpf: '23015342556', gender: 'masculino', phone: '51987654371', birth_date: '15/03/1990')
doctor = User.create!(email: 'doctor@gmail.com', password: 'senhasenha', first_name: 'Stallone', last_name: 'Cobra', cpf: '23015342567', gender: 'masculino', phone: '51987654521', birth_date: '03/05/1990')
admin = User.create!(email: 'admin@gmail.com', password: 'adminadmin', first_name: 'Admin', last_name: 'Administrator', cpf: '04499225025', gender: 'masculino', phone: '51985526134', birth_date: '18/06/1999')

puts 'Creating Admin user'
Admin.create!(user: admin, bank_code: 001, agency: '653', agency_vd: 'x', account: '79723', account_vd: '5')

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
doc1 = Doctor.new(user: user1,
                  description: 'Dr.Carlos Fernando Nemes possui títulos de especialista pela AMB e Sociedades Brasileiras de Cardiologia - SBC, Terapia Intensiva (AMIB/SOPATI) e Geriatria (SBGG). Pós graduado em Geriatria pela UNIFESP. Sua abordagem é baseada fundamentalmente na anamnese: o diálogo reflexivo sobre a vida do paciente, seus hábitos, seu histórico familiar e suas perspectivas e motivações.',
                  price_cents: 15000,
                  crm: '12345',
                  since: 20,
                  address: 'Rua Piratini 14 Sapiranga RS',
                  competence: 'Graduação em medicina: UNISA (1976), Titulo de Especialista em Cardiologia, Terapia Intensiva e Geriatria Residência Médica em Clínica Médica: Hospital do Servidor Público Estadual - HSPE (1976-1978), Residência Médica em Cardiologia: Hospital do Servidor Público Estadual - HSPE (1978-1980), Pos-graduação em Geriatria: UNIFESP',
                  bank_code: 001,
                  agency: '653',
                  agency_vd: 'x',
                  account: '25654',
                  account_vd: '2')
doc1.save
doc2 = Doctor.new(user: user2,
                  price_cents: 20000,
                  description: "Dr.Carlos Fernando Nemes possui títulos de especialista pela AMB e Sociedades Brasileiras de Cardiologia - SBC, Terapia Intensiva (AMIB/SOPATI) e Geriatria (SBGG). Pós graduado em Geriatria pela UNIFESP. Sua abordagem é baseada fundamentalmente na anamnese: o diálogo reflexivo sobre a vida do paciente, seus hábitos, seu histórico familiar e suas perspectivas e motivações.",
                  crm: '54321',
                  since: 20,
                  address: 'Rua Presidente Kennedy Sapiranga RS',
                  competence: 'Graduação em medicina: UNISA (1976), Titulo de Especialista em Cardiologia, Terapia Intensiva e Geriatria Residência Médica em Clínica Médica: Hospital do Servidor Público Estadual - HSPE (1976-1978), Residência Médica em Cardiologia: Hospital do Servidor Público Estadual - HSPE (1978-1980), Pos-graduação em Geriatria: UNIFESP',
                  bank_code: 001,
                  agency: '653',
                  agency_vd: 'x',
                  account: '34523',
                  account_vd: '3')
doc2.save
doctor = Doctor.new(user: doctor,
                    price_cents: 10000,
                    description: "Dr.Carlos Fernando Nemes possui títulos de especialista pela AMB e Sociedades Brasileiras de Cardiologia - SBC, Terapia Intensiva (AMIB/SOPATI) e Geriatria (SBGG). Pós graduado em Geriatria pela UNIFESP. Sua abordagem é baseada fundamentalmente na anamnese: o diálogo reflexivo sobre a vida do paciente, seus hábitos, seu histórico familiar e suas perspectivas e motivações.",
                    crm: '25431',
                    since: 20,
                    address: 'Av. Rebouças 3970, Pinheiros, São Paulo - SP',
                    competence: 'Graduação em medicina: UNISA (1976), Titulo de Especialista em Cardiologia, Terapia Intensiva e Geriatria Residência Médica em Clínica Médica: Hospital do Servidor Público Estadual - HSPE (1976-1978), Residência Médica em Cardiologia: Hospital do Servidor Público Estadual - HSPE (1978-1980), Pos-graduação em Geriatria: UNIFESP',
                  bank_code: 001,
                  agency: '653',
                  agency_vd: 'x',
                  account: '74326',
                  account_vd: '4')
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

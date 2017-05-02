require 'sinatra'
require 'sinatra/reloader'
require './lib/doctors_office'
require 'pry'

also_reload('lib/**/*.rb')

get('/') do
  erb(:index)
end

post('/register-patient') do
  patient_name = params.fetch('patient-name')
  patient_dob = params.fetch('patient-dob')
  patient_phone = params.fetch('patient-phone')
  Doctors_office::Patient.add(patient_name, patient_dob, patient_phone)
  erb(:index)
end

post('/register-doctor') do
  doctor_name = params.fetch('doctor-name')
  doctor_type = params.fetch('doctor-type')
  Doctors_office::Doctor.add(doctor_name, doctor_type)
  erb(:index)
  Doctors_office::Doctor.all.to_a
end

get('/doctors/:id') do
  id = params.fetch('id')
  @doctor = Doctors_office::Doctor.find_by('id', id)
  erb(:doctor)
end

get('/patients/:id') do
  id = params.fetch('id')
  @patient = Doctors_office::Patient.find_by('id', id)
  erb(:patient)
end

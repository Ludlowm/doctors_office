require 'sinatra'
require 'sinatra/reloader'
require './lib/doctors_office'
require 'pry'
require 'time'
enable :sessions
also_reload('lib/**/*.rb')

get('/') do
  erb(:index)
end

post('/register-patient') do
  patient_name = params.fetch('patient-name')
  patient_dob = Time.parse(params.fetch('patient-dob'))
  patient_phone = params.fetch('patient-phone')
  Doctors_office::Patient.add(patient_name, patient_phone, patient_dob)
  erb(:index)
end

post('/register-doctor') do
  doctor_name = params.fetch('doctor-name')
  doctor_type = params.fetch('doctor-type')
  Doctors_office::Doctor.add(doctor_name, doctor_type)
  erb(:index)
end

get('/doctors/:id') do
  id = params.fetch('id')
  @doctor = Doctors_office::Doctor.find_by('id', id)
  erb(:doctor)
end

get('/patients/:id') do
  @id = params.fetch('id')
  session[:id] = @id
  @patient = Doctors_office::Patient.find_by('id', @id)
  erb(:patient)
end

post('/add-doctor') do
  patient_id = session[:id]
  @patient = Doctors_office::Patient.find_by('id', patient_id)
  doctor_id = params.fetch('doctors')
  Doctors_office::Patient.add_doctor(patient_id, doctor_id)
  erb(:patient)
end

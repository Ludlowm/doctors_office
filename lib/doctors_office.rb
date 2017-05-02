require 'pg'
require 'pry'
require 'time'

module Doctors_office

  DB = PG.connect({:dbname => 'doctors_office'})
  class Doctor

    def self.clear_db
      DB.exec("DELETE FROM doctors *;")
    end

    def self.add(name, type)
      DB.exec("INSERT INTO doctors VALUES (uuid_generate_v4(), '#{name}', '#{type}') RETURNING id;")
    end

    def self.delete(id)
      DB.exec("DELETE FROM doctors WHERE id ='#{id}';")
    end

    def self.find_by(field, value)
      DB.exec("SELECT * FROM doctors WHERE #{field} = '#{value}' ORDER BY name DESC;").to_a
    end

    def self.all
      DB.exec("SELECT * FROM doctors;")
    end

    def self.patients(doctor_name)
      doctor_id = Doctors_office::Doctor.find_by("name", doctor_name)[0]["id"]
      DB.exec("SELECT name FROM patients WHERE doctor_id = '#{doctor_id}'").to_a
    end

  end

  class Patient
    def self.add(name, phone, birthday)
      DB.exec("INSERT INTO patients VALUES (uuid_generate_v4(), '#{name}', #{phone}, '#{birthday}') RETURNING id;")
    end

    def self.delete(id)
      DB.exec("DELETE FROM patients WHERE id ='#{id}';")
    end

    def self.clear_db
      DB.exec("DELETE FROM patients *;")
    end

    def self.all
      DB.exec("SELECT * FROM patients;")
    end

    def self.add_doctor(patient_id, doctor_id)
      DB.exec("UPDATE patients SET doctor_id = '#{doctor_id}' WHERE id = '#{patient_id}'")
    end

    def self.find_by(field, value)
      DB.exec("SELECT * FROM patients WHERE #{field} = '#{value}' ORDER BY name DESC;").to_a
    end

  end

end

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
  end

  class Patient
    def self.add(name, birthday, phone)
      DB.exec("INSERT INTO patients VALUES (uuid_generate_v4(), '#{name}', '#{birthday}', #{phone}) RETURNING id;")
    end

    def self.delete(id)
      DB.exec("DELETE FROM patients WHERE id ='#{id}';")
    end

    def self.clear_db
      DB.exec("DELETE FROM patients *;")
    end

    def self.add_doctor(patient_name, doctor_name)
      doctor_id = Doctors_office::Doctor.find_by("name", doctor_name)[0]["id"]
      DB.exec("UPDATE patients SET doctor_id = '#{doctor_id}' WHERE name = '#{patient_name}'")
    end

    def self.find_by(field, value)
      DB.exec("SELECT * FROM patients WHERE #{field} = '#{value}' ORDER BY name DESC;").to_a
    end

  end

end

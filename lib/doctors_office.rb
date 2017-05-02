require 'pg'
require 'pry'
require 'time'

module Doctors_office

  DB = PG.connect({:dbname => 'doctors_office'})
  class Doctor

    def self.add(name, type)
      DB.exec("INSERT INTO doctors VALUES (uuid_generate_v4(), '#{name}', '#{type}') RETURNING id;")
    end

    def self.delete(id)
      DB.exec("DELETE FROM doctors WHERE id ='#{id}';")
    end


  end

  class Patient
    def self.add(name, age, phone)
      DB.exec("INSERT INTO patients VALUES (uuid_generate_v4(), '#{name}', '#{age}', #{phone}) RETURNING id;")
    end

    def self.delete(id)
      DB.exec("DELETE FROM patients WHERE id ='#{id}';")
    end

  end

end

require 'pg'
require 'pry'
require 'time'

module Doctors_office
  DB = PG.connect({:dbname => 'doctors_office'})
  class Doctor
    def self.add(name, type)
      DB.exec("INSERT INTO doctors VALUES (uuid_generate_v4(), '#{name}', '#{type}') RETURNING id;")
    end

  end

end

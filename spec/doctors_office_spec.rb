require "doctors_office"
require "rspec"
require "pry"
require "spec_helper"



describe Doctors_office do

  describe Doctors_office::Doctor do

    describe 'Doctors_office::Doctor.add' do
      it 'Adds a new doctor to the database' do
        expect(Doctors_office::Doctor.add('John Doe', 'Brain Surgeon')[0]["id"]).to match(UUID_MATCHER)
      end
    end

  end

  describe Doctors_office::Patient do

    describe 'Doctors_office::Patient.add' do
      it 'Adds a new patient to the database' do
        expect(Doctors_office::Patient.add('Jane Doe', 6, 5039904423)[0]["id"]).to match(UUID_MATCHER)
      end
    end

  end

end

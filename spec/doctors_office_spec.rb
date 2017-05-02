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

    describe 'Doctors_office::Doctor.delete' do
      it 'deletes a doctor from the database' do
        id = Doctors_office::Doctor.add('John Doe', 'Brain Surgeon').getvalue(0, 0)
        result = Doctors_office::Doctor.delete(id)
        expect(result.result_status).to eq(PG::PGRES_COMMAND_OK)
      end
    end
  end

  describe Doctors_office::Patient do

    describe 'Doctors_office::Patient.add' do
      it 'Adds a new patient to the database' do
        expect(Doctors_office::Patient.add('Jane Doe', 6, 5039904423)[0]["id"]).to match(UUID_MATCHER)
      end
    end

    describe 'Doctors_office::Patient.delete' do
      it 'deletes a patient from the database' do
        id = Doctors_office::Patient.add('Jane Doe', 23, 5039997788).getvalue(0, 0)
        result = Doctors_office::Patient.delete(id)
        expect(result.result_status).to eq(PG::PGRES_COMMAND_OK)
      end
    end

  end

end

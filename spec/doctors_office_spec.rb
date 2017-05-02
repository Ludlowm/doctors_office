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

    describe 'Doctors_office::Doctor.find_by' do
      it 'finds a doctor matching the given parameters' do
        Doctors_office::Doctor.clear_db
        id = Doctors_office::Doctor.add('John Doe', 'Brain Surgeon').getvalue(0, 0)
        Doctors_office::Doctor.add('John Toad', 'Brain Surgeon').getvalue(0, 0)
        Doctors_office::Doctor.add('John Dog', 'Brain Surgeon').getvalue(0, 0)
        expect(result = Doctors_office::Doctor.find_by('id', id)).to be_a(Array)
        expect(result = Doctors_office::Doctor.find_by('name', 'name')).to be_a(Array)
        expect(result = Doctors_office::Doctor.find_by('type', 'type')).to be_a(Array)
      end
    end

    describe 'Doctors_office::Doctor.delete' do
      it 'deletes a doctor from the database' do
        id = Doctors_office::Doctor.add('John Doe', 'Brain Surgeon').getvalue(0, 0)
        result = Doctors_office::Doctor.delete(id)
        expect(result.result_status).to eq(PG::PGRES_COMMAND_OK)
      end
    end

    describe 'Doctors_office::Doctor.patients' do
      it 'returns patient records for a specified doctor' do
        Doctors_office::Doctor.add('John Doe', 'Brain Surgeon').getvalue(0, 0)
        Doctors_office::Patient.add('Jane Doe', Time.now, 5033338877).getvalue(0, 0)
        Doctors_office::Patient.add('Jullie Doe', Time.now, 5033338872).getvalue(0, 0)
        Doctors_office::Patient.add('Paul Doe', Time.now, 5033338822).getvalue(0, 0)
        Doctors_office::Patient.add_doctor("Jane Doe", "John Doe")
        Doctors_office::Patient.add_doctor("Jullie Doe", "John Doe")
        Doctors_office::Patient.add_doctor("Paul Doe", "John Doe")
        expect(Doctors_office::Doctor.patients("John Doe")).to be_a(Array)
      end
    end

  end

  describe Doctors_office::Patient do

    describe 'Doctors_office::Patient.add' do
      it 'Adds a new patient to the database' do
        expect(Doctors_office::Patient.add('Jane Doe', Time.now, 5039904423)[0]["id"]).to match(UUID_MATCHER)
      end
    end

    describe 'Doctors_office::Patient.delete' do
      it 'deletes a patient from the database' do
        id = Doctors_office::Patient.add('Jane Doe', Time.now, 5039997788).getvalue(0, 0)
        result = Doctors_office::Patient.delete(id)
        expect(result.result_status).to eq(PG::PGRES_COMMAND_OK)
      end
    end

    describe 'Doctors_office::Patient.find_by' do
      it 'finds a patient matching the given parameters' do
        Doctors_office::Patient.clear_db
        id = Doctors_office::Patient.add('Jane Doe', Time.now, 5033338877).getvalue(0, 0)
        expect(result = Doctors_office::Patient.find_by('id', id)).to be_a(Array)
        expect(result = Doctors_office::Patient.find_by('name', 'name')).to be_a(Array)
      end
    end

    describe 'Doctors_office::Patient.add_doctor' do
      it 'adds a doctor id to as a foreign key' do
        Doctors_office::Patient.clear_db
        Doctors_office::Patient.add('Jane Doe', Time.now, 5033338877).getvalue(0, 0)
        Doctors_office::Doctor.add('John Doe', 'Brain Surgeon').getvalue(0, 0)
        doctor_id = Doctors_office::Doctor.find_by("name", "John Doe")[0]["id"]
        Doctors_office::Patient.add_doctor("Jane Doe", "John Doe")
        expect(Doctors_office::Patient.find_by("name", "Jane Doe")[0]["doctor_id"]).to eq(doctor_id)
      end
    end

  end

end

require 'rails_helper'

RSpec.describe ResourceHandler do
  let(:handler) { ResourceHandler.new }
  let(:access_confirmation_request) { Stamp::AccessConfirmationRequest }

  describe '.access' do
    it 'already have access to medical records' do; end

    it 'does not have access to medical records' do
      patient = FactoryGirl.create(:user, create_medical_records: true)
      doctor = FactoryGirl.create(:user)

      access_request = Stamp::AccessRequest.new(
        accessing_user_id: doctor.id,
        resource_owner_id: patient.id,
        medical_records: patient.medical_records.pluck(:id))

      expect(Event).to receive(:notify).with(patient.id, doctor.id, patient.medical_records.pluck(:id))

      response = handler.access(access_request, '')
      expected_resource_mapping = ResourceMapping.where(
        accessing_user_id: doctor.id,
        resource_owner_id: patient.id,
        status: 1)

      expect(response).to be_an_instance_of(Stamp::AccessResponse)
      expect(expected_resource_mapping.count).to eq(1)
      expect(expected_resource_mapping.first.medical_record_ids).to eq(patient.medical_records.pluck(:id))
    end

    it 'raises exception when request does not have valid data' do; end
  end

  describe '.access_confirmation' do
    it 'grants the access to records' do; end
    it 'does not grant access to records' do; end
    it 'raises exception when request does not have valid data' do; end
  end
end

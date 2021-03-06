require_relative '../../lib/resource_services_pb'

class ResourceHandler < Stamp::Api::Service
  include ResourceHelper

  # assumptions:
  # 1. considering user is either giving access to all or none
  # 2.
  def access(request, _unused_call)
    user_id = request.accessing_user_id
    owner_id = request.resource_owner_id
    mrids = request.medical_records.to_a

    record_ids = ResourceMapping.where(
      accessing_user_id: user_id,
      resource_owner_id: owner_id,
      status: to_enum(:GRANTED)).pluck(:medical_record_ids)

    if record_ids.include?(mrids)
      access_response(:GRANTED, I18n.t('resources.access_already_granted'))
    else
      Event.notify(owner_id, user_id, mrids)
      create_mapping(user_id, owner_id, mrids, :AWAITING_RESPONSE)
      access_response(:AWAITING_RESPONSE, I18n.t('resources.request_sent_to_user'))
    end
  rescue => ex
    # access_response()
    puts "#{ex.message} - #{ex.backtrace}"
  end

  def access_confirmation(request, _unused_call)
    user_id = request.accessing_user_id
    owner_id = request.resource_owner_id
    record_ids = request.medical_records
    status = request.status

    if status.eql?(:GRANTED)
      Event.notify(request.accessing_user_id,
        'access granted')
    elsif status.eql?(:ACCESS_DENIED)
      Event.notify(request.accessing_user_id,
        'access denied.')
    end

    update_mapping(user_id, owner_id, record_ids, status)
    access_confirmation_response(200)
  rescue => ex
    puts "#{ex.message} #{ex.backtrace}"
    access_confirmation_response(500, ex.message)
  end

  private

  def update_mapping(user_id, owner_id, record_ids, status)
    ResourceMapping.where(
      accessing_user_id: user_id,
      resource_owner_id: owner_id,
      medical_record_ids: record_ids.to_a,
      status: to_enum(:AWAITING_RESPONSE))
    .first
    .update_attributes(status: to_enum(status))
  end

  def create_mapping(user_id, owner_id, records_ids, status)
    ResourceMapping.create(
      accessing_user_id: user_id,
      resource_owner_id: owner_id,
      medical_record_ids: records_ids,
      status: to_enum(status)
    )
  end
end

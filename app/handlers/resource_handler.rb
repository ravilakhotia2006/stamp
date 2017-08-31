require_relative '../../lib/resource_services_pb'

class ResourceHandler < Stamp::Api::Service
  include ResourceHelper

  def access(request, _unused_call)
    records = ResourceMapping.where(
      accessing_user_id: request.accessing_user_id,
      resource_owner_id:, request.resource_owner_id,
      status: to_enum(:GRANTED)).pluck(:medical_record_ids)

    if records.include?(request.medical_record_ids)
      access_response(:GRANTED, I18n.t('resources.access_already_granted'))
    else
      Event.notify(request.resource_owner_id,
        request.accessing_user_id,
        request.medical_record_ids)
      return access_response(:AWAITING_RESPONSE, I18n.t('resources.request_sent_to_user'))
    end
  end

  def access_confirmation(request, _unused_call)
  end
end

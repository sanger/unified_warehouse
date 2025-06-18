# A payload takes a message body, provides basic validation and
# generates the corresponding record on record
class Payload
  InvalidMessage = Class.new(StandardError)

  module ClassMethods
    def from_json(json)
      begin
        parameters = JSON.parse(json)
      rescue JSON::ParserError => e
        raise ResourceTools::InvalidMessage, "Message is invalid json: #{e.message}"
      end
      lims = parameters.delete('lims') || raise(InvalidMessage, 'Message missing lims parameter')
      raise(ResourceTools::InvalidMessage, 'Message contains multiple potential models') if parameters.length > 1
      raise(ResourceTools::InvalidMessage, 'Message is missing main payload') if parameters.empty?

      new(lims, *parameters.flatten)
    end
  end

  extend ClassMethods

  attr_reader :lims, :model_class, :parameters

  def initialize(lims, model_class, parameters)
    @lims = lims
    @model_class = model_class_for(model_class)
    @parameters = parameters.stringify_keys!
  end

  def record
    model_class.create_or_update_from_json(parameters, lims)
  end

  private

  def model_class_for(model_class_name)
    candidate_class = model_class_name.classify.safe_constantize
    unless candidate_class.respond_to?(:create_or_update_from_json)
      raise(InvalidMessage, "Unrecognized model: #{model_class_name}")
    end

    candidate_class
  end
end

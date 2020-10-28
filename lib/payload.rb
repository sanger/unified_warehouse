# A payload takes a message body, provides basic validation and
# generates the corresponding record on record
class Payload
  InvalidMessage = Class.new(StandardError)

  module ClassMethods
    def from_json(json)
      begin
        parameters = JSON.parse(json)
      rescue JSON::ParserError => exception
        raise InvalidMessage, "Message is invalid json: #{exception.message}"
      end
      lims = parameters.delete('lims') || raise(InvalidMessage, 'Message missing lims parameter')
      raise(InvalidMessage, 'Message contains multiple potential models') if parameters.length > 1
      raise(InvalidMessage, 'Message is missing main payload') if parameters.length.zero?
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
    raise(InvalidMessage, "Unrecognized model: #{model_class_name}") unless candidate_class && (candidate_class < ApplicationRecord)
    candidate_class
  end
end

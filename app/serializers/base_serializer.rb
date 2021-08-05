class BaseSerializer
  include JSONAPI::Serializer

  def self.model_class
    name.chomp('Serializer').constantize
  end

  def self.association_keys
    model_class.reflect_on_all_associations.map {|assn| assn.foreign_key.to_s }
  end

  def self.add_model_attributes(except: [], filter_primary_key: true, filter_relationships: true)
    model_class.attribute_names.each do |att|
      next if att == model_class.primary_key && filter_primary_key
      next if except.include?(att)
      next if association_keys.include?(att) && filter_relationships
      attributes att
    end
  end

end

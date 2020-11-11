class IgnoreableResource
  def self.create_or_update_from_json(*_args)
    new
  end

  def id
    'ignored'
  end

  def inserted_record?
    false
  end
end

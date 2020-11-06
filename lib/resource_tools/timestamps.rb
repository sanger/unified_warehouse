module ResourceTools::Timestamps
  extend ActiveSupport::Concern

  included do
    # Ensure that the time stamps are correct whenever a record is updated
    before_save { |record| record.recorded_at = record.checked_time_now }

    delegate :correct_current_time, to: 'self.class'
    delegate :checked_time_now, to: 'self.class'
  end

  module ClassMethods
    def correct_current_time
      default_timezone == :utc ? Time.now.utc : Time.now
    end

    def checked_time_now
      correct_current_time
    end
  end
end

class WorkerDeath < ActionMailer::Base

    default :from => UnifiedWarehouse::Application.config.worker_death_from,
            :to => UnifiedWarehouse::Application.config.worker_death_to,
            :subject => "[#{Rails.env.upcase}] Unified Warehouse worker death"

  def failure(exception)
    @exception = exception
    mail( )
  end

end

class SendMonthlyCommentRateReportJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
  end
end
# These are methods inherited from ActiveJob::Base and will internally call perform. 
# SendMonthlyCommentRateReportJob.perform_now
# SendMonthlyCommentRateReportJob.perform_later

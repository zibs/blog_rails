namespace :send_report do
  desc "Send reports in system"
  task :send_all => :environment do
    # SendMonthlyCommentRateReportJob.perform_later
  end
end
# we can run this rake task to to queue this as a background job to be handled by DelayedJob::ActiveJob

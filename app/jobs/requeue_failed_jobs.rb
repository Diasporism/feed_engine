class RequeueFailedJobs
  @queue = :failed_queue

  def self.perform
    puts 'Requeueing failed jobs'
    (Resque::Failure.count-1).downto(0).each { |i| Resque::Failure.requeue(i) }
    Resque::Failure.clear
  end
end
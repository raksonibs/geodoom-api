class HardWorker
  include Sidekiq::Worker
  def perform(name, count)
    puts "yo"
  end
end
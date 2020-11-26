class ApplicationService
  def self.call(*args, &block)
    self.new(*args, &block).call
  end
end
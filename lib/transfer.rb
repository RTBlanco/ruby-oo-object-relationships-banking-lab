require "pry"
class Transfer
  attr_reader :amount 
  attr_accessor :status, :sender, :receiver

  def initialize(sender, receiver, amount)
    @sender = sender 
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    @receiver.valid? && @sender.valid?
  end

  def execute_transaction
    # binding.pry
    if self.valid? && sender.balance > @amount && self.status == "pending"
      # sender.balance -= @amount
      sender.withdrawal(@amount)
      # receiver.balance += @amount
      receiver.deposit(@amount)
      self.status = "complete"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
    # binding.pry
  end

  def reverse_transfer
    if self.valid? && receiver.balance > @amount && self.status == "complete"
      # receiver.balance -= @amount
      receiver.withdrawal(@amount)
      # sender.balance += @amount
      sender.deposit(@amount)
      self.status = "reversed"
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end
end

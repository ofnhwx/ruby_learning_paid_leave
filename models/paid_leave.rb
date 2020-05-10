# frozen_string_literal: true

require 'business_time'

class PaidLeave
  attr_accessor :accrued_at, :expires_at

  def initialize(date, limit = 25)
    @accrued_at = date
    @expires_at = limit.business_days.after(date)
  end

  def valid_on?(date)
    date >= @accrued_at && date < @expires_at
  end
end

# frozen_string_literal: true

require_relative './paid_leave'

class PaidLeaveApplication
  def initialize(date)
    @base_date = date
    @paid_leaves = [PaidLeave.new(date)]
    @acquired_paid_leaves = []
  end

  def application(date)
    return 'Bad Request' if bad_request?(date)

    update_base_date(date)

    until @paid_leaves.empty?
      paid_leave = @paid_leaves.shift
      if paid_leave.valid_on?(date)
        @acquired_paid_leaves << date
        return 'Accept'
      end
    end

    'Reject'
  end

  private

  def bad_request?(date)
    !date.workday? || @acquired_paid_leaves.include?(date)
  end

  def update_base_date(date)
    while date > @base_date
      tmp_base_date = 10.business_days.after(@base_date)
      return if tmp_base_date > date

      @base_date = tmp_base_date
      @paid_leaves << PaidLeave.new(@base_date)
    end
  end
end

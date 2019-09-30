module Hotel
  class DateRange
    class DateRangeError < StandardError; end
    
    def initialize(check_in_date, check_out_date)
      @check_in_date = check_in_date
      @check_out_date = check_out_date
    end

    def date_range_conflict?(desired_check_in, desired_check_out)
      if desired_check_in.between?(@check_in_date, @check_out_date - 1)
        return true
      elsif
        desired_check_out.between?(@check_in_date + 1, @check_out_date)
        return true
      else
        return false
      end
    end
    
  end
end

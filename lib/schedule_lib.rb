module ScheduleLib

  def schedule_attributes=(attrs)
    self.schedule = Schedule.find_or_initialize_by(attrs)
  end

  def paychecks(from = Time.now.to_date, to = Time.now.to_date)
    from = [from, start_date].max
    to = [to, end_date].min
    if schedule
      schedule.occurrences(from, to, start_date)
    else
      []
    end
  end

  def income(from = Time.now.to_date, to = Time.now.to_date)
    paychecks(from, to).size * amount
  end

end

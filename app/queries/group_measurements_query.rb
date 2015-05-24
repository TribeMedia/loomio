class GroupMeasurementsQuery
  def initialize(group: , metric: , max_age: )

  end

  def in_age_range
    #GroupMeasurement.select("period_end_on - groups.created_at::date as age, *").joins(:group).
                     #where('age < ?', max_age)
    #select current_date - created_at::date as age_in_days from groups limit 100;

  end
end

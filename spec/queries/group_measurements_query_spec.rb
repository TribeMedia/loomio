require 'rails_helper'

describe GroupMeasurementsQuery do
  context "query organsiation sessions for first 10 days" do
    before do
      count = 0
      date = 2.weeks.ago.to_date
      group = FactoryGirl.create :group, created_at: date

      while(date < Date.today) do
        count += 1
        date = date + 1.day
        GroupMeasurement.create(period_end_on: date,
                                group_id: group.id,
                                member_organisation_visits_count: count)

      end
    end

    it "gives results for age" do
      metric_name = 'member_organisation_visits_count'
      max_age = 10
      GroupMeasurement.joins(:group).age_less_than(10).order('period_end_on asc').each do |measurement|
        measurement.member_organisation_visits_count.should == measurement.age
      end
    end
  end
end

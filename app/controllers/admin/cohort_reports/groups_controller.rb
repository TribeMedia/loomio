class Admin::CohortReports::GroupsController < Admin::BaseController
  def show
    @group = Group.friendly.find(params[:id])
    @measurements = GroupMeasurement.joins(:group)
                                    .age_less_than(30)
                                    .where(group_id: @group.id)
                                    .order('period_end_on asc')
  end

  def cohort

  end
end

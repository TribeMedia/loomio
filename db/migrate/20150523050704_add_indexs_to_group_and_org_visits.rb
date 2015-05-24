class AddIndexsToGroupAndOrgVisits < ActiveRecord::Migration
  # oh the word is indices.. but too late now
  def change
    add_column :group_visits, :user_id, :integer
    add_column :group_visits, :member, :boolean, null: false, default: false
    add_index  :group_visits, :group_id
    add_index  :group_visits, :member

    add_column :organisation_visits, :user_id, :integer
    add_column :organisation_visits, :member, :boolean, null: false, default: false
    add_index  :organisation_visits, :organisation_id
    add_index  :organisation_visits, :member


    # fix the old data up
    queries = ['update group_visits set user_id = visits.user_id from visits where visits.id = group_visits.visit_id',
               'update organisation_visits set user_id = visits.user_id from visits where visits.id = organisation_visits.visit_id',
               'update group_visits v set member = true from memberships m where v.user_id = m.user_id and v.group_id = m.group_id',
               'update organisation_visits v set member = true from memberships m where v.user_id = m.user_id and v.organisation_id = m.group_id']

    queries.each do |query|
      ActiveRecord::Base.connection.execute query
    end

    ActiveRecord::Base.connection.execute "TRUNCATE TABLE group_measurements"
    add_column :group_measurements, :age, :integer, null: false

    #update_age_query = 'UPDATE group_measurements gm
                           #SET gm.age = (gm.period_end_on - g.created_at::date)
                          #FROM groups g WHERE gm.group_id = g.id'
    #ActiveRecord::Base.connection.execute update_age_query

    #change_column :group_measurements, :age, :integer, null: false
  end
end

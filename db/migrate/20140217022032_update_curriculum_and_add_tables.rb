class UpdateCurriculumAndAddTables < ActiveRecord::Migration
  def change
    # adding columns for curriculas
    add_column    :curriculas, :path,         :string
    add_column    :curriculas, :created_at,   :datetime
    add_column    :curriculas, :updated_at,   :datetime
    add_column    :curriculas, :private_flag, :boolean, default: false, null: false
    add_column    :curriculas, :creator_id,   :integer
    add_column    :curriculas, :namespace_id, :integer
    add_column    :curriculas, :can_merge,    :boolean, default: true,  null: false
    remove_column :curriculas, :cur_private
    remove_column :curriculas, :owner

    # adding columns for user
    add_column :users, :can_create_team, :boolean, default: true, null: false
    add_column :users, :can_create_organization, :boolean, default: true, null: false
    
  end
end

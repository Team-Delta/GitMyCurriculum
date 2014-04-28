class CreateCurriculas < ActiveRecord::Migration
  def change
    create_table(:curriculas) do |t|
    	 t.string    :cur_name,				null: false, default: '*subject to change*'
    	 t.text   	:cur_description
    	 t.boolean   :cur_private
    	 t.string	:owner
    end
  end
end

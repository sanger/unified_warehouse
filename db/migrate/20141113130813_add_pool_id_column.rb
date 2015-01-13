class AddPoolIdColumn < ActiveRecord::Migration
  def up
    change_table :iseq_flowcell do |t|

      t.column "id_pool_lims",     :string,  limit: 20, null: false, comment: "Most specific LIMs identifier associated with the pool"

    end
  end

  def down
    change_table :iseq_flowcell do |t|

      t.remove  "id_pool_lims",     :string,  limit: 20, null: false, comment: "Most specific LIMs identifier associated with the pool"

    end
  end
end

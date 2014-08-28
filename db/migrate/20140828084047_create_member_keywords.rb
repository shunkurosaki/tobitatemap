class CreateMemberKeywords < ActiveRecord::Migration
  def change
    create_table :member_keywords do |t|
      t.integer :member_id
      t.integer :keyword_id

      t.timestamps
    end
  end
end

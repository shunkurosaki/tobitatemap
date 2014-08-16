class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.string :city
      t.string :term
      t.string :link
      t.string :facebook
      t.string :twitter
      t.text :profile
      t.float :latitude
      t.float :longitude
      t.integer :user_id

      t.timestamps
    end
  end
end

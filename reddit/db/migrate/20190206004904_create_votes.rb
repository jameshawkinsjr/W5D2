class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.string :value, null: false
      t.references :voteable, polymorphic: true, index: true
      t.timestamps
    end
  end
end

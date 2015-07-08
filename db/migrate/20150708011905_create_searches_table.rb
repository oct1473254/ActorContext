class CreateSearchesTable < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.references :user, index: true, foreign_key: true
      t.references :actor, index: true, foreign_key: true
    end
  end
end

class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.string :title
      t.string :author
      t.string :guid
      t.references :library_id, index: true

      t.timestamps
    end
  end
end

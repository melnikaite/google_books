class DeleteBooks < ActiveRecord::Migration
  def up
    drop_table :books
  end

  def down
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :thumbnail

      t.timestamps
    end
  end
end

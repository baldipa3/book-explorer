class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :date_published
      t.string :publisher_name
      t.string :book_id
      t.references :csv_file, null: false, foreign_key: true

      t.timestamps
    end
  end
end

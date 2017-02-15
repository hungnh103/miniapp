class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.string :title
      t.text :content
      t.string :author
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :news, [:category_id, :created_at]
  end
end

class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.text :link
      t.string :pub_date
      t.boolean :read
      t.references :feed, null: false, foreign_key: true

      t.timestamps
    end
  end
end

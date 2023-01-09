class AddFormconfigurationToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :form_configurations, :text
  end
end

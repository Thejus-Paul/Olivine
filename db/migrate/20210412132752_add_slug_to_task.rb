# frozen_string_literal: true

class AddSlugToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :slug, :string
  end
end

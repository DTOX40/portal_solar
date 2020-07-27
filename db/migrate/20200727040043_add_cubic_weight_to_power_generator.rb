class AddCubicWeightToPowerGenerator < ActiveRecord::Migration[6.0]
  def change
    add_column :power_generators, :cubic_weight, :float
  end
end

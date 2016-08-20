class RenameNumVerticesToVertices < ActiveRecord::Migration
  def change
    rename_column :pets, :num_vertices, :vertices
  end
end

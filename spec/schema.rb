ActiveRecord::Schema.define(:version => 0) do
  create_table :products do |t|
    t.integer :price, :shipping, :default => 0, :null => false
  end
end

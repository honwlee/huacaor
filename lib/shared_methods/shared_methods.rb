module SharedMethods
	NAME_KINDS = ['latin', 'english', 'zh']
	NAME_KINDS.each do |n_k|
    define_method "#{n_k}_name" do
      self.name.nil? ? nil : self.name[n_k]
    end
  end
end
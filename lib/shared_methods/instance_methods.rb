module InstanceMethods
	NAME_KINDS = ['latin', 'en', 'zh']
	NAME_KINDS.each do |n_k|
    define_method "#{n_k}_name" do
      self.name[n_k]
    end
  end
end
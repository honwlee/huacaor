namespace :data do
  task :init => ['environment'] do
    puts "The current environment is #{Rails.env}"
  end

  task :get_plant_version_data => ['init'] do
    Plant.all.each do |plant|
    	version = Version.new
    	version.name = plant.name
    	version.points = 1
    	version.description = plant.description
    	version.user_id = User.first.id
      plant.versions << version
      version.save
      puts version.name
    end
  end

end
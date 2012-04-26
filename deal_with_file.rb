# encoding: utf-8
# encoding: utf-8
class DealWithDir
  def initialize(path)
    @path = path || `pwd`.chomp
    @rb_files = []
  end

  def add_line_to_file(file)
    `sed -ine '1i\# encoding: utf-8' #{file}`
  end

  def get_all_folder(path)
    Dir.entries(path).select{|f| !['.','..'].include?(f)}.collect{|f| path + '/' + f}
  end

  def get_all_file(path,file_type)
    i = 0
    get_all_folder(path).each do |f|
      i += 1
      if File.directory?(f)
        get_all_folder(f)
        get_all_file(f,file_type)
      else
        @rb_files << f if f.match(/#{file_type}$/)
      end
      puts i
    end
  end
  
  def rb_files
    @rb_files
  end

  def rm_file(file_type)
    rb_files.select{|file| file.match(/#{file_type}$/)}.each do |f|
      puts f
      FileUtils.rm f
    end
  end

end

path = "/srv/edoctor_cn_test/current"
rb = DealWithDir.new(path)
rb.get_all_file(path,".rb")
j = 0
rb.rb_files.each do |f|
  j += 1
  puts j
  puts f
  rb.add_line_to_file(f) if f.match(/.rb$/)
end

rb.get_all_file(path,".rbne")

rb.rm_file(".rbne")

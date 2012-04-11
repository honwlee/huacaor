#coding: utf-8
require 'ftools'
require 'nokogiri'
require "open-uri"
require "pp"
require "httpclient"
namespace :plants do 
  task :init => ['environment'] do
    puts "The current environment is #{Rails.env}"
  end

  desc "add base info for plants"
  task :base_info => ['init'] do
  	url = "http://zh.wikipedia.org/wiki/%E6%A4%8D%E7%89%A9%E5%88%86%E9%A1%9E%E8%A1%A8"
  	# url = "http://zh.wikipedia.org/zh-cn/%E6%A4%8D%E7%89%A9%E5%88%86%E7%B1%BB%E8%A1%A8"
  	# data = Nokogiri::HTML open(url)
  	data = Nokogiri::HTML(open(url)).search('.toc li a').collect{|d| d.content.split(' ')}
  	data.pop
  	phylum_datas = data.select{|p| p[0].to_i * 10 == p[0].to_f * 10}
  	data = data - phylum_datas
  	
  	sub_phylum_datas = data.select{|p| (p[0].delete('.').to_i > 20 && p[0].delete('.').to_i < 40) || (p[0].delete('.').to_i >80 && p[0].delete('.').to_i < 90)}
  	data = data - sub_phylum_datas
  	sub_class_datas = data.select{|p| p[0].delete('.').to_i > 8000}
  	class_datas = data - sub_class_datas
  	puts phylum_datas.inspect
  	puts 111111111111111111111
  	puts sub_phylum_datas.inspect
  	puts 222222222222222222222
  	puts class_datas.inspect
  	puts 33333333333333333
  	puts sub_class_datas.inspect

  	phylum_datas.each do |p_d|
  		# phylum = Phylum.new
  		# match_data = p_d[1].match(/(.*)\((.*)\)/)
  		# phylum.name = {:zh_name => match_data[1], :english_name => match_data[2]}
  		# phylum.save
  		class_datas.select{|c_d| c_d[0].delete('.').to_i > p_d[0].to_i * 100 && c_d[0].delete('.').to_i < (p_d[0].to_i + 1) * 100}.each do |c_data|
        pclass = Pclass.new
        if c_data.size > 2
          pclass.name = {:english_name => c_data[2], :zh_name => c_data[1]}
        else
        	pclass.name = {:english_name => c_data[1]}
        end
         phylum.pclasses << pclass
         pclass.save
  		end
  	end

  	sub_phylum_datas.each do |sp_d|
  		# phylum = Phylum.new
  		# phylum.name = {:zh_name => sp_d[2], :english_name => match_data[1]}
  		# phylum.usage = 1
  		# phylum.save
  	end
     
  end

  task :info => ['init'] do
  	url = 'http://www.nature-museum.net/ajaxserver/server.ashx?service=treedata&method=getsubsysbytaxonid&taxonid=9'
    # client = HTTPClient.new
    # content = client.get().content

    content = Nokogiri::HTML(open(url)).search('body p').collect{|d| d.content}

    base_data = content.first.split('";')
    resourse = base_data.delete_at(0)
    array_data = []
    i = 0
    base_data.each do |data|
      puts i
      i += 1
      match_data = data.match(/data\[\"(.*)\"\]=\"/)
      format_data = data.gsub(/data\[\"(.*)\"\]=\"/,"data:#{match_data[1]};")
      hash_data = Hash[format_data.split(';').collect{|a|a.gsub(/:/,',').split(',')}]
      hash_data["JSData"] = hash_data["JSData"].gsub(/\.\./,"http://www.nature-museum.net") if hash_data.has_key?("JSData")
      name = hash_data["text"].split(' ')
      puts "@" * 30
      puts Iconv.iconv("GBK//IGNORE", "UTF-8//IGNORE", name[0]) 
      puts "111111111111111111111111111111111111"
      plant_base_info = PlantBaseInfo.new
      plant_base_info.name = {:zh => name[0], :en => name[1]}
      plant_base_info.huar_home_id = i
      plant_base_info.save
      #create_plant_base_info(hash_data["JSData"],i * 1000) if hash_data.has_key?("JSData")
      array_data << hash_data
    end
    puts array_data.inspect
  end


  task :client_info => ['init'] do
    url = 'http://www.nature-museum.net/ajaxserver/server.ashx?service=treedata&method=getsubsysbytaxonid&taxonid=9'
    client = HTTPClient.new
    content = client.get(url).content
    data = content.split('";')
    hash_data = []
    data.each do |d|
      m_d = d.match(/data\[\"(.*)\"\]=\"/)
      hash_data << Hash[d.gsub(/data\[\"(.*)\"\]=\"/,"data:#{m_d[1]};").split(';').collect{|a|a.gsub(/:/,',').split(',')}]
    end
    i = 0
    delete_data = hash_data.select{|d| d['sp'] == nil}.first 
    hash_data.delete_if{|d| d['sp'] == nil}
    hash_data.each do |d|
      i += 1
      d["JSData"] = d["JSData"].gsub(/\.\./,"http://www.nature-museum.net") if d.has_key?("JSData")
      name = d['text'].split(' ')
      ids = d['data'].split('_')
      ids[0] = delete_data['data'].split('_')[0] if !delete_data.blank? && ids[0] == delete_data['data'].split('_')[1]
      plant_base_info = PlantBaseInfo.new
      plant_base_info.name = {:zh => name[0], :en => name[1]}
      plant_base_info.huar_home_id = ids[1]
      plant_base_info.parent_id = ids[0]
      plant_base_info.save
      if d.has_key?("JSData")
        other_content = client.get(d["JSData"]).content
        create_by_client(other_content,i * 1000) 
      end
    end
  end

  private
  def create_by_client(content,parent_id)
    data = content.split('";')
    hash_data = []
    data.each do |d|
      m_d = d.match(/data\[\"(.*)\"\]=\"/)
      hash_data << Hash[d.gsub(/data\[\"(.*)\"\]=\"/,"data:#{m_d[1]};").split(';').collect{|a|a.gsub(/:/,',').split(',')}]
    end
    j = 0
    delete_data = hash_data.select{|d| d['sp'] == nil}.first
    hash_data.delete_if{|d| d['sp'] == nil}
    hash_data.each do |d|
      j += 1
      d["JSData"] = d["JSData"].gsub(/\.\./,"http://www.nature-museum.net") if d.has_key?("JSData")
      name = d['text'].split(' ')
      ids = d['data'].split('_')
      ids[0] = delete_data['data'].split('_')[0] if !delete_data.blank? && ids[0] == delete_data['data'].split('_')[1]
      plant_base_info = PlantBaseInfo.new
      plant_base_info.name = {:zh => name[0], :en => name[1]}
      plant_base_info.huar_home_id = ids[1]
      plant_base_info.parent_id = ids[0]
      plant_base_info.save
    end
  end

  def create_plant_base_info(url,parent_id)
    content = Nokogiri::HTML(open(url)).search('body p').collect{|d| d.content}
    base_data = content.first.split('";')
    j = 0
    resourse = base_data.delete_at(0)
    base_data.delete_at(0) if base_data[0]["sp"].blank?
    base_data.each do |data|
      puts j
      j += 1
      match_data = data.match(/data\[\"(.*)\"\]=\"/)
      format_data = data.gsub(/data\[\"(.*)\"\]=\"/,"data:#{match_data[1]};")
      hash_data = Hash[format_data.split(';').collect{|a|a.gsub(/:/,',').split(',')}]
      hash_data["JSData"] = hash_data["JSData"].gsub(/\.\./,"http://www.nature-museum.net") if hash_data.has_key?("JSData")
      name = hash_data["text"].split(' ')
      p_info = PlantBaseInfo.new
      p_info.name = {:zh => name[0], :en => name[1]}
      p_info.huar_home_id = parent_id + j
      p_info.save
    end
  end
end

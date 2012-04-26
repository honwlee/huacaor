# encoding: utf-8
require 'fileutils'
require 'nokogiri'
require "open-uri"
require "pp"
require "httpclient"

######################## EXAMPLE ####################
# url = "http://image.baidu.com/i?lm=3&tn=baiduimage&ct=201326592&cl=2&word=%C2%CC%C9%AB%D6%B2%CE%EF+site%3Abaidu.com&istype=2&k1=%C2%CC%C9%AB%D6%B2%CE%EF&lmm=3&site=baidu.com+#z=3&width=&height=&pn=0"
# url = "http://image.baidu.com/i?ct=201326592&cl=2&lm=-1&tn=baiduimage&fr=&pv=&word=%C3%B5%B9%E5%BB%A8&istype=2&z=0&fm=rs1#z=3&width=&height=&lm=7&face=0"
# crawler = Crawler.new(url)
# uris = crawler.get_url(url)
# puts uris
# uris.each do |uri|
#   links = crawler.get_image_link(uri)
#   pp links
#   crawler.download(links)
#   sleep rand(3)
# end
######################## END #######################

class Crawler
  def initialize(url)
    @path = "/Users/vitoli/myspace/ISpace/pictures/#{Time.now.strftime("%d")}"
    FileUtils.mkdir @path unless File.exist? @path
    data = Nokogiri::HTML open(url + "&pn=0")
    #File.open(@path + "/data1.txt", "wb"){ |f| f.write data}
    data.search("div#resultInfo").each{ |d| @size = /(\w)(.)+(\w)/.match(d.content)[0].delete(',')}
    pagesize = (@size.to_f / 18).ceil
    @pagesize = pagesize > 10 ? 10 : pagesize
    @filenames = []
  end

  def get_url(url)
    puts @pagesize
    uris = []
    (0...@pagesize).each do |page|
      uris << (url + "&pn=18")
    end
    uris
  end

  def get_image_link(url)
    data = Nokogiri::HTML open(url)
    links = data.search('script').to_s.scan(/"objURL":"http:\/\/.*?\s",/).collect{ |c| c.match(/http:\/\/.*?\s/).to_s}
  end

  def download(links)
    i = 0
    links.uniq.each do |link|
      begin
        filename =  link.split('/').last
        puts filename
        puts i
        puts link
        puts @filenames.include?(filename)
        if @filenames.include?(filename)
          puts "you have the same filename"
          break
        else
          puts "well you are here"
          File.open(@path + "/" + filename, "wb"){ |f| f.write open(link.strip).read}
        end
        @filenames << filename
        i += 1
      rescue
        puts "something wrong in here"
        break
      end
    end
  end

  #def method_missing(m, *args, &block)
  #  options = args.extract_options!
  #end
end



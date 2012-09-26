require "pp"

class Mapping
  attr_reader :name, :filter, :products

  def initialize
    @name = []
    @filter = []
  end
  
  def parse_map
    maps = []
    filter = []

    File.foreach("#{Rails.root}/lib/mapping.map") do |line|
      unless line =~ /^[\s]*$\n|#/
        if line =~ /MAP: /
          maps << line.gsub("MAP: ", "").strip
          @name = maps
        else
          filter << line.gsub("MAP: ", "").strip
          @filter = filter
        end
      end
    end
    @name
    @filter
  end

  def group_map
    @group_map = Hash.new{|h,k| h[k] = []}

    @name.each do |name|
      @group_map["#{name}"] << @filter.select do |filter|
        if filter =~ /#{name}/
          filter
        end
      end
    end
  end
  
  def fetch_products
    @products = []

    @group_map.each_value do |value|
      value.flatten.each do |v|
        File.foreach("#{Rails.root}/lib/data.txt") do |line|
          if line.strip =~ /#{v}/
            @products << line.strip
          end
        end
      end
    end
  end

  def map_list
    @group_map.each_key do |group_list|
      group_list
    end
  end
end

 # map = Mapping.new
 #  map.parse_map
 #  map.group_map
 #  map.fetch_products
 #  map.map_list




################NOOOOOOOPE
# require "pp"
#
# class Mapping
#   attr_accessor :name, :filter
#
#   def parse_map
#     maps = []
#     filter = []
#     File.foreach("mapping.map") do |line|
#       unless line =~ /^[\s]*$\n|#/
#           if line =~ /MAP: /
#             # line.gsub("MAP: ", "").strip.each do |map|
#             #               #@group_map["#{map}"] << line.gsub("MAP: ", "").strip
#             #               #puts @group_map
#             #             end
#             maps << line.gsub("MAP: ", "").strip
#             @name = maps
#             #@group_map[:map] << line.gsub("MAP: ", "").strip
#             #puts @maps
#           else
#             filter << line.gsub("MAP: ", "").strip
#             @filter = filter
#           end
#       end
#     end
#     #puts @group_map.inspect
#   end
#
#
# end
#
# map = Mapping.new
# map.parse_map
# puts map.inspect
# #puts map.filter.inspect












# require "pp"
#
# class FilterMappingConfig
#   attr_accessor :name
#   attr_reader :filter
#
#   def initialize(name)
#     @name = name
#     @filter = []
#   end
#
#   def filter=(filter)
#     @filter << filter
#   end
# end
#
# class MapConfigFile
#   attr_accessor :map
#
#   def initialize
#     @map = []
#   end
#
#   def parse_mapping
#     File.foreach("mapping.map") do |line|
#       unless line =~ /^[\s]*$\n|#/
#         if line.include? "MAP: "
#           @map << FilterMappingConfig.new(line.gsub("MAP: ", "").strip)
#         else
#           unless @map.last.nil?
#             @map.last.filter = line.strip
#           end
#         end
#       end
#     end
#   end
#
#   def map
#     @map.each do |m|
#       puts m.name.filter
#     end
#   end
# end
#
# class DataProductsFile
#   attr_accessor :products
#
#   def initialize
#     @products = []
#   end
#
#   def store_data
#     File.foreach("data.txt") do |line|
#       @products = FilterMappingConfig.new(line.strip)
#     end
#   end
# end
#
# map = MapConfigFile.new
# map.parse_mapping
# map.map

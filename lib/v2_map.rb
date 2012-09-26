require "pp"
class Map
  attr_accessor :name, :filters

  def initialize(name)
    @name = name
    @filters = []
  end
end

class Mapping

  attr_accessor :mapping, :filtered_map, :unfiltered_map, :group_map, :ungroup_map

  def initialize
    @mapping = []
    @filtered_map = Hash.new{|h,k| h[k] = []}
    @unfiltered_map = Hash.new{|h,k| h[k] = []}
    @group_map = Hash.new{|h,k| h[k] = []}
    @ungroup_map = Hash.new{|h,k| h[k] = []}
    @mapped = {}
  end

  def parse_map
    File.foreach("#{Rails.root}/lib/mapping.map") do |line|
      unless line =~ /^[\s]*$\n|#/
        if line.include? "MAP: "
          @mapping << Map.new(line.gsub("MAP: ", "").strip)
        else
          unless @mapping.last.nil?
            @mapping.last.filters << line.strip
          end
        end
      end
    end
    @mapping
  end

  def parse_data
    self.parse_map.each do |map|
      map.filters.each do |filter|
        filter = filter.gsub(/\*/, "[a-zA-Z0-9;]*").gsub(/\?/,"[a-zA-Z0-9]")
        File.foreach("#{Rails.root}/lib/data.txt") do |line|
          if line.strip =~ /#{filter}/i
            @filtered_map["#{map.name}"] << line.strip
          end
          @unfiltered_map["#{line.strip}"] << line.strip
        end
      end
    end
    @filtered_map
    @unfiltered_map
  end
  
  def mapped
    @unfiltered_map.each_pair do |key,value|
      @group_map["#{key}"] << value.uniq.to_s
    end

    self.parse_map.each do |map|
      map.filters.each do |filter|
        filter = filter.gsub(/\*/, "[a-zA-Z0-9]*").gsub(/\?/, "[a-zA-Z0-9]")
        @group_map.delete_if do |k, v|
          k =~ /#{filter}/i
        end
      end
    end
    
    @mapped = @filtered_map.merge(@group_map)
    @mapped
  end
  
  def unmapped
    @unfiltered_map.each_pair do |key,value|
      @ungroup_map["#{key}"] << value.uniq.to_s
    end
    @ungroup_map
  end
  
  def add_map(map,filters)
    File.open("#{Rails.root}/lib/mapping.map", "a") do |file|
      file.puts "\n#{map}"
      file.puts "#{filters}"
    end
  end
  
end

# map = Mapping.new
# map.parse_data
# map.mapped
# map.unmapped
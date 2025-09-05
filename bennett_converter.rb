#Bennett
file = File.read('/Users/steinwam/Desktop/TEA Data for testing/BUonlySTEMribbon2.JSON')

data_hash = JSON.parse(file)

new_object = {:"STUDENTS" => []}

data_hash.each do |key, val|

  puts "******"
  puts val.inspect

  val["RECORDS"].each do |r|
    new_groups = []

    r["GROUPS"].each do|key, val|
      new_groups << { key => val }
    end

    r["GROUPS"] = new_groups

  end

  new_object[:"STUDENTS"] << val
end

File.open("/Users/steinwam/Desktop/TEA Data for testing/BUonlySTEMribbon2-fixed.JSON", 'w') { |file| file.write(new_object.to_json) }



#USASK

file = File.read('/Users/steinwam/Desktop/TEA Data for testing/USASK_ribbon_20150103.json')

data_hash = JSON.parse(file)

data_hash["STUDENTS"].select do |s|
  s["DEMOGRAPHICS"]["high_school_average_rounded"].present? && s["DEMOGRAPHICS"]["high_school_average"].present?

end.size

data_hash["STUDENTS"].each do |s|
  s["DEMOGRAPHICS"] = s["DEMOGRAPHICS"].except("NSID")

end
File.open("/Users/steinwam/Desktop/TEA Data for testing/USASK_ribbon_20150103.json", 'w') { |file| file.write(data_hash.to_json) }



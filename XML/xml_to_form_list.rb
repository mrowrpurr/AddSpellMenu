require "nokogiri"

def convert_xml_to_txt_with_form_ids_etc xml_filename, txt_filename
    xml = Nokogiri::XML(File.read xml_filename)
    text = ""

    items = xml.css("GRUP > *")
    items.each do |item|
        if item["id"]
            form_id = item["id"]
            editor_id = ""
            edit_node = item.css("EDID")
            if edit_node
                editor_id = edit_node.text
            end
            puts "FORM ID: #{form_id} EDITOR ID: #{editor_id}"
            text += "#{form_id}\t#{editor_id}\n"
        end
    end

    # Uncomment to play around with the XML
    # require "irb"
    # binding.irb

    File.write txt_filename, text
end

if ARGV.length != 2
    puts "Usage: bundle exec ruby xml_to_form_list.rb [filename.xml] [filename.txt]"
else
    convert_xml_to_txt_with_form_ids_etc ARGV[0], ARGV[1]
end
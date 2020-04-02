#---
# Excerpted from "Seven Databases in Seven Weeks",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/pwrdata for more book information.
#---

require 'time'

import 'org.apache.hadoop.hbase.client.HTable'
import 'org.apache.hadoop.hbase.client.Put'
import 'javax.xml.stream.XMLStreamConstants'
import 'org.apache.hadoop.hbase.client.ConnectionFactory'
import 'org.apache.hadoop.hbase.client.Put'
import 'org.apache.hadoop.hbase.CellBuilderFactory'
import 'org.apache.hadoop.hbase.CellBuilderType'
import 'org.apache.hadoop.hbase.Cell'

def jbytes(*args)
  args.map { |arg| arg.to_s.to_java_bytes }
end

def createcell(row,family,qual,text)
cb = CellBuilderFactory.create(CellBuilderType::DEEP_COPY)
cb.setRow(*jbytes(row))
cb.setFamily(*jbytes(family))
cb.setQualifier(*jbytes(qual))
cb.setType(4)
cb.setValue(*jbytes(text))
cell = cb.build()
return cell
end

factory = javax.xml.stream.XMLInputFactory.newInstance
reader = factory.createXMLStreamReader(java.lang.System.in)

document = nil
buffer = nil
count = 0



connection = ConnectionFactory.createConnection()
table = connection.getTable(TableName.valueOf("foods"))

while reader.has_next
  type = reader.next

  if type == XMLStreamConstants::START_ELEMENT

    case reader.local_name
	
    when 'Food_Display_Row' then document = {}
    else buffer = []
    end

  elsif type == XMLStreamConstants::CHARACTERS

    buffer << reader.text unless buffer.nil?

  elsif type == XMLStreamConstants::END_ELEMENT

    case reader.local_name
        
    when 'Food_Display_Row'
      key = document['Food_Code'].to_java_bytes
      
      p = Put.new(key)
	  
	  
	  p.add(createcell(key,"text","",document['Display_Name']))
	  
	  #Adding portions family
	  p.add(createcell(key,"portions","Default",document['Portion_Default']))
	  p.add(createcell(key,"portions","Amount",document['Portion_Amount']))
	  p.add(createcell(key,"portions","Display_Name",document['Portion_Display_Name']))
	  p.add(createcell(key,"portions","Factor",document['Factor']))
	  p.add(createcell(key,"portions","Increment",document['Increment']))
	  p.add(createcell(key,"portions","Multiplier",document['Multiplier']))
	  
	  
	  #Adding ingredients family
	  p.add(createcell(key,"ingredients","Whole_Grains",document['Whole_Grains']))
	  p.add(createcell(key,"ingredients","Vegetables",document['Vegetables']))
	  p.add(createcell(key,"ingredients","Orange_Vegetables",document['Orange_Vegetables']))
	  p.add(createcell(key,"ingredients","Drkgreen_Vegetables",document['Drkgreen_Vegetables']))
	  p.add(createcell(key,"ingredients","Starchy_vegetables",document['Starchy_vegetables']))
	  p.add(createcell(key,"ingredients","Other_Vegetables",document['Other_Vegetables']))
	  p.add(createcell(key,"ingredients","Fruits",document['Fruits']))
	  p.add(createcell(key,"ingredients","Milk",document['Milk']))
	  p.add(createcell(key,"ingredients","Meats",document['Meats']))
	  p.add(createcell(key,"ingredients","Soy",document['Soy']))
	  p.add(createcell(key,"ingredients","Drybeans_Peas",document['Drybeans_Peas']))
	  p.add(createcell(key,"ingredients","Oils",document['Oils']))
	  
	  #Adding nutrient family
	  p.add(createcell(key,"nutrient","Solid_Fats",document['Solid_Fats']))
	  p.add(createcell(key,"nutrient","Added_Sugars",document['Added_Sugars']))
  	  p.add(createcell(key,"nutrient","Alcohol",document['Alcohol']))
  	  p.add(createcell(key,"nutrient","Calories",document['Calories']))
  	  p.add(createcell(key,"nutrient","Saturated_Fats",document['Saturated_Fats']))
							  
      table.put(p)

      count += 1
      if count % 500 == 0
        puts "#{count} records inserted (#{document['title']})"
      end
	else
	document[reader.local_name] = buffer.join  
    end
	
	
  end
end

exit

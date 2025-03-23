import json
import csv

with open('/content/schacon.repos.json', 'r') as file:
    data = json.load(file)


#slicing data set to be the first five, then making a for-loop to collect entries, separated by commas
first_five = data[:5]


with open('chacon.csv', 'w', newline = '') as csvfile: 
  fieldnames = ['name', 'html_url', 'updated_at', 'visibility']
  writer = csv.DictWriter(csvfile, fieldnames = fieldnames)

  writer.writeheader()

  for entry in first_five:
    name_value = entry['name']
    html_value = entry['html_url']
    update = entry['updated_at']
    visible = entry['visibility']

    print(f"{name_value}, {html_value}, {update}, {visible}")

    writer.writerow({
      'name': name_value,
      'html_url': html_value,
      'updated_at': update, 
      'visibility': visible
  })



using Genie, CSV, DataFrames, Plots, Mustache

Genie.config.run_as_server = true
Genie.config.cors_headers["Access-Control-Allow-Origin"] = "http://localhost:8000"
# This has to be this way - you should not include ".../*"
Genie.config.cors_headers["Access-Control-Allow-Headers"] = "Content-Type"
Genie.config.cors_headers["Access-Control-Allow-Methods"] ="GET,POST,PUT,DELETE,OPTIONS" 
Genie.config.cors_allowed_origins = ["*"]

route("/") do
    # Render the template
    html_template = read("public/templates/index.html", String)
    rendered_html = render(html_template, Dict())
    return rendered_html
end

route("/generate/table") do 
    # Read only the first 10 rows of the CSV data into a DataFrame
    data = CSV.read("Data.csv", DataFrame)

	# Select only the first 10 rows
	data = first(data, 100)
    
    # Generate HTML table
    html_table = "<table class='table table-striped table-sm' border='1'>"
    html_table *= "<tr>"
    for col in names(data)
        html_table *= "<th>$col</th>"
    end
    html_table *= "</tr>"
    
    for row in eachrow(data)
        html_table *= "<tr>"
        for val in row
            html_table *= "<td>$val</td>"
        end
        html_table *= "</tr>"
    end
    
    html_table *= "</table>"
    
    return html_table
end


route("/generate/graph") do
	# Read CSV data into a DataFrame
	data = CSV.read("Data.csv", DataFrame)

	# Extract columns for year and value
	year_column = data[!, "Year"]
	value_column = data[!, "Value"]

	# Create a scatter plot
	plt = plot(year_column, value_column, xlabel = "Year", ylabel = "Value", title = "Year vs Value", legend = false)

	# Save the plot to an HTML file
	output_html = tempname() * ".html"
	savefig(plt, output_html)

	# Read the HTML file and return its content
	html_content = read(output_html, String)
	return html_content
end



# Start the Genie server 
Genie.config.run_as_server = true
Genie.up(8000, "0.0.0.0")

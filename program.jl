using Genie, CSV, DataFrames, Plots

route("/") do
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

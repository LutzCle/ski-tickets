module LoadData

export load_csv

function load_csv(file_::AbstractString)
    # Define number of file header lines
    const HEADER_LINES = 2

    # Read data file
    raw_data = readcsv(file_)

    # Parse header lines to title and labels
    plot_title = convert(UTF8String, raw_data[1,1])
    legend_labels = convert(Array{UTF8String, 1}, vec(raw_data[2, 2:end]))

    # Parse data lines and cast to Float32
    parsed_data = convert(Array{Float32, 2}, raw_data[(HEADER_LINES + 1):end, :])
    parsed_data = flipdim(parsed_data, 1)

    return (plot_title, legend_labels, parsed_data)
end

end


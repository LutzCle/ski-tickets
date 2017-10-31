#! /usr/bin/julia

# Define number of file header lines
const HEADER_LINES = 2

function plot_figure(data_file, figure_file)
    # Read data file
    raw_data = readcsv(data_file)

    # Parse header lines to title and labels
    plot_title = raw_data[1,1]
    ticket_labels = vec(raw_data[2, 2:end])

    # Parse data lines and cast to Float32
    ticket_prices = convert(Array{Float32, 2}, raw_data[(HEADER_LINES + 1):end, :])
    ticket_prices = flipdim(ticket_prices, 1)

    # Leave space for legend box
    max_price = maximum(ticket_prices[:, 2:end])
    ymax = max_price * 1.1

    # Plot
    plot(ticket_prices[:,1], ticket_prices[:,2:end], marker="x")
    ylim(ymin=0, ymax=ymax)
    title(plot_title)
    legend(ticket_labels, loc="lower right", fancybox=true, shadow=true, fontsize=8)
    savefig(figure_file)
end

plot_figure(ARGS[1], ARGS[2])


#!/usr/bin/julia

include("LoadData.jl")
include("Plotting.jl")

const data_path = "../data"
const save_path = "../plots"
const price_files = ["ski_season_prices", "ski_day_prices"]
const save_files = ["ski_season_inflation", "ski_day_inflation"]
const inflation_file = "inflation"
const data_extension = "csv"
const save_extensions = ["svg", "png"]
const legend_scale_factor = 1.1
const xlabel = "Year"
const ylabel = "Inflation (%)"

inflation_file_path = joinpath(data_path, "$inflation_file.$data_extension")

println("Loading data from $inflation_file_path")
(inflation_title, inflation_label, inflation_rates) = LoadData.load_csv(inflation_file_path)

for (price_file, save_file) in zip(price_files, save_files)
    cur_file = joinpath(data_path, "$price_file.$data_extension")

    println("Loading data from $cur_file")
    (figure_title, ticket_labels, ticket_prices) = LoadData.load_csv(cur_file)

    legend_labels = vcat(inflation_label, ticket_labels)
    xcoords = ticket_prices[2:end, 1]

    divisors = circshift(ticket_prices, [1, 0])
    price_inflation = ticket_prices ./ divisors
    price_inflation = (price_inflation - 1.0) * 100.0

    ycoords = hcat(inflation_rates[2:end, 2], price_inflation[2:end, 2:end])

    for ext in save_extensions
        cur_save = joinpath(save_path, "$save_file.$ext")
        println("Plotting to $cur_save")

        Plotting.plot_lines(
                   xcoords,
                   ycoords,
                   figure_title,
                   xlabel,
                   ylabel,
                   legend_labels,
                   legend_scale_factor,
                   cur_save)

        PyPlot.hold(false)
    end
end


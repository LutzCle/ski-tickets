#!/usr/bin/julia

include("LoadData.jl")
include("Plotting.jl")

const data_path = "../data"
const save_path = "../plots"
const data_files = ["ski_season_prices", "ski_day_prices"]
const data_extension = "csv"
const save_extensions = ["svg", "png"]
const legend_scale_factor = 1.1
const xlabel = "Year"
const ylabel = "Price (€)"

for file in data_files
    cur_file = joinpath(data_path, "$file.$data_extension")
    println("Loading data from $cur_file")

    (figure_title, legend_labels, ticket_prices) = LoadData.load_csv(cur_file)

    for ext in save_extensions
        cur_save = joinpath(save_path, "$file.$ext")
        println("Plotting to $cur_save")

        Plotting.plot_lines(
                   ticket_prices[:, 1],
                   ticket_prices[:, 2:end],
                   figure_title,
                   xlabel,
                   ylabel,
                   legend_labels,
                   legend_scale_factor,
                   cur_save)
    end
end


module Plotting

#Pkg.add("PyPlot")
using PyPlot

export plot_lines

function plot_lines{T<:AbstractFloat, R<:AbstractFloat, S<:AbstractString}(
                     x_coords_::Array{T, 1},
                     y_coords_::Array{R, 2},
                     figure_title_::AbstractString,
                     xlabel_::AbstractString,
                     ylabel_::AbstractString,
                     legend_labels_::Array{S, 1},
                     legend_scale_factor::AbstractFloat,
                     save_file_::AbstractString)

    # Leave space for legend box
    ymax = maximum(y_coords_) * legend_scale_factor

    # Plot
    plot(x_coords_, y_coords_, marker="x")
    ylim(ymin=0, ymax=ymax)
    title(figure_title_)
    xlabel(xlabel_)
    ylabel(ylabel_)
    legend(legend_labels_, loc="lower right", fancybox=true, shadow=true, fontsize=8)
    savefig(save_file_)
end

end


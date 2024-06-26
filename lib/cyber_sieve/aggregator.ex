defmodule CyberSieve.Aggregator do
  @moduledoc """
  Provides data aggregation functionality for CyberSieve.
  """

  @type scraped_data :: %{text: String.t()}
  @type aggregated_data :: %{word_count: map()}

  @spec aggregate_data([scraped_data]) :: {:ok, aggregated_data} | {:error, String.t()}
  def aggregate_data(scraped_data_list) do
    try do
      aggregated =
        scraped_data_list
        |> Enum.map(& &1.text)
        |> Enum.join(" ")
        |> String.split(~r/\s+/)
        |> Enum.frequencies()

      {:ok, %{word_count: aggregated}}
    rescue
      e in RuntimeError -> {:error, "Aggregation failed: #{inspect(e)}"}
    end
  end
end

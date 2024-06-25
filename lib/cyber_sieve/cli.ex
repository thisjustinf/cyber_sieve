defmodule CyberSieve.CLI do
  def main(args) do
    args
    |> parse_args()
    |> process()
  end

  defp parse_args(args) do
    {opts, _, _} =
      OptionParser.parse(args,
        switches: [action: :string, url: :string]
      )

    opts
  end

  defp process(action: "scrape", url: url) do
    CyberSieve.Scraper.scrape_website(url)
  end

  defp process(action: "aggregate") do
    CyberSieve.Aggregator.aggregate_data()
  end

  defp process(_) do
    IO.puts("Usage: cyber_sieve --action scrape --url URL")
    IO.puts("       cyber_sieve --action aggregate")
  end
end

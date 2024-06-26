defmodule CyberSieve.CLI do

  @type args :: [String.t()]

  @spec main([binary()]) :: nil | :ok | {:error, <<_::64, _::_*8>>} | {:ok, %{text: binary()}}
  def main(args) do
    args
    |> parse_args()
    |> process()
  end

  @spec parse_args(args) :: Keyword.t()
  defp parse_args(args) do
    {opts, _, _} =
      OptionParser.parse(args,
        switches: [action: :string, url: :string]
      )

    opts
  end

  @spec process(Keyword.t()) :: :ok
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

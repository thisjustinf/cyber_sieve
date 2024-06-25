defmodule CyberSieve.Scraper do
  require Logger

  @spec scrape_website(String.t()) :: {:ok, %{text: String.t()}} | {:error, String.t()}
  def scrape_website(url) do
    with {:ok, html} <- fetch_html(url),
         {:ok, parsed_html} <- parse_html(html),
         {:ok, data} <- extract_data(parsed_html) do
      {:ok, data}
    else
      {:error, reason} ->
        Logger.error("Scraping failed: #{inspect(reason)}")
        {:error, reason}
    end
  end

  @spec fetch_html(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  defp fetch_html(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:error, "HTTP request failed with status code: #{status_code}"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "HTTP request failed: #{inspect(reason)}"}
    end
  end

  @spec parse_html(binary()) :: {:ok, String.t()} | {:error, String.t()}
  defp parse_html(html) do
    case Floki.parse_document(html) do
      {:ok, document} -> {:ok, document}
      {:error, reason} -> {:error, "HTML parsing failed: #{inspect(reason)}"}
    end
  end

  @spec extract_data(binary()) :: {:ok, %{text: String.t()}}
  defp extract_data(parsed_html) do
    text = Floki.text(parsed_html)
    {:ok, %{text: text}}
  end
end
